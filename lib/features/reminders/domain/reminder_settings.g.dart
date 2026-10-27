// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reminder_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ReminderSettings _$ReminderSettingsFromJson(Map<String, dynamic> json) =>
    _ReminderSettings(
      enabled: json['enabled'] as bool? ?? false,
      hour: (json['hour'] as num?)?.toInt() ?? 9,
      minute: (json['minute'] as num?)?.toInt() ?? 0,
      dayBefore: json['dayBefore'] as bool? ?? true,
      dailyDigest: json['dailyDigest'] as bool? ?? true,
    );

Map<String, dynamic> _$ReminderSettingsToJson(_ReminderSettings instance) =>
    <String, dynamic>{
      'enabled': instance.enabled,
      'hour': instance.hour,
      'minute': instance.minute,
      'dayBefore': instance.dayBefore,
      'dailyDigest': instance.dailyDigest,
    };
