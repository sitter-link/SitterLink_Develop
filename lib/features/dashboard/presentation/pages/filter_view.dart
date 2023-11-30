import 'package:flutter/material.dart';
import 'package:nanny_app/features/customer_home/model/nanny_filter_param.dart';
import 'package:nanny_app/features/dashboard/presentation/widgets/filter_body.dart';

class FilterView extends StatelessWidget {
  final ValueChanged<NannyFilterParam> onSearched;
  final NannyFilterParam? initialFilter;
  const FilterView({
    super.key,
    required this.onSearched,
    required this.initialFilter,
  });

  @override
  Widget build(BuildContext context) {
    return FilterBody(onSearched: onSearched, initialFilter: initialFilter);
  }
}
