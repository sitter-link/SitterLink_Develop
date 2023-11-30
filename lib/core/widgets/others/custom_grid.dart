import 'package:flutter/material.dart';
import 'package:nanny_app/core/utils/size_utils.dart';

class CustomGridWidget extends StatelessWidget {
  final List<Widget> childrens;
  final int crossAxisCount;
  final double crossAxisSpacing;
  final double mainAxisSpacing;
  final bool useExpanded;
  const CustomGridWidget({
    Key? key,
    this.childrens = const [],
    this.crossAxisCount = 2,
    this.crossAxisSpacing = 10,
    this.mainAxisSpacing = 10,
    this.useExpanded = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final int count = (childrens.length / crossAxisCount).ceil();
    final bool hasOddChild = (childrens.length % crossAxisCount) != 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: List.generate(
        count,
        (mainIndex) {
          final bool isLastItem = mainIndex == count - 1;
          if (isLastItem && hasOddChild) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [childrens.last],
            );
          } else {
            return Container(
              margin: EdgeInsets.only(
                bottom: isLastItem ? 0 : mainAxisSpacing.wp,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: List.generate(
                  crossAxisCount,
                  (crossAxisIndex) {
                    final childIndex =
                        (mainIndex * crossAxisCount) + crossAxisIndex;
                    return Expanded(
                      flex: useExpanded ? 1 : 0,
                      child: Container(
                        margin: EdgeInsets.only(
                            right:
                                crossAxisIndex == 0 ? crossAxisSpacing.wp : 0),
                        child: childrens[childIndex],
                      ),
                    );
                  },
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
