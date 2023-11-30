import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nanny_app/core/bloc/common_state.dart';
import 'package:nanny_app/core/constants/assets.dart';
import 'package:nanny_app/core/widgets/placeholder/common_error_widget.dart';
import 'package:nanny_app/core/widgets/placeholder/common_loading_widget.dart';
import 'package:nanny_app/core/widgets/placeholder/no_data_available.dart';

class BlocBuilderWrapper<B extends StateStreamable<CommonState>>
    extends StatelessWidget {
  final BlocWidgetBuilder<CommonState> builder;
  final BlocWidgetListener<CommonState>? listener;
  final bool overrideLoading;
  final bool overrideError;
  final B? bloc;
  final bool useSliver;
  final BlocBuilderCondition<CommonState>? buildWhen;
  final Widget? loadingWidget;
  final Widget? noDataWidget;
  final bool ignoreNoDataState;
  const BlocBuilderWrapper({
    Key? key,
    required this.builder,
    this.listener,
    this.overrideError = false,
    this.overrideLoading = false,
    this.bloc,
    this.useSliver = false,
    this.buildWhen,
    this.loadingWidget,
    this.noDataWidget,
    this.ignoreNoDataState = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<B, CommonState>(
      listener: (context, state) {
        if (listener != null) {
          listener!(context, state);
        }
      },
      bloc: bloc,
      buildWhen: buildWhen ??
          (previous, current) {
            if (current is CommonLoadingState) {
              return current.showLoading;
            } else {
              return true;
            }
          },
      builder: (context, state) {
        if ((state is CommonLoadingState || state is CommonInitialState) &&
            !overrideLoading) {
          if (useSliver) {
            return loadingWidget ??
                const SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: CommonLoadingWidget(),
                  ),
                );
          } else {
            return Center(
              child: loadingWidget ?? const CommonLoadingWidget(),
            );
          }
        } else if (state is CommonErrorState && !overrideError) {
          if (useSliver) {
            return SliverFillRemaining(
              hasScrollBody: false,
              child: CommonErrorWidget(
                message: state.message,
              ),
            );
          } else {
            return CommonErrorWidget(
              message: state.message,
            );
          }
        } else if (state is CommonNoDataState && !ignoreNoDataState) {
          if (useSliver) {
            return noDataWidget ??
                const SliverFillRemaining(
                  hasScrollBody: false,
                  child: NoDataAvailable(
                    message: "No Data Available",
                    image: Assets.notFound,
                  ),
                );
          } else {
            return noDataWidget ??
                const NoDataAvailable(
                  message: "No Data Available",
                  image: Assets.notFound,
                );
          }
        } else {
          return builder(context, state);
        }
      },
    );
  }
}
