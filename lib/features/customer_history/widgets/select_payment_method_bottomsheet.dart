import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nanny_app/core/bloc/common_state.dart';
import 'package:nanny_app/core/images/custom_network_image.dart';
import 'package:nanny_app/core/services/navigation_service.dart';
import 'package:nanny_app/core/theme/app_text_theme.dart';
import 'package:nanny_app/core/theme/custom_theme.dart';
import 'package:nanny_app/core/utils/size_utils.dart';
import 'package:nanny_app/core/widgets/button/custom_rounded_button.dart';
import 'package:nanny_app/core/widgets/others/bottomsheet_wrapper.dart';
import 'package:nanny_app/core/wrapper/bloc_builder_wrapper.dart';
import 'package:nanny_app/features/book_nanny/%20cubit/fetch_payment_methods_cubit.dart';
import 'package:nanny_app/features/book_nanny/repository/book_nanny_repository.dart';
import 'package:nanny_app/features/customer_history/model/payment_method.dart';

void showSelectPaymentMethodBottomSheet({
  required BuildContext context,
  required ValueChanged<String> onConfirmed,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return BlocProvider(
        create: (context) => FetchPaymentMethodsCubit(
          repository: context.read<BookNannyRepository>(),
        )..fetchPaymentMethods(),
        child: _SelectPaymentMethodBottomSheet(
          onConfirmed: onConfirmed,
        ),
      );
    },
  );
}

class _SelectPaymentMethodBottomSheet extends StatefulWidget {
  final ValueChanged<String> onConfirmed;
  const _SelectPaymentMethodBottomSheet({required this.onConfirmed});

  @override
  State<_SelectPaymentMethodBottomSheet> createState() =>
      _SelectPaymentMethodBottomSheetState();
}

class _SelectPaymentMethodBottomSheetState
    extends State<_SelectPaymentMethodBottomSheet> {
  String? selectedPaymentMethod;

  @override
  Widget build(BuildContext context) {
    final appTextTheme = Theme.of(context).extension<AppTextTheme>()!;

    return BottomSheetWrapper(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: CustomTheme.horizontalPadding,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Text(
              "Payment Method",
              style: appTextTheme.bodyLargeBold.copyWith(
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 20),
            BlocBuilderWrapper<FetchPaymentMethodsCubit>(
              builder: (context, state) {
                if (state is CommonSuccessState<List<PaymentMethod>>) {
                  return Column(
                    children: state.data
                        .map(
                          (e) => _PaymentTile(
                            text: e.paymentMethod,
                            image: e.image,
                            value: e.method,
                            onChanged: (value) {
                              setState(() {
                                selectedPaymentMethod = value;
                              });
                            },
                            selectedMethod: selectedPaymentMethod,
                          ),
                        )
                        .toList(),
                  );
                } else {
                  return Container();
                }
              },
            ),
            SizedBox(
              height: 10.hp,
            ),
            CustomRoundedButtom(
              title: "CONFIRM",
              isDisabled: selectedPaymentMethod == null,
              onPressed: () {
                NavigationService.pop();
                widget.onConfirmed(selectedPaymentMethod!);
              },
              color: CustomTheme.primaryColor,
              textColor: Colors.white,
              verticalPadding: 14,
            )
          ],
        ),
      ),
    );
  }
}

class _PaymentTile extends StatelessWidget {
  final String text;
  final String image;
  final String value;
  final String? selectedMethod;
  final ValueChanged<String> onChanged;

  const _PaymentTile({
    required this.text,
    required this.image,
    required this.value,
    required this.selectedMethod,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final appTextTheme = Theme.of(context).extension<AppTextTheme>()!;

    return RadioListTile(
      value: value,
      controlAffinity: ListTileControlAffinity.trailing,
      groupValue: selectedMethod,
      onChanged: (value) {
        onChanged(value!);
      },
      contentPadding: EdgeInsets.symmetric(vertical: 4.hp),
      title: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CustomCachedNetworkImage(
              url: image,
              fit: BoxFit.cover,
              height: 36.wp,
              width: 36.wp,
            ),
          ),
          SizedBox(width: 16.wp),
          Text(
            text,
            style: appTextTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
