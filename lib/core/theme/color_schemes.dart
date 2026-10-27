import 'package:flutter/material.dart';

/// Ilık lime / yeşil-sarımtırak seed. Tüm tema bu renkten türer.
const kSeedColor = Color(0xFFB5D334);

ColorScheme buildLightScheme() =>
    ColorScheme.fromSeed(
      seedColor: kSeedColor,
      // tonalSpot lime'ı soluklaştırır; fidelity seed'e sadık kalır.
      dynamicSchemeVariant: DynamicSchemeVariant.fidelity,
    ).copyWith(
      primary: const Color(0xFF4E7A0B),
      onPrimary: Colors.white,
      primaryContainer: const Color(0xFFD6EE8F),
      onPrimaryContainer: const Color(0xFF1C2E00),
      secondary: const Color(0xFF5E6B3E),
      secondaryContainer: const Color(0xFFE2EBC2),
      tertiary: const Color(0xFFB08A12),
      tertiaryContainer: const Color(0xFFFBE7A1),
      onTertiaryContainer: const Color(0xFF3A2C00),
      surface: const Color(0xFFF8FBEE),
      onSurface: const Color(0xFF1B1F14),
      onSurfaceVariant: const Color(0xFF4A5240),
      surfaceContainerLowest: const Color(0xFFFFFFFF),
      surfaceContainerLow: const Color(0xFFF2F7E3),
      surfaceContainer: const Color(0xFFEAF2D6),
      surfaceContainerHigh: const Color(0xFFE1ECC8),
      surfaceContainerHighest: const Color(0xFFD8E5BB),
      outlineVariant: const Color(0xFFCAD6AE),
    );

ColorScheme buildDarkScheme() =>
    ColorScheme.fromSeed(
      seedColor: kSeedColor,
      brightness: Brightness.dark,
      dynamicSchemeVariant: DynamicSchemeVariant.fidelity,
    ).copyWith(
      primary: const Color(0xFFB8E356),
      onPrimary: const Color(0xFF213600),
      primaryContainer: const Color(0xFF3A5410),
      onPrimaryContainer: const Color(0xFFD6EE8F),
      secondary: const Color(0xFFC3CFA0),
      secondaryContainer: const Color(0xFF3A4428),
      tertiary: const Color(0xFFE9C552),
      tertiaryContainer: const Color(0xFF574400),
      onTertiaryContainer: const Color(0xFFFBE7A1),
      surface: const Color(0xFF111510),
      onSurface: const Color(0xFFE3E9D8),
      onSurfaceVariant: const Color(0xFFBFC8AE),
      surfaceContainerLowest: const Color(0xFF0C0F0B),
      surfaceContainerLow: const Color(0xFF161B13),
      surfaceContainer: const Color(0xFF1C2318),
      surfaceContainerHigh: const Color(0xFF232B1E),
      surfaceContainerHighest: const Color(0xFF2B3425),
      outlineVariant: const Color(0xFF3B4632),
    );

/// Kişi avatarları, etiketler ve sütunlar için seçilebilir renkler.
const kPalette = <String>[
  '#7CB342', // yeşil
  '#C0CA33', // lime
  '#FDD835', // sarı
  '#FFB300', // amber
  '#FB8C00', // turuncu
  '#E53935', // kırmızı
  '#D81B60', // pembe
  '#8E24AA', // mor
  '#5E35B1', // çivit
  '#1E88E5', // mavi
  '#00ACC1', // camgöbeği
  '#00897B', // deniz yeşili
  '#6D4C41', // kahve
  '#757575', // gri
];

Color colorFromHex(String? hex, {Color fallback = const Color(0xFF7CB342)}) {
  if (hex == null) return fallback;
  final clean = hex.replaceFirst('#', '');
  final value = int.tryParse(clean.length == 6 ? 'FF$clean' : clean, radix: 16);
  return value == null ? fallback : Color(value);
}

/// Arka plan rengine göre okunaklı metin rengi.
Color onColor(Color c) =>
    ThemeData.estimateBrightnessForColor(c) == Brightness.dark
    ? Colors.white
    : const Color(0xFF1B1F14);
