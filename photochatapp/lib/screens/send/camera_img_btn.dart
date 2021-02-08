import 'package:flutter/material.dart';
import 'package:minidonkey/components/btn_logo/btn_logo_with_loading_error.dart';
import 'package:minidonkey/services/i18n/i18n.dart';
import 'package:minidonkey/services/states/loading_states.dart';

typedef Future<void> OnOpenHandler();

/// Camera Image Picker Button
///
/// {@category Screens: Send}
class SendScreenCameraImageBtn extends StatelessWidget {
  /// The function that gets called when the take photo
  /// with camera button is clicked
  final OnOpenHandler onOpenHandler;

  /// The [LoadingState] that corresponding to
  /// the progress of the random image fetching.
  final LoadingState? loadingState;
  const SendScreenCameraImageBtn({
    required this.onOpenHandler,
    required this.loadingState,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      child: RaisedButton(
        onPressed: this.onOpenHandler,
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ButtonLogoWithLoadingAndError(
                  this.loadingState, Icons.camera_alt),
              SizedBox(
                width: 15.0,
              ),
              Text(AppLocalizations.of(context)!.encodeScreenCameraBtnText),
            ],
          ),
        ),
      ),
    );
  }
}
