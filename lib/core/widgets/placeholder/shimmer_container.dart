import 'package:flutter/material.dart';

class ShimmerContainer extends StatelessWidget {
  final double height;
  final double width;
  final double borderRadius;
  final double leftMargin;
  final double rightMargin;
  final double topMargin;
  final double bottomMargin;
  const ShimmerContainer({
    super.key,
    required this.height,
    required this.width,
    this.borderRadius = 12,
    this.leftMargin = 8,
    this.rightMargin = 8,
    this.bottomMargin = 0,
    this.topMargin = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      margin: EdgeInsets.only(
        left: leftMargin,
        right: rightMargin,
        top: topMargin,
        bottom: bottomMargin,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: Colors.white,
      ),
    );
  }
}
