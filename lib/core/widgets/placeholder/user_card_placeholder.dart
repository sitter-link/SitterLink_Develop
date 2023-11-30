import 'package:flutter/material.dart';
import 'package:nanny_app/core/theme/custom_theme.dart';
import 'package:nanny_app/core/utils/size_utils.dart';
import 'package:nanny_app/core/widgets/placeholder/shimmer_container.dart';
import 'package:nanny_app/core/widgets/placeholder/shimmer_wrapper.dart';

class UserCardPlaceHolder extends StatelessWidget {
  const UserCardPlaceHolder({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerWrapper(
      child: Column(
        children: [
          Row(
            children: [
              const ShimmerContainer(
                height: 120,
                width: 90,
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
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: ShimmerContainer(
                  height: 50,
                  width: context.width,
                  leftMargin: 0,
                  rightMargin: 0,
                ),
              ),
              const ShimmerContainer(
                topMargin: 0,
                height: 50,
                width: 50,
              )
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class UserCardPlaceHolderList extends StatelessWidget {
  final double horizontalPadding;
  const UserCardPlaceHolderList({
    super.key,
    this.horizontalPadding = CustomTheme.horizontalPadding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Column(
        children: List.generate(5, (index) => const UserCardPlaceHolder()),
      ),
    );
  }
}

class SliverUserCardPlaceHolderList extends StatelessWidget {
  final double horizontalPadding;
  const SliverUserCardPlaceHolderList({
    super.key,
    this.horizontalPadding = CustomTheme.horizontalPadding,
  });

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        child: Column(
          children: List.generate(5, (index) => const UserCardPlaceHolder()),
        ),
      ),
    );
  }
}
