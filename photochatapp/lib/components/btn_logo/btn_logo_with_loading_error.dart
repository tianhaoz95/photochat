import 'package:flutter/material.dart';
import 'package:minidonkey/services/states/loading_states.dart';

class ButtonLogoWithLoadingAndError extends StatelessWidget {
  final LoadingState? loadingState;
  final IconData pendingIcon;
  const ButtonLogoWithLoadingAndError(this.loadingState, this.pendingIcon);
  @override
  Widget build(BuildContext context) {
    switch (this.loadingState) {
      case LoadingState.LOADING:
        return Container(
          height: 20.0,
          width: 20.0,
          child: CircularProgressIndicator(
            backgroundColor: Colors.black,
            strokeWidth: 2.0,
          ),
        );
      case LoadingState.ERROR:
        return Container(
          child: Icon(Icons.close),
        );
      case LoadingState.PENDING:
        return Container(
          child: Icon(this.pendingIcon),
        );
      case LoadingState.SUCCESS:
        return Container(
          child: Icon(Icons.done),
        );
      default:
        return Container(
          child: Icon(this.pendingIcon),
        );
    }
  }
}
