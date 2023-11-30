import 'package:flutter/material.dart';

class DotContainer extends StatelessWidget {
  final Color color;
  const DotContainer({
    required this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 4,
      width: 4,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(100),
      ),
    );
  }
}
