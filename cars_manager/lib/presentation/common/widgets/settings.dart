import 'package:cars_manager/core/theme/app_colors.dart';
import 'package:cars_manager/core/theme/app_dimensions.dart';
import 'package:cars_manager/features/analytics/domain/export_service.dart';
import 'package:cars_manager/features/garage/domain/cars_notifier.dart';
import 'package:cars_manager/features/settings/domain/settings_notifier.dart';
import 'package:cars_manager/l10n/app_localizations.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SettingsDrawer extends StatelessWidget {
  const SettingsDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Drawer(child: SettingsContent());
  }
}

class SettingsContent extends ConsumerWidget {
  const SettingsContent({
    super.key,
    this.scrollController,
    this.showCloseButton = true,
  });

  final ScrollController? scrollController;
  final bool showCloseButton;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final settings = ref.watch(appSettingsProvider);
    final cars = ref.watch(carsControllerProvider);
    final theme = Theme.of(context);

    Future<void> exportData() async {
      final csv = ExportService.carsToCSV(cars);
      final filename =
          'cars_export_${DateTime.now().millisecondsSinceEpoch}.csv';
      try {
        await ExportService.shareCSV(csv, filename);
      } catch (error) {
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.analytics_exportFailed('$error'))),
        );
      }
    }

    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 840;
          final horizontalPadding = isWide ? AppSpacing.xxl : AppSpacing.lg;

          return ListView(
            controller: scrollController,
            padding: EdgeInsets.all(horizontalPadding),
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.settings_title,
                          style: theme.textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          'Preferences, reminders, data, and app details.',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (showCloseButton)
                    IconButton(
                      tooltip: l10n.common_close,
                      icon: const Icon(Icons.close_rounded),
                      onPressed: () {
                        if (Navigator.of(context).canPop()) {
                          Navigator.of(context).pop();
                        } else {
                          context.go('/');
                        }
                      },
                    ),
                ],
              ),
              const SizedBox(height: AppSpacing.xl),
              _SettingsSection(
                icon: Icons.account_circle_rounded,
                title: 'Profile',
                children: [
                  _ProfileSummary(
                    vehicles: cars.length,
                    currency: settings.currency,
                    units: settings.units,
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              _SettingsSection(
                icon: Icons.tune_rounded,
                title: l10n.settings_preferences,
                children: [
                  _SettingsControl(
                    title: l10n.themeSelector_title,
                    subtitle: 'Choose how CarsManager appears.',
                    control: SegmentedButton<ThemeMode>(
                      segments: const [
                        ButtonSegment(
                          value: ThemeMode.system,
                          icon: Icon(Icons.brightness_auto_rounded),
                          label: Text('System'),
                        ),
                        ButtonSegment(
                          value: ThemeMode.light,
                          icon: Icon(Icons.light_mode_rounded),
                          label: Text('Light'),
                        ),
                        ButtonSegment(
                          value: ThemeMode.dark,
                          icon: Icon(Icons.dark_mode_rounded),
                          label: Text('Dark'),
                        ),
                      ],
                      selected: {settings.themeMode},
                      onSelectionChanged: (selection) => ref
                          .read(settingsControllerProvider.notifier)
                          .setThemeMode(selection.single),
                    ),
                  ),
                  const _SettingsDivider(),
                  _LanguageSelector(settings: settings),
                  const _SettingsDivider(),
                  _SettingsControl(
                    title: 'Units',
                    subtitle: 'Distance and volume defaults.',
                    control: SegmentedButton<String>(
                      segments: const [
                        ButtonSegment(
                          value: 'metric',
                          label: Text('Metric'),
                          icon: Icon(Icons.speed_rounded),
                        ),
                        ButtonSegment(
                          value: 'imperial',
                          label: Text('Imperial'),
                          icon: Icon(Icons.straighten_rounded),
                        ),
                      ],
                      selected: {settings.units},
                      onSelectionChanged: (selection) => ref
                          .read(settingsControllerProvider.notifier)
                          .setUnits(selection.single),
                    ),
                  ),
                  const _SettingsDivider(),
                  _SettingsControl(
                    title: 'Currency',
                    subtitle: 'Used for totals, charts, and exports.',
                    control: DropdownButton<String>(
                      value: settings.currency,
                      borderRadius: BorderRadius.circular(AppRadius.md),
                      items: const [
                        DropdownMenuItem(value: 'EUR', child: Text('EUR (€)')),
                        DropdownMenuItem(value: 'USD', child: Text('USD (\$)')),
                        DropdownMenuItem(value: 'GBP', child: Text('GBP (£)')),
                      ],
                      onChanged: (value) {
                        if (value == null) return;
                        ref
                            .read(settingsControllerProvider.notifier)
                            .setCurrency(value);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              _SettingsSection(
                icon: Icons.notifications_active_rounded,
                title: 'Notifications',
                children: [
                  _SettingsControl(
                    title: 'Enable reminders',
                    subtitle: 'Surface insurance, inspection, and tax dates.',
                    control: Switch(
                      value: settings.notificationsEnabled,
                      onChanged: (value) => ref
                          .read(settingsControllerProvider.notifier)
                          .setNotificationsEnabled(value),
                    ),
                  ),
                  const _SettingsDivider(),
                  const Wrap(
                    spacing: AppSpacing.sm,
                    runSpacing: AppSpacing.sm,
                    children: [
                      _ReminderChip(label: '90 days'),
                      _ReminderChip(label: '30 days'),
                      _ReminderChip(label: '7 days'),
                      _ReminderChip(label: '1 day'),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              _SettingsSection(
                icon: Icons.storage_rounded,
                title: l10n.settings_dataManagement,
                children: [
                  _ActionRow(
                    icon: Icons.download_rounded,
                    title: l10n.settings_exportBackup,
                    subtitle: 'Download a CSV snapshot of your garage.',
                    onTap: exportData,
                  ),
                  const _SettingsDivider(),
                  _ActionRow(
                    icon: Icons.delete_forever_rounded,
                    title: l10n.settings_resetData,
                    subtitle: 'Delete all cars and entries from this device.',
                    isDanger: true,
                    onTap: () => _confirmReset(context, ref, l10n),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              const _SettingsSection(
                icon: Icons.info_outline_rounded,
                title: 'About',
                children: [
                  _InfoLine(label: 'Version', value: '1.0.0+1'),
                  _SettingsDivider(),
                  _InfoLine(
                    label: 'Product',
                    value: 'Every cost. Every service. Total clarity.',
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _confirmReset(
    BuildContext context,
    WidgetRef ref,
    AppLocalizations l10n,
  ) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.settings_resetDataTitle),
        content: Text(l10n.settings_resetDataConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(l10n.common_cancel),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: AppColors.danger),
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(l10n.settings_resetData),
          ),
        ],
      ),
    );

    if (confirm != true) return;
    await ref.read(carsControllerProvider.notifier).resetAllData();
    if (context.mounted) context.go('/');
  }
}

class _SettingsSection extends StatelessWidget {
  const _SettingsSection({
    required this.icon,
    required this.title,
    required this.children,
  });

  final IconData icon;
  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: Border.all(color: theme.colorScheme.outlineVariant),
        boxShadow: theme.brightness == Brightness.light ? AppShadows.sm : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: AppColors.brandPrimary.withValues(alpha: 0.1),
                foregroundColor: AppColors.brandPrimary,
                child: Icon(icon),
              ),
              const SizedBox(width: AppSpacing.md),
              Text(
                title,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          ...children,
        ],
      ),
    );
  }
}

class _SettingsControl extends StatelessWidget {
  const _SettingsControl({
    required this.title,
    required this.subtitle,
    required this.control,
  });

  final String title;
  final String subtitle;
  final Widget control;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        final stack = constraints.maxWidth < 560;
        final label = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: theme.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              subtitle,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        );

        if (stack) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              label,
              const SizedBox(height: AppSpacing.md),
              Align(alignment: Alignment.centerLeft, child: control),
            ],
          );
        }

        return Row(
          children: [
            Expanded(child: label),
            const SizedBox(width: AppSpacing.lg),
            control,
          ],
        );
      },
    );
  }
}

