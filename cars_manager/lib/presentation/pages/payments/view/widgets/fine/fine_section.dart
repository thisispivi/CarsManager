import 'package:cars_manager/l10n/app_localizations.dart';
import 'package:cars_manager/models/car.dart';
import 'package:cars_manager/presentation/pages/payments/view/widgets/common/payment_section_card.dart';
import 'package:cars_manager/presentation/pages/payments/view/widgets/fine/fine_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../../../../../../../main.dart';

class FineSection extends StatelessWidget {
  final Car car;

  const FineSection({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final localizations = AppLocalizations.of(context)!;

    final carManagerState = Provider.of<CarManagerState>(
      context,
      listen: false,
    );
    final locale = carManagerState.locale ?? const Locale('en');

    return PaymentSectionCard(
      title: localizations.payments_finesData_title,
      icon: SvgPicture.asset(
        "assets/icons/fine.svg",
        width: 28,
        height: 28,
        colorFilter: ColorFilter.mode(colorScheme.primary, BlendMode.srcIn),
      ),
      items: car.fineDatas!
          .asMap()
          .entries
          .map(
            (entry) => FineItem(
              fine: entry.value,
              locale: locale,
              isLast: entry.key == car.fineDatas!.length - 1,
            ),
          )
          .toList(),
    );
  }
}
