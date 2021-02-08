import 'package:flutter/material.dart';
import 'package:minidonkey/components/btn_logo/btn_logo_with_loading_error.dart';
import 'package:minidonkey/services/states/loading_states.dart';

typedef Future<void> HandlerFunction();

class ProgressiveButton extends StatelessWidget {
  final HandlerFunction handler;
  final LoadingState loadingState;
  final IconData pendingIcon;
  final String pendingText;
  const ProgressiveButton(
      this.loadingState, this.pendingIcon, this.pendingText, this.handler);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: RaisedButton(
        onPressed: () {},
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ButtonLogoWithLoadingAndError(this.loadingState, Icons.camera),
              SizedBox(
                width: 15.0,
              ),
              Text('Choose from Gallery'),
            ],
          ),
        ),
      ),
    );
  }
}
