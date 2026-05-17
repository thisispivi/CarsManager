import 'package:cars_manager/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

/// A consistent back-navigation button used across screens.
///
/// Renders as a pill-shaped tonal filled button with a left-arrow icon and
/// localised "Back" label. The tonal style deliberately differs from the
/// primary [FilledButton] used for save/confirm actions, giving the pair a
/// clear visual hierarchy while sharing the same pill shape.
class AppBackButton extends StatelessWidget {
  const AppBackButton({super.key, this.onPressed, this.label});

  final VoidCallback? onPressed;

  /// Optional custom label. Defaults to the localised "Back" string.
  final String? label;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final effectiveOnPressed =
        onPressed ?? () => Navigator.of(context).maybePop();

    return OutlinedButton.icon(
      onPressed: effectiveOnPressed,
      icon: const Icon(Icons.arrow_back_rounded, size: 18),
      label: Text(label ?? l10n.common_back),
    );
  }
}
