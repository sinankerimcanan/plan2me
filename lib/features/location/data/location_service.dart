import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart' as gc;
import 'package:geolocator/geolocator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/domain/place.dart';

part 'location_service.g.dart';

enum LocationFailure { serviceDisabled, denied, deniedForever, unavailable }

class LocationException implements Exception {
  LocationException(this.reason);
  final LocationFailure reason;
  @override
  String toString() => 'LocationException($reason)';
}

/// Cihaz konumu ve adres arama (platform geocoder'ı; API anahtarı gerekmez).
abstract interface class LocationService {
  /// Mevcut konum ve okunabilir adresi. İzin yoksa ister.
  Future<Place> currentPlace();

  /// Serbest metinle adres/yer araması; en fazla birkaç sonuç.
  Future<List<Place>> search(String query);
}

class DeviceLocationService implements LocationService {
  final _geocoding = gc.Geocoding();

  @override
  Future<Place> currentPlace() async {
    if (!await Geolocator.isLocationServiceEnabled()) {
      throw LocationException(LocationFailure.serviceDisabled);
    }
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.denied) {
      throw LocationException(LocationFailure.denied);
    }
    if (permission == LocationPermission.deniedForever) {
      throw LocationException(LocationFailure.deniedForever);
    }
    try {
      final pos = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          timeLimit: Duration(seconds: 15),
        ),
      );
      return Place(
        name:
            await _describe(pos.latitude, pos.longitude) ??
            formatCoordinates(pos.latitude, pos.longitude),
        latitude: pos.latitude,
        longitude: pos.longitude,
      );
    } catch (e) {
      debugPrint('Konum alınamadı: $e');
      throw LocationException(LocationFailure.unavailable);
    }
  }

  @override
  Future<List<Place>> search(String query) async {
    final q = query.trim();
    if (q.isEmpty) return const [];
    try {
      final locations = await _geocoding.locationFromAddress(q);
      final results = <Place>[];
      for (final l in locations.take(4)) {
        results.add(
          Place(
            name: await _describe(l.latitude, l.longitude) ?? q,
            latitude: l.latitude,
            longitude: l.longitude,
          ),
        );
      }
      return results;
    } catch (e) {
      // Bulunamadı ya da çevrimdışı: boş liste (kullanıcı yazdığını olduğu gibi kaydedebilir).
      debugPrint('Adres araması başarısız: $e');
      return const [];
    }
  }

  Future<String?> _describe(double lat, double lng) async {
    try {
      final marks = await _geocoding.placemarkFromCoordinates(lat, lng);
      return marks.isEmpty ? null : formatPlacemark(marks.first);
    } catch (_) {
      return null;
    }
  }
}

/// "Sokak No, Mahalle, İlçe/İl" biçiminde, tekrarsız adres metni.
String? formatPlacemark(gc.Placemark p) {
  final street = [
    p.thoroughfare,
    p.subThoroughfare,
  ].whereType<String>().where((s) => s.trim().isNotEmpty).join(' ');
  final parts = <String>[];
  for (final part in [
    if (p.name != null &&
        p.name != p.thoroughfare &&
        p.name != p.subThoroughfare)
      p.name,
    street,
    p.subLocality,
    p.locality ?? p.subAdministrativeArea,
    p.administrativeArea,
  ]) {
    final t = part?.trim();
    if (t != null &&
        t.isNotEmpty &&
        !parts.contains(t) &&
        !parts.any((x) => x.contains(t))) {
      parts.add(t);
    }
  }
  return parts.isEmpty ? null : parts.take(4).join(', ');
}

String formatCoordinates(double lat, double lng) =>
    '${lat.toStringAsFixed(5)}, ${lng.toStringAsFixed(5)}';

@Riverpod(keepAlive: true)
LocationService locationService(Ref ref) => DeviceLocationService();
