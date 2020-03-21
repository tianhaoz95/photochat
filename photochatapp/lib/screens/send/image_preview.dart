import 'package:flutter/material.dart';

/// Image Previewer
///
/// {@category Send Screen}
class SendScreenImageReview extends StatelessWidget {
  final Image image;
  const SendScreenImageReview(this.image);
  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: BoxConstraints(
          minHeight: 200,
          maxHeight: 600,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: this.image,
        ));
  }
}
