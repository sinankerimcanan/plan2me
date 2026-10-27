import 'package:map_launcher/map_launcher.dart' as ml;

import '../../../core/domain/place.dart';

/// Konumu harita uygulamalarında açar (Apple Haritalar, Google Haritalar,
/// Yandex, Waze…). Yüklü olmayanlar web sürümüne düşer.
abstract final class MapsService {
  /// Türkiye'de yaygın olanlar; sıra seçim listesindeki sıradır.
  static const apps = <ml.MapApp>[
    ml.MapApp.apple,
    ml.MapApp.google,
    ml.MapApp.yandexMaps,
    ml.MapApp.yandexNavi,
    ml.MapApp.waze,
  ];

  static ml.Location _target(Place p) => p.hasCoordinates
      ? ml.LocationCoords(p.latitude!, p.longitude!, title: p.name)
      : ml.Location.search(p.name);

  /// [directions] true ise yol tarifi, değilse işaretçi.
  static Future<List<ml.SupportedMap>> supportedMaps(
    Place place, {
    bool directions = false,
  }) {
    final target = _target(place);
    return directions
        ? ml.MapLauncher.directions(target).getSupportedMaps(apps)
        : ml.MapLauncher.marker(target, zoom: 16).getSupportedMaps(apps);
  }

  /// Türkçe görünen ad (paket İngilizce adlar döner).
  static String displayName(ml.MapApp app) => switch (app) {
    ml.MapApp.apple => 'Apple Haritalar',
    ml.MapApp.google => 'Google Haritalar',
    ml.MapApp.yandexMaps => 'Yandex Haritalar',
    ml.MapApp.yandexNavi => 'Yandex Navigasyon',
    _ => app.name,
  };
}
