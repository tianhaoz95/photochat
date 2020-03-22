import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photochatapp/components/alerts/dialog.dart';
import 'package:photochatapp/components/screen_adapter/screen_adapter.dart';
import 'package:photochatapp/components/token_input_field/token_input_field.dart';
import 'package:photochatapp/screens/send/camera_img_btn.dart';
import 'package:photochatapp/screens/send/gallery_img_btn.dart';
import 'package:photochatapp/screens/send/image_preview.dart';
import 'package:photochatapp/screens/send/random_web_img_btn.dart';
import 'package:photochatapp/services/context/app_context.dart';
import 'package:photochatapp/services/converters/uploaded_img_to_data.dart';
import 'package:photochatapp/services/i18n/i18n.dart';
import 'package:photochatapp/services/requests/capacity_usage_request.dart';
import 'package:photochatapp/services/requests/encode_request.dart';
import 'package:image/image.dart' as imglib;
import 'package:photochatapp/services/requests/uploaded_img_conversion_request.dart';
import 'package:photochatapp/services/responses/uploaded_img_conversion_response.dart';
import 'package:photochatapp/services/states/app_running_states.dart';
import 'package:photochatapp/services/states/loading_states.dart';
import 'package:photochatapp/services/utilities/capacity_usage.dart';
import 'package:provider/provider.dart';

/// Send Screen
///
/// {@category Screens}
/// {@category Screens: Send}
class SendScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SendScreen();
  }
}

class _SendScreen extends State<SendScreen> {
  File imageFile;
  imglib.Image editableImage;
  Image image;
  int imageByteSize;
  TextEditingController msgCtrl;
  TextEditingController tokenCtrl;
  bool encrypt;
  bool pickedImg;
  double capacityUsageStats;
  String capacityUsage;
  LoadingState uploadingState;

  Future<void> randomImageFromWeb() async {
    setState(() {
      uploadingState = LoadingState.LOADING;
    });
    AppRunningState appRunningState =
        Provider.of<AppContext>(context, listen: false).getAppRunningState();
    if (appRunningState == AppRunningState.INTEGRATION_TEST) {
      setState(() {
        this.image =
            Image.asset('assets/test_images/corgi.png', fit: BoxFit.fitWidth);
        this.pickedImg = true;
        this.imageByteSize = 1000;
      });
    } else {
      try {
        UploadedImageConversionResponse response =
            await getRandomImageFromWebAsync();
        editableImage = response.editableImage;
        setState(() {
          this.image = response.displayableImage;
          this.pickedImg = true;
          this.imageByteSize = response.imageByteSize;
        });
      } catch (err) {
        await showAlert(err.toString(), context);
        setState(() {
          uploadingState = LoadingState.ERROR;
        });
        return;
      }
    }
    setState(() {
      uploadingState = LoadingState.SUCCESS;
    });
  }

  Future<void> pickImageFromGallery() async {
    setState(() {
      uploadingState = LoadingState.LOADING;
    });
    AppRunningState appRunningState =
        Provider.of<AppContext>(context, listen: false).getAppRunningState();
    if (appRunningState == AppRunningState.INTEGRATION_TEST) {
      setState(() {
        this.image =
            Image.asset('assets/test_images/corgi.png', fit: BoxFit.fitWidth);
        this.pickedImg = true;
        this.imageByteSize = 1000;
      });
    } else {
      imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
      if (imageFile != null) {
        UploadedImageConversionResponse response =
            await convertUploadedImageToDataaAsync(
                UploadedImageConversionRequest(imageFile));
        editableImage = response.editableImage;
        setState(() {
          this.image = response.displayableImage;
          this.pickedImg = true;
          this.imageByteSize = response.imageByteSize;
        });
      }
    }
    setState(() {
      uploadingState = LoadingState.SUCCESS;
    });
  }

