import 'package:flutter/material.dart';

class SliverSizedBox extends StatelessWidget {
  final Widget? child;
  final double? width;
  final double? height;
  const SliverSizedBox({
    super.key,
    this.child,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: height,
        width: width,
        child: child,
      ),
    );
  }
}
