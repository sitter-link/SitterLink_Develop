// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:nanny_app/core/bloc/common_state.dart';

import 'package:nanny_app/core/icon/nanny_icon_icons.dart';
import 'package:nanny_app/core/services/navigation_service.dart';
import 'package:nanny_app/core/theme/app_text_theme.dart';
import 'package:nanny_app/core/theme/custom_theme.dart';
import 'package:nanny_app/core/utils/form_validator.dart';
import 'package:nanny_app/core/utils/size_utils.dart';
import 'package:nanny_app/core/utils/snackbar_utils.dart';
import 'package:nanny_app/core/widgets/appbar/custom_app_bar.dart';
import 'package:nanny_app/core/widgets/button/custom_rounded_button.dart';
import 'package:nanny_app/core/widgets/text_fields/custom_text_field.dart';
import 'package:nanny_app/core/wrapper/bloc_listener_wrapper.dart';
import 'package:nanny_app/features/book_nanny/%20cubit/create_review_cubit.dart';
import 'package:nanny_app/features/customer_history/model/create_rating_param.dart';

class RatingsBody extends StatefulWidget {
  final int bookingId;
  const RatingsBody({
    Key? key,
    required this.bookingId,
  }) : super(key: key);

  @override
  State<RatingsBody> createState() => _RatingsBodyState();
}

class _RatingsBodyState extends State<RatingsBody> {
  double currentRating = 0.0;
  final TextEditingController commentController = TextEditingController();
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final appTextTheme = Theme.of(context).extension<AppTextTheme>()!;

    return Scaffold(
      backgroundColor: CustomTheme.backgroundColor,
      appBar: const CustomAppBar(
        title: "Ratings",
      ),
      body: BlocListenerWrapper<CreateReviewCubit>(
        listener: (context, state) {
          if (state is CommonSuccessState<CreateRatingParam>) {
            NavigationService.pop();
            SnackBarUtils.showSuccessMessage(
              context: context,
              message: "Review added completed",
            );
          }
        },
        child: Container(
          margin: const EdgeInsets.only(top: 10),
          padding: const EdgeInsets.symmetric(
            vertical: CustomTheme.horizontalPadding,
            horizontal: CustomTheme.pageTopPadding,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: FormBuilder(
            key: _formKey,
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Give Ratings",
                        style:
                            appTextTheme.bodyLargeBold.copyWith(fontSize: 24),
                      ),
                      SizedBox(height: 25.hp),
                      RatingBar.builder(
                        initialRating: currentRating,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: false,
                        itemCount: 5,
                        unratedColor: CustomTheme.grey.shade200,
                        itemBuilder: (context, _) => Icon(
                          NannyIcon.star,
                          color: CustomTheme.primaryColor,
                        ),
                        onRatingUpdate: (rating) {
                          setState(() {
                            currentRating = rating;
                          });
                        },
                      ),
                      SizedBox(height: 25.hp),
                      CustomTextField(
                        controller: commentController,
                        label: "Feedback",
                        validator: (value) {
                          return FormValidator.validateFieldNotEmpty(
                            value,
                            "Feedback",
                          );
                        },
                        hintText: "Enter feedback",
                        maxLines: 4,
                      )
                    ],
                  ),
                ),
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: CustomRoundedButtom(
                          color: CustomTheme.primaryColor,
                          textColor: Colors.white,
                          title: "POST",
                          onPressed: () {
                            if (_formKey.currentState!.saveAndValidate()) {
                              final CreateRatingParam param = CreateRatingParam(
                                bookingId: widget.bookingId,
                                comment: commentController.text,
                                rating: currentRating,
                              );
                              context.read<CreateReviewCubit>().create(param);
                            }
                          },
                        ),
                      ),
                      SizedBox(height: context.bottomViewPadding + 10.hp),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