  Future<void> pickImageFromCamera() async {
    setState(() {
      this.uploadingState = LoadingState.LOADING;
    });
    AppRunningState appRunningState =
        Provider.of<AppContext>(context, listen: false).getAppRunningState();
    if (appRunningState == AppRunningState.INTEGRATION_TEST) {
      setState(() {
        this.image = Image.asset('assets/test_images/corgi.png');
        this.pickedImg = true;
        this.imageByteSize = 1000;
      });
    } else {
      imageFile = await ImagePicker.pickImage(source: ImageSource.camera);
      if (imageFile != null) {
        UploadedImageConversionResponse response =
            await convertUploadedImageToDataaAsync(
                UploadedImageConversionRequest(imageFile));
        editableImage = response.editableImage;
        setState(() {
          this.image = response.displayableImage;
          this.pickedImg = true;
          this.imageByteSize = response.imageByteSize;
        });
      }
    }
    setState(() {
      this.uploadingState = LoadingState.SUCCESS;
    });
  }

  Future<void> sendToEncode() async {
    EncodeRequest req = EncodeRequest(this.editableImage, msgCtrl.text,
        token: this.tokenCtrl.text);
    Navigator.pushNamed(context, '/encoded', arguments: req);
  }

  Future<void> onMessageChange(String msg) async {
    if (!this.pickedImg ||
        this.editableImage == null ||
        this.image == null ||
        this.imageByteSize == 0) {
      setState(() {
        this.capacityUsage = 'Not applicable, no image uploaded';
        this.capacityUsageStats = 1.0;
      });
    } else {
      double usage = await calculateCapacityUsageAsync(
          CapacityUsageRequest(msg, this.imageByteSize));
      usage = min(usage, 0.99);
      String strUsage = (usage * 100.0).toString();
      if (strUsage.length > 5) {
        strUsage = strUsage.substring(1, 6);
      }
      setState(() {
        this.capacityUsageStats = usage;
        this.capacityUsage = 'Usage: ' + strUsage + '%';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    this.image =
        Image.asset('assets/photo_placeholder.png', fit: BoxFit.fitWidth);
    this.msgCtrl = TextEditingController();
    this.tokenCtrl = TextEditingController();
    this.encrypt = false;
    this.uploadingState = LoadingState.PENDING;
    this.pickedImg = false;
    this.capacityUsage = 'Not applicable, no image uploaded';
    this.capacityUsageStats = 0.0;
    this.imageByteSize = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context).encodeScreenTitle),
          leading: IconButton(
              key: Key('send_screen_back_btn'),
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        body: ScreenAdapter(
          child: Container(
            padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
            child: ListView(
              key: Key('encode_screen_scrollable_list'),
              children: <Widget>[
                SizedBox(
                  height: 5.0,
                ),
                SendScreenImageReview(this.image),
                SizedBox(
                  height: 5.0,
                ),
                SendScreenRandomWebImageBtn(
                  onFetchHandler: this.randomImageFromWeb,
                  loadingState: this.uploadingState,
                ),
                SizedBox(
                  height: 5.0,
                ),
                SendScreenGalleryImageBtn(
                  onUploadHandler: this.pickImageFromGallery,
                  loadingState: this.uploadingState,
                ),
                SizedBox(
                  height: 5.0,
                ),
                SendScreenCameraImageBtn(
                  onOpenHandler: this.pickImageFromCamera,
                  loadingState: this.uploadingState,
                ),
                SizedBox(
                  height: 5.0,
                ),
                Container(
                  child: Text(this.capacityUsage),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Container(
                  child: LinearProgressIndicator(
                    value: this.capacityUsageStats,
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Container(
                  child: TextField(
                    key: Key('encode_screen_msg_input'),
                    controller: this.msgCtrl,
                    onChanged: this.onMessageChange,
                    decoration: InputDecoration(
                      labelText: 'Message',
                    ),
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      Checkbox(
                          key: Key('encode_screen_token_checkbox'),
                          value: this.encrypt,
                          onChanged: (bool nextVal) {
                            setState(() {
                              this.encrypt = nextVal;
                            });
                          }),
                      Text('Encrypt my message!'),
                    ],
                  ),
                ),
                TokenInputField(
                  this.encrypt,
                  this.tokenCtrl,
                  keyVal: 'encode_screen_token_input',
                ),
                SizedBox(
                  height: 5.0,
                ),
                Container(
                  child: RaisedButton(
                    key: Key('encode_screen_encode_btn'),
                    onPressed: this.sendToEncode,
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.email),
                          SizedBox(
                            width: 15.0,
                          ),
                          Text(AppLocalizations.of(context)
                              .encodeScreenEncodeBtnText),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
