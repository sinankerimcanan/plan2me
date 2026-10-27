import 'package:freezed_annotation/freezed_annotation.dart';

part 'person.freezed.dart';
part 'person.g.dart';

@freezed
abstract class Person with _$Person {
  const Person._();

  const factory Person({
    required String id,
    required String name,
    String? email,
    String? role,
    String? colorHex,
    @Default(false) bool isMe,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Person;

  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);

  /// Avatar için baş harfler (en fazla 2).
  String get initials {
    final parts = name.trim().split(RegExp(r'\s+')).where((p) => p.isNotEmpty);
    if (parts.isEmpty) return '?';
    final first = parts.first;
    final letters = parts.length == 1
        ? first.substring(0, first.length < 2 ? first.length : 2)
        : '${first[0]}${parts.last[0]}';
    // Türkçe büyük harf: i → İ, ı → I
    return letters.replaceAll('i', 'İ').replaceAll('ı', 'I').toUpperCase();
  }
}

/// Kişiler ekranı için kişi + kaç projede yer aldığı.
@freezed
abstract class PersonOverview with _$PersonOverview {
  const factory PersonOverview({
    required Person person,
    @Default(0) int responsibleCount,
    @Default(0) int requestedCount,
  }) = _PersonOverview;
}

/// Kişi oluşturma / düzenleme girdisi.
@freezed
abstract class PersonInput with _$PersonInput {
  const factory PersonInput({
    required String name,
    String? email,
    String? role,
    String? colorHex,
    @Default(false) bool isMe,
  }) = _PersonInput;
}
