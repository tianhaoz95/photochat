import 'package:flutter/material.dart';
import 'package:minidonkey/components/btn_logo/btn_logo_with_loading_error.dart';
import 'package:minidonkey/services/i18n/i18n.dart';
import 'package:minidonkey/services/states/loading_states.dart';

typedef Future<void> OnUploadHandler();

/// Gallery Image Picker Button
///
/// {@category Screens: Send}
class SendScreenGalleryImageBtn extends StatelessWidget {
  /// The function that gets called when the pick image
  /// from gallery button is clicked.
  final OnUploadHandler onUploadHandler;

  /// The [LoadingState] that corresponding to
  /// the progress of the random image fetching.
  final LoadingState? loadingState;
  const SendScreenGalleryImageBtn({
    required this.onUploadHandler,
    required this.loadingState,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      child: RaisedButton(
        key: Key('encode_pick_image_from_gallery_btn'),
        onPressed: this.onUploadHandler,
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ButtonLogoWithLoadingAndError(this.loadingState, Icons.camera),
              SizedBox(
                width: 15.0,
              ),
              Text(AppLocalizations.of(context)!.encodeScreenGalleryBtnText),
            ],
          ),
        ),
      ),
    );
  }
}
