import 'package:flutter/material.dart';
import 'package:nanny_app/core/theme/custom_theme.dart';
import 'package:nanny_app/core/utils/size_utils.dart';
import 'package:nanny_app/core/widgets/placeholder/shimmer_container.dart';
import 'package:nanny_app/core/widgets/placeholder/shimmer_wrapper.dart';

class NotificationPlaceHolder extends StatelessWidget {
  const NotificationPlaceHolder({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerWrapper(
      child: Column(
        children: [
          Row(
            children: [
              const ShimmerContainer(
                height: 40,
                width: 40,
                borderRadius: 80,
                leftMargin: 0,
                rightMargin: 4,
              ),
              Expanded(
                child: Column(
                  children: [
                    ShimmerContainer(
                      height: 20,
                      width: context.width,
                      rightMargin: 0,
                      bottomMargin: 8,
                    ),
                    ShimmerContainer(
                      height: 20,
                      width: context.width,
                      rightMargin: 0,
                      bottomMargin: 8,
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class NotificationPlaceHolderList extends StatelessWidget {
  final double horizontalPadding;
  final int length;
  const NotificationPlaceHolderList({
    super.key,
    this.length = 20,
    this.horizontalPadding = CustomTheme.horizontalPadding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children:
            List.generate(length, (index) => const NotificationPlaceHolder()),
      ),
    );
  }
}

class SliverNotificationPlaceHolderList extends StatelessWidget {
  final double horizontalPadding;
  final int length;
  const SliverNotificationPlaceHolderList({
    super.key,
    this.length = 20,
    this.horizontalPadding = CustomTheme.horizontalPadding,
  });

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children:
              List.generate(length, (index) => const NotificationPlaceHolder()),
        ),
      ),
    );
  }
}
