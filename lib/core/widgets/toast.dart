import 'package:flutter/material.dart';

/// Uygulama genelinde snackbar için anahtar (MaterialApp.router'a verilir).
/// Sayfa kapandıktan sonra bile (ör. silip geri dönünce) "Geri al" gösterebilmek için.
final rootMessengerKey = GlobalKey<ScaffoldMessengerState>();

/// Kısa bilgi mesajı; [onUndo] verilirse "Geri al" düğmesi eklenir.
void showToast(String message, {String? undoLabel, VoidCallback? onUndo}) {
  final messenger = rootMessengerKey.currentState;
  if (messenger == null) return;
  messenger
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: onUndo == null ? 2 : 5),
        action: onUndo == null
            ? null
            : SnackBarAction(label: undoLabel ?? 'Geri al', onPressed: onUndo),
      ),
    );
}
