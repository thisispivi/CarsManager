import 'package:car_manager/components/section_header.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:car_manager/l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import '../main.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 16),
          const LanguageSelector(),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<CarManagerState>(context);
    final currentLocale = appState.locale;
    final isEnglish = currentLocale?.languageCode == 'en';
    final isItalian = currentLocale?.languageCode == 'it';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          hPadding: 32,
          title:
              AppLocalizations.of(context)?.language_selector_title ??
              'Language',
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
                  title: 'English',
                  languageCode: 'en',
                  isSelected: isEnglish,
                  flagEmoji: '🇬🇧',
                  onTap: () {
                    if (!isEnglish) {
                      appState.setLocale(const Locale('en'));
                    }
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _LanguageOption(
                  title: 'Italiano',
                  languageCode: 'it',
                  isSelected: isItalian,
                  flagEmoji: '🇮🇹',
                  onTap: () {
                    if (!isItalian) {
                      appState.setLocale(const Locale('it'));
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _LanguageOption extends StatelessWidget {
  final String title;
  final String languageCode;
  final bool isSelected;
  final String flagEmoji;
  final VoidCallback onTap;

  const _LanguageOption({
    required this.title,
    required this.languageCode,
    required this.isSelected,
    required this.flagEmoji,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final double nonSelectedOpacity = 0.6;

    return Material(
      color: isSelected
          ? Color.fromRGBO(61, 68, 74, 1)
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
                child: CountryFlag.fromLanguageCode(
                  languageCode,
                  shape: const RoundedRectangle(3),
                  width: 33,
                  height: 22,
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