class _ProfileSummary extends StatelessWidget {
  const _ProfileSummary({
    required this.vehicles,
    required this.currency,
    required this.units,
  });

  final int vehicles;
  final String currency;
  final String units;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            gradient: AppColors.brandGradient,
            borderRadius: BorderRadius.circular(AppRadius.lg),
          ),
          child: const Icon(
            Icons.directions_car_filled_rounded,
            color: Colors.white,
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'CarsManager',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                '$vehicles ${vehicles == 1 ? 'vehicle' : 'vehicles'} • $currency • $units',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _LanguageSelector extends ConsumerWidget {
  const _LanguageSelector({required this.settings});

  final AppSettingsState settings;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final currentLocale = settings.locale;

    return _SettingsControl(
      title: l10n.language_selector_title,
      subtitle: 'Controls labels, dates, and localized copy.',
      control: Wrap(
        spacing: AppSpacing.sm,
        runSpacing: AppSpacing.sm,
        children: [
          _LanguageOption(
            title: l10n.language_name_en,
            languageCode: 'en',
            isSelected: currentLocale?.languageCode == 'en',
            onTap: () => ref
                .read(settingsControllerProvider.notifier)
                .setLocale(const Locale('en')),
          ),
          _LanguageOption(
            title: l10n.language_name_it,
            languageCode: 'it',
            isSelected: currentLocale?.languageCode == 'it',
            onTap: () => ref
                .read(settingsControllerProvider.notifier)
                .setLocale(const Locale('it')),
          ),
        ],
      ),
    );
  }
}

class _LanguageOption extends StatelessWidget {
  const _LanguageOption({
    required this.title,
    required this.languageCode,
    required this.isSelected,
    required this.onTap,
  });

  final String title;
  final String languageCode;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      color: isSelected
          ? AppColors.brandPrimary.withValues(alpha: 0.12)
          : theme.colorScheme.surfaceContainerHighest,
      borderRadius: BorderRadius.circular(AppRadius.pill),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.pill),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 24,
                height: 16,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(AppRadius.xs),
                  child: CountryFlag.fromLanguageCode(languageCode),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(
                title,
                style: theme.textTheme.labelLarge?.copyWith(
                  color: isSelected ? AppColors.brandPrimary : null,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActionRow extends StatelessWidget {
  const _ActionRow({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.isDanger = false,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final bool isDanger;

  @override
  Widget build(BuildContext context) {
    final color = isDanger ? AppColors.danger : AppColors.brandPrimary;
    final theme = Theme.of(context);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.md),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: color.withValues(alpha: 0.12),
                foregroundColor: color,
                child: Icon(icon),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: isDanger ? AppColors.danger : null,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      subtitle,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right_rounded, color: color),
            ],
          ),
        ),
      ),
    );
  }
}

class _ReminderChip extends StatelessWidget {
  const _ReminderChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: const Icon(Icons.schedule_rounded, size: 18),
      label: Text(label),
      side: BorderSide(color: Theme.of(context).colorScheme.outlineVariant),
    );
  }
}

class _InfoLine extends StatelessWidget {
  const _InfoLine({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ],
    );
  }
}

class _SettingsDivider extends StatelessWidget {
  const _SettingsDivider();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
      child: Divider(height: 1, color: Theme.of(context).dividerColor),
    );
  }
}
