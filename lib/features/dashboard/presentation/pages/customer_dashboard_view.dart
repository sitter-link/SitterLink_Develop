import 'package:flutter/material.dart';
import 'package:nanny_app/features/customer_home/model/nanny_filter_param.dart';
import 'package:nanny_app/features/dashboard/presentation/widgets/customer_dashboard_body.dart';

class CustomerDashboardView extends StatelessWidget {
  final NannyFilterParam param;
  const CustomerDashboardView({super.key, required this.param});

  @override
  Widget build(BuildContext context) {
    return CustomerDashboardBody(param: param);
  }
}
