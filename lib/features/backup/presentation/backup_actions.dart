import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/l10n/l10n.dart';
import '../../../core/widgets/common.dart';
import '../../../core/widgets/toast.dart';
import '../data/backup_service.dart';

/// Tüm veriyi JSON dosyasına yazar ve paylaşım sayfasını açar
/// (Dosyalar'a kaydet, iCloud, AirDrop, e-posta…).
Future<void> exportBackup(BuildContext context, WidgetRef ref) async {
  final l = context.l10n;
  final box = context.findRenderObject() as RenderBox?;
  try {
    final json = await ref.read(backupServiceProvider).exportJson();
    final now = DateTime.now();
    String two(int v) => v.toString().padLeft(2, '0');
    final name =
        'plan2me-yedek-${now.year}-${two(now.month)}-${two(now.day)}-${two(now.hour)}${two(now.minute)}.json';
    final file = File('${(await getTemporaryDirectory()).path}/$name');
    await file.writeAsString(json, encoding: utf8);
    await SharePlus.instance.share(
      ShareParams(
        files: [XFile(file.path, mimeType: 'application/json')],
        subject: l.backupShareSubject,
        sharePositionOrigin: box == null
            ? null
            : box.localToGlobal(Offset.zero) & box.size,
      ),
    );
  } catch (e) {
    if (context.mounted) showError(context, e);
  }
}

/// Yedek dosyası seçtirir, özetini gösterip onay alır ve geri yükler.
Future<void> importBackup(BuildContext context, WidgetRef ref) async {
  final l = context.l10n;
  final service = ref.read(backupServiceProvider);
  try {
    final picked = await FilePicker.pickFile(
      type: FileType.custom,
      allowedExtensions: const ['json'],
    );
    if (picked == null) return;
    final json = utf8.decode(await picked.readAsBytes());
    final summary = service.inspect(json);
    if (!context.mounted) return;
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l.backupImportConfirmTitle),
        content: Text(
          l.backupImportConfirmBody(
            summary.projects,
            summary.cards,
            summary.persons,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l.commonCancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(l.trashRestore),
          ),
        ],
      ),
    );
    if (ok != true) return;
    await service.importJson(json);
    showToast(l.backupImported);
  } on BackupFormatException catch (e) {
    if (context.mounted) showError(context, e.message);
  } catch (e) {
    if (context.mounted) showError(context, e);
  }
}
