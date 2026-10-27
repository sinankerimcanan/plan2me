import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../l10n/l10n.dart';
import '../theme/color_schemes.dart';
import '../theme/glass.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
    required this.icon,
    required this.title,
    this.body,
    this.action,
  });

  final IconData icon;
  final String title;
  final String? body;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: GlassSurface(
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: theme.colorScheme.primaryContainer,
                ),
                child: Icon(
                  icon,
                  size: 36,
                  color: theme.colorScheme.onPrimaryContainer,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                title,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              if (body != null) ...[
                const SizedBox(height: 6),
                Text(
                  body!,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
              if (action != null) ...[const SizedBox(height: 18), action!],
            ],
          ),
        ),
      ),
    );
  }
}

/// AsyncValue için yükleniyor / hata / veri görünümü.
class AsyncView<T> extends StatelessWidget {
  const AsyncView({super.key, required this.value, required this.data});

  final AsyncValue<T> value;
  final Widget Function(T data) data;

  @override
  Widget build(BuildContext context) => switch (value) {
    AsyncData(:final value) => data(value),
    AsyncError(:final error) => Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Text(
          context.l10n.errorGeneric(error),
          textAlign: TextAlign.center,
        ),
      ),
    ),
    _ => const Center(child: CircularProgressIndicator()),
  };
}

/// Silme onayı. true dönerse sil.
Future<bool> confirmDelete(BuildContext context, String body) async {
  final l = context.l10n;
  final result = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(l.commonDeleteTitle),
      content: Text(body),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text(l.commonCancel),
        ),
        FilledButton(
          style: FilledButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.error,
            foregroundColor: Theme.of(context).colorScheme.onError,
          ),
          onPressed: () => Navigator.pop(context, true),
          child: Text(l.commonDelete),
        ),
      ],
    ),
  );
  return result ?? false;
}

/// Hata mesajını snackbar ile göster.
void showError(BuildContext context, Object error) {
  ScaffoldMessenger.maybeOf(context)
      ?.showSnackBar(SnackBar(content: Text(context.l10n.errorGeneric(error))));
}

class ColorPalettePicker extends StatelessWidget {
  const ColorPalettePicker({
    super.key,
    required this.selected,
    required this.onChanged,
    this.allowNone = false,
  });

  final String? selected;
  final ValueChanged<String?> onChanged;
  final bool allowNone;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    Widget swatch({
      required Color? color,
      required bool isSelected,
      required VoidCallback onTap,
    }) => GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        width: 34,
        height: 34,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color ?? scheme.surfaceContainerHighest,
          border: Border.all(
            color: isSelected ? scheme.onSurface : Colors.transparent,
            width: 2.5,
          ),
        ),
        child: isSelected
            ? Icon(
                Icons.check_rounded,
                size: 18,
                color: color == null ? scheme.onSurface : onColor(color),
              )
            : (color == null
                  ? Icon(
                      Icons.block_rounded,
                      size: 16,
                      color: scheme.onSurfaceVariant,
                    )
                  : null),
      ),
    );
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
        if (allowNone)
          swatch(
            color: null,
            isSelected: selected == null,
            onTap: () => onChanged(null),
          ),
        for (final hex in kPalette)
          swatch(
            color: colorFromHex(hex),
            isSelected: selected == hex,
            onTap: () => onChanged(hex),
          ),
      ],
    );
  }
}

/// Başlık + içerik bölümü (detay ekranları için).
class SectionHeader extends StatelessWidget {
  const SectionHeader(this.title, {super.key, this.trailing, this.icon});

  final String title;
  final Widget? trailing;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 18, 4, 8),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(icon, size: 18, color: theme.colorScheme.primary),
            const SizedBox(width: 8),
          ],
          Expanded(
            child: Text(
              title,
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w700,
                color: theme.colorScheme.onSurfaceVariant,
                letterSpacing: 0.2,
              ),
            ),
          ),
          ?trailing,
        ],
      ),
    );
  }
}

/// Odak kaybında / Enter'da değeri işleyen metin alanı. Dışarıdan gelen değer,
/// alan odakta değilken senkronlanır (canlı stream'lerle uyumlu).
class CommitTextField extends StatefulWidget {
  const CommitTextField({
    super.key,
    required this.value,
    required this.onCommit,
    this.decoration,
    this.style,
    this.maxLines = 1,
    this.minLines,
    this.textInputAction,
  });

  final String value;
  final ValueChanged<String> onCommit;
  final InputDecoration? decoration;
  final TextStyle? style;
  final int? maxLines;
  final int? minLines;
  final TextInputAction? textInputAction;

  @override
  State<CommitTextField> createState() => _CommitTextFieldState();
}

class _CommitTextFieldState extends State<CommitTextField> {
  late final TextEditingController _controller = TextEditingController(
    text: widget.value,
  );
  final FocusNode _focus = FocusNode();

  @override
  void initState() {
    super.initState();
    _focus.addListener(() {
      if (!_focus.hasFocus) _commit();
    });
  }

  @override
  void didUpdateWidget(CommitTextField old) {
    super.didUpdateWidget(old);
    if (!_focus.hasFocus && widget.value != _controller.text) {
      _controller.text = widget.value;
    }
  }

  void _commit() {
    if (_controller.text != widget.value) widget.onCommit(_controller.text);
  }

  @override
  void dispose() {
    _controller.dispose();
    _focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => TextField(
    controller: _controller,
    focusNode: _focus,
    decoration: widget.decoration,
    style: widget.style,
    maxLines: widget.maxLines,
    minLines: widget.minLines,
    textInputAction: widget.textInputAction,
    onSubmitted: (_) => _commit(),
  );
}
