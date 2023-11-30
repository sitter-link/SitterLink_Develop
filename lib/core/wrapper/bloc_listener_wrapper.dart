import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nanny_app/core/bloc/common_state.dart';
import 'package:nanny_app/core/utils/snackbar_utils.dart';
import 'package:nanny_app/core/widgets/dialogs/loading_dialog.dart';

class BlocListenerWrapper<B extends StateStreamable<CommonState>>
    extends StatefulWidget {
  final Widget child;
  final BlocWidgetListener<CommonState> listener;
  final bool overrideLoading;
  final bool overrideError;
  const BlocListenerWrapper({
    Key? key,
    required this.child,
    required this.listener,
    this.overrideError = false,
    this.overrideLoading = false,
  }) : super(key: key);

  @override
  State<BlocListenerWrapper> createState() => _BlocListenerWrapperState<B>();
}

class _BlocListenerWrapperState<B extends StateStreamable<CommonState>>
    extends State<BlocListenerWrapper<B>> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<B, CommonState>(
      listener: (context, state) {
        if (state is CommonLoadingState &&
            !widget.overrideLoading &&
            isLoading == false) {
          isLoading = true;
          showLoadingDialog(context);
        } else if (state is! CommonLoadingState &&
            !widget.overrideLoading &&
            isLoading) {
          isLoading = false;
          Navigator.pop(context);
        }

        if (state is CommonErrorState && !widget.overrideError) {
          SnackBarUtils.showErrorMessage(
            message: state.message,
            context: context,
          );
        }

        widget.listener(context, state);
      },
      child: widget.child,
    );
  }
}
