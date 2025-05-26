import 'package:car_manager/components/row_with_leading_icon.dart';
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
              car.inspectionDatas != null && car.inspectionDatas!.isNotEmpty;

          final bool hasInsuranceData =
              car.insuranceDatas != null && car.insuranceDatas!.isNotEmpty;

          final List<Widget> sections = [
            const SizedBox(height: 16),
            if (hasInsuranceData) InsuranceDataBlock(car: car),
            const SizedBox(height: 50),
            if (hasInspectionData) InspectionDataBlock(car: car),
            const SizedBox(height: 16),
          ];

          return ListView(children: sections);
        },
      ),
    );
  }
}

class InsuranceDataBlock extends StatelessWidget {
  final Car car;
  static const double horizontalPadding = 32.0;

  const InsuranceDataBlock({super.key, required this.car});

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
          title: localizations.payments_insuranceData_title,
          icon: ImageIcon(AssetImage("assets/icons/insurance.png"), size: 24),
        ),
        const SizedBox(height: 16),
        _buildNextInsuranceInfo(
          context,
          dateFormat,
          localizations,
          colorScheme,
        ),
        const SizedBox(height: 16),
        ..._buildInsuranceItems(context, localizations, locale),
      ],
    );
  }

  Widget _buildNextInsuranceInfo(
    BuildContext context,
    DateFormat dateFormat,
    AppLocalizations localizations,
    ColorScheme colorScheme,
  ) {
    final nextInsuranceDate = car.getNextInsuranceExpirationDate();
    final daysUntilNext = car.getDaysUntilNextInsuranceExpiration().toString();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: "${localizations.payments_insuranceData_nextDue}: ",
              style: GoogleFonts.spaceGrotesk(
                fontSize: 16,
                color: colorScheme.primary,
              ),
            ),
            TextSpan(
              text:
                  "${dateFormat.format(nextInsuranceDate)} ($daysUntilNext ${localizations.days})",
              style: GoogleFonts.spaceGrotesk(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: colorScheme.primary,
              ),
            ),
          ],
        ),
        softWrap: true,
        textScaler: MediaQuery.textScalerOf(context),
      ),
    );
  }

  List<Widget> _buildInsuranceItems(
    BuildContext context,
    AppLocalizations localizations,
    Locale locale,
  ) {
    final numberFormat = NumberFormat.decimalPattern(locale.toString());
    final dateFormat = DateFormat.yMMMEd(locale.toString());

    return car.insuranceDatas!.map((insurance) {
      return RowWithLeadingIcon(
        icon: ImageIcon(AssetImage("assets/icons/insurance.png"), size: 24),
        title:
            "${localizations.payments_insuranceData_provider}: ${insurance.insuranceCompany}",
        subtitles: [
          "${localizations.payments_insuranceData_policyNumber}: ${insurance.policyNumber}",
          "${localizations.payments_insuranceData_policyAmount}: ${localizations.unit_currency(numberFormat.format(insurance.premiumAmount), "€")}",
          "${localizations.date}: ${dateFormat.format(insurance.startDate)} - ${dateFormat.format(insurance.endDate)}",
        ],
      );
    }).toList();
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
        const SizedBox(height: 16),
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
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: "${localizations.payments_inspectionsData_nextDue}: ",
              style: GoogleFonts.spaceGrotesk(
                fontSize: 16,
                color: colorScheme.primary,
              ),
            ),
            TextSpan(
              text:
                  "${dateFormat.format(nextInspectionDate)} ($daysUntilNext ${localizations.days})",
              style: GoogleFonts.spaceGrotesk(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: colorScheme.primary,
              ),
            ),
          ],
        ),
        softWrap: true,
        textScaler: MediaQuery.textScalerOf(context),
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

    return car.inspectionDatas!.map((inspection) {
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
        title: "${localizations.date}: ${dateFormat.format(inspection.date)}",
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
