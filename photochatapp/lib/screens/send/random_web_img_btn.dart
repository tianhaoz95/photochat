import 'package:flutter/material.dart';
import 'package:photochatapp/components/btn_logo/btn_logo_with_loading_error.dart';
import 'package:photochatapp/services/i18n/i18n.dart';
import 'package:photochatapp/services/states/loading_states.dart';

typedef Future<void> OnFetchHandler();

/// Random Image Generator Button
///
/// {@category Send Screen}
class SendScreenRandomWebImageBtn extends StatelessWidget {
  /// The function that gets called when the fetch random
  /// image button is pressed.
  final OnFetchHandler onFetchHandler;

  /// The [LoadingState] that corresponding to
  /// the progress of the random image fetching.
  final LoadingState loadingState;
  const SendScreenRandomWebImageBtn({
    @required this.onFetchHandler,
    @required this.loadingState,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      child: RaisedButton(
        onPressed: this.onFetchHandler,
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ButtonLogoWithLoadingAndError(this.loadingState, Icons.sync),
              SizedBox(
                width: 15.0,
              ),
              Text(AppLocalizations.of(context).encodeScreenRandomBtnText),
            ],
          ),
        ),
      ),
    );
  }
}
