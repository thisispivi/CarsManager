import 'package:car_manager/components/section_header.dart';
import 'package:car_manager/l10n/app_localizations.dart';
import 'package:car_manager/models/car.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../main.dart';

class PaymentsPage extends StatelessWidget {
  const PaymentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<CarManagerState>(
        builder: (context, carState, child) {
          final Car car = carState.car;

          final bool hasInspectionData =
              car.carInspectionsData != null &&
              car.carInspectionsData!.isNotEmpty;

          final List<Widget> sections = [
            const SizedBox(height: 16),
            if (hasInspectionData) InspectionDataBlock(car: car),
            const SizedBox(height: 45),
          ];

          return ListView(children: sections);
        },
      ),
    );
  }
}

class InspectionDataBlock extends StatelessWidget {
  final Car car;
  static const double horizontalPadding = 32.0;

  const InspectionDataBlock({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final localizations = AppLocalizations.of(context)!;

    final carManagerState = Provider.of<CarManagerState>(
      context,
      listen: false,
    );
    final locale = carManagerState.locale ?? const Locale('en');
    final dateFormat = DateFormat.yMMMd(locale.toString());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          hPadding: horizontalPadding,
          title: localizations.payments_inspectionsData_title,
          icon: SvgPicture.asset(
            "assets/icons/inspection.svg",
            width: 28,
            height: 28,
            colorFilter: ColorFilter.mode(colorScheme.primary, BlendMode.srcIn),
          ),
        ),
        const SizedBox(height: 12),
        _buildNextInspectionInfo(
          context,
          dateFormat,
          localizations,
          colorScheme,
        ),
        const SizedBox(height: 16),
        ..._buildInspectionItems(context, localizations, locale),
      ],
    );
  }

  Widget _buildNextInspectionInfo(
    BuildContext context,
    DateFormat dateFormat,
    AppLocalizations localizations,
    ColorScheme colorScheme,
  ) {
    final nextInspectionDate = car.getNextInspectionDate();
    final daysUntilNext = car.getDaysUntilNextInspection().toString();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Row(
        children: [
          Text(
            "${localizations.payments_inspectionsData_nextInspectionDue}:",
            style: GoogleFonts.spaceGrotesk(
              fontSize: 16,
              color: colorScheme.primary,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            "${dateFormat.format(nextInspectionDate)} ($daysUntilNext ${localizations.payments_inspectionsData_nextInspectionDue_days})",
            style: GoogleFonts.spaceGrotesk(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildInspectionItems(
    BuildContext context,
    AppLocalizations localizations,
    Locale locale,
  ) {
    final numberFormat = NumberFormat.decimalPattern(locale.toString());
    final dateFormat = DateFormat.yMMMd(locale.toString());

    return car.carInspectionsData!.map((inspection) {
      return RowWithLeadingIcon(
        icon: SvgPicture.asset(
          "assets/icons/inspection.svg",
          width: 24,
          height: 24,
          colorFilter: ColorFilter.mode(
            Theme.of(context).colorScheme.primary,
            BlendMode.srcIn,
          ),
        ),
        title:
            "${localizations.payments_inspectionsData_date}: ${dateFormat.format(inspection.date)}",
        subtitles: [
          inspection.amount != null
              ? "${localizations.payments_inspectionsData_amount}: ${localizations.unit_currency(numberFormat.format(inspection.amount), "€")}"
              : null,
          "${localizations.payments_inspectionsData_status}: ${inspection.isPassed ? localizations.payments_inspectionsData_status_passed : localizations.payments_inspectionsData_status_failed} • ${localizations.payments_inspectionsData_mileage}: ${localizations.unit_km(numberFormat.format(inspection.mileage))}",
        ],
      );
    }).toList();
  }
}

class RowWithLeadingIcon extends StatelessWidget {
  final Widget icon;
  final String title;
  final List<String?> subtitles;

  static const double horizontalPadding = 32.0;
  static const double iconSize = 48.0;

  const RowWithLeadingIcon({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitles,
  });

  List<String> get filteredSubtitles =>
      subtitles.where((subtitle) => subtitle != null).cast<String>().toList();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: 8,
      ),
      child: Row(
        children: [
          Container(
            height: iconSize,
            width: iconSize,
            decoration: BoxDecoration(
              color: const Color.fromRGBO(43, 48, 54, 1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(child: icon),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 4),
                ...filteredSubtitles.map(
                  (subtitle) => Text(
                    subtitle,
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 14,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
