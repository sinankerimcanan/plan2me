import 'package:freezed_annotation/freezed_annotation.dart';

part 'place.freezed.dart';
part 'place.g.dart';

/// Görev veya projenin konumu: görünen ad/adres ve (varsa) koordinatlar.
/// Koordinat yoksa haritalarda ad ile arama yapılır.
@freezed
abstract class Place with _$Place {
  const Place._();

  const factory Place({
    required String name,
    double? latitude,
    double? longitude,
  }) = _Place;

  factory Place.fromJson(Map<String, dynamic> json) => _$PlaceFromJson(json);

  bool get hasCoordinates => latitude != null && longitude != null;

  /// Veritabanı kolonlarından; ad boşsa konum yok sayılır.
  static Place? fromColumns(
    String? name,
    double? latitude,
    double? longitude,
  ) => (name == null || name.trim().isEmpty)
      ? null
      : Place(name: name, latitude: latitude, longitude: longitude);
}
