import 'package:cars_manager/features/garage/domain/cars_notifier.dart';
import 'package:cars_manager/features/settings/domain/settings_notifier.dart';
import 'package:cars_manager/l10n/app_localizations.dart';
import 'package:cars_manager/presentation/common/widgets/section_header.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsDrawer extends StatelessWidget {
  const SettingsDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Drawer(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: Row(
                children: [
                  Text(
                    l10n.settings_title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const Spacer(),
                  IconButton(
                    tooltip: l10n.common_close,
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
            const Expanded(
              child: Padding(
                padding: EdgeInsets.only(bottom: 16),
                child: SettingsContent(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsContent extends ConsumerWidget {
  final ScrollController? scrollController;
  const SettingsContent({super.key, this.scrollController});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(appSettingsProvider);

    return ListView(
      controller: scrollController,
      padding: EdgeInsets.zero,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Profile & Settings',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        const LanguageSelector(),
        const SizedBox(height: 32),

        SectionHeader(
          horizontalPadding: 32,
          title: 'Preferences',
          icon: Icon(
            Icons.settings,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        _SettingsRow(
          title: 'Notifications',
          trailing: Switch(
            value: settings.notificationsEnabled,
            onChanged: (val) => ref
                .read(settingsControllerProvider.notifier)
                .setNotificationsEnabled(val),
          ),
        ),
        _SettingsRow(
          title: 'Units',
          trailing: DropdownButton<String>(
            value: settings.units,
            items: const [
              DropdownMenuItem(value: 'metric', child: Text('Metric (km, L)')),
              DropdownMenuItem(
                value: 'imperial',
                child: Text('Imperial (mi, gal)'),
              ),
            ],
            onChanged: (val) {
              if (val != null) {
                ref.read(settingsControllerProvider.notifier).setUnits(val);
              }
            },
          ),
        ),
        _SettingsRow(
          title: 'Currency',
          trailing: DropdownButton<String>(
            value: settings.currency,
            items: const [
              DropdownMenuItem(value: 'EUR', child: Text('EUR (€)')),
              DropdownMenuItem(value: 'USD', child: Text('USD (\$)')),
              DropdownMenuItem(value: 'GBP', child: Text('GBP (£)')),
            ],
            onChanged: (val) {
              if (val != null) {
                ref.read(settingsControllerProvider.notifier).setCurrency(val);
              }
            },
          ),
        ),
        const SizedBox(height: 32),

        SectionHeader(
          horizontalPadding: 32,
          title: 'Data Management',
          icon: Icon(
            Icons.storage,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
          child: ElevatedButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Data exported to JSON (Simulation)'),
                ),
              );
            },
            icon: const Icon(Icons.download),
            label: const Text('Export Data / Backup'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
          child: OutlinedButton.icon(
            style: OutlinedButton.styleFrom(foregroundColor: Colors.red),
            onPressed: () async {
              final confirm = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Reset All Data?'),
                  content: const Text(
                    'This will delete all your cars and entries. This action cannot be undone.',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: const Text(
                        'Reset',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              );
              if (confirm == true) {
                await ref.read(carsControllerProvider.notifier).resetAllData();
                if (context.mounted) Navigator.of(context).pop();
              }
            },
            icon: const Icon(Icons.delete_forever),
            label: const Text('Reset All Data'),
          ),
        ),
        const SizedBox(height: 32),
      ],
    );
  }
}

class _SettingsRow extends StatelessWidget {
  final String title;
  final Widget trailing;
  const _SettingsRow({required this.title, required this.trailing});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: GoogleFonts.spaceGrotesk(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          trailing,
        ],
      ),
    );
  }
}

class LanguageSelector extends ConsumerWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final settings = ref.watch(appSettingsProvider);
    final currentLocale = settings.locale;
    final isEnglish = currentLocale?.languageCode == 'en';
    final isItalian = currentLocale?.languageCode == 'it';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          horizontalPadding: 32,
          title: l10n.language_selector_title,
          icon: Icon(
            Icons.translate,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Row(
            children: [
              Expanded(
                child: _LanguageOption(
                  title: l10n.language_name_en,
                  languageCode: 'en',
                  isSelected: isEnglish,
                  onTap: () {
                    if (!isEnglish) {
                      ref
                          .read(settingsControllerProvider.notifier)
                          .setLocale(const Locale('en'));
                    }
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _LanguageOption(
                  title: l10n.language_name_it,
                  languageCode: 'it',
                  isSelected: isItalian,
                  onTap: () {
                    if (!isItalian) {
                      ref
                          .read(settingsControllerProvider.notifier)
                          .setLocale(const Locale('it'));
                    }
                  },
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeader(
              horizontalPadding: 32,
              title: l10n.themeSelector_title,
              icon: Icon(
                Icons.translate,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    l10n.themeSelector_dark_mode,
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  Switch(
                    value: settings.themeMode == ThemeMode.light,
                    onChanged: (_) => ref
                        .read(settingsControllerProvider.notifier)
                        .toggleThemeMode(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _LanguageOption extends StatelessWidget {
  final String title;
  final String languageCode;
  final bool isSelected;
  final VoidCallback onTap;

  const _LanguageOption({
    required this.title,
    required this.languageCode,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const double nonSelectedOpacity = 0.6;

    return Material(
      color: isSelected
          ? Theme.of(context).colorScheme.onTertiaryFixedVariant
          : Theme.of(context).navigationBarTheme.backgroundColor,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 4),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Opacity(
                opacity: isSelected ? 1.0 : nonSelectedOpacity,
                child: SizedBox(
                  width: 33,
                  height: 22,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(3),
                    child: CountryFlag.fromLanguageCode(languageCode),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Opacity(
                opacity: isSelected ? 1.0 : nonSelectedOpacity,
                child: Text(
                  title,
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 16,
                    fontWeight: isSelected
                        ? FontWeight.bold
                        : FontWeight.normal,
                    color: isSelected
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
