import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photochatapp/components/btn_logo/btn_logo_with_loading_error.dart';
import 'package:photochatapp/components/screen_adapter/screen_adapter.dart';
import 'package:photochatapp/components/token_input_field/token_input_field.dart';
import 'package:photochatapp/services/context/app_context.dart';
import 'package:photochatapp/services/converters/uploaded_img_to_data.dart';
import 'package:photochatapp/services/requests/encode_request.dart';
import 'package:image/image.dart' as imglib;
import 'package:photochatapp/services/requests/uploaded_img_conversion_request.dart';
import 'package:photochatapp/services/responses/uploaded_img_conversion_response.dart';
import 'package:photochatapp/services/states/app_running_states.dart';
import 'package:photochatapp/services/states/loading_states.dart';
import 'package:provider/provider.dart';

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
  TextEditingController msgCtrl;
  TextEditingController tokenCtrl;
  bool encrypt;
  LoadingState uploadingState;

  Future<void> randomImageFromWeb() async {
    setState(() {
      uploadingState = LoadingState.LOADING;
    });
    AppRunningState appRunningState =
        Provider.of<AppContext>(context, listen: false).getAppRunningState();
    if (appRunningState == AppRunningState.INTEGRATION_TEST) {
      setState(() {
        this.image = Image.asset('assets/test_images/corgi.png');
      });
    } else {
      UploadedImageConversionResponse response =
          await getRandomImageFromWebAsync();
      editableImage = response.editableImage;
      setState(() {
        this.image = response.displayableImage;
      });
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
        this.image = Image.asset('assets/test_images/corgi.png');
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

  @override
  void initState() {
    super.initState();
    this.image =
        Image.asset('assets/photo_placeholder.png', fit: BoxFit.fitWidth);
    this.msgCtrl = TextEditingController();
    this.tokenCtrl = TextEditingController();
    this.encrypt = false;
    this.uploadingState = LoadingState.PENDING;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Encode a Message'),
        ),
        resizeToAvoidBottomInset: false,
        body: ScreenAdapter(
          child: Container(
            padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
            child: ListView(
              key: Key('encode_screen_scrollable_list'),
              children: <Widget>[
                SizedBox(
                  height: 5.0,
                ),
                Container(
                    constraints: BoxConstraints(
                      minHeight: 200,
                      maxHeight: 600,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: this.image,
                    )),
                SizedBox(
                  height: 5.0,
                ),
                Container(
                  child: RaisedButton(
                    onPressed: this.randomImageFromWeb,
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          ButtonLogoWithLoadingAndError(
                              this.uploadingState, Icons.scatter_plot),
                          SizedBox(
                            width: 15.0,
                          ),
                          Text('Random'),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Container(
                  child: RaisedButton(
                    key: Key('encode_pick_image_from_gallery_btn'),
                    onPressed: this.pickImageFromGallery,
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          ButtonLogoWithLoadingAndError(
                              this.uploadingState, Icons.camera),
                          SizedBox(
                            width: 15.0,
                          ),
                          Text('Gallery'),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Container(
                  child: RaisedButton(
                    onPressed: this.pickImageFromCamera,
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          ButtonLogoWithLoadingAndError(
                              this.uploadingState, Icons.camera_alt),
                          SizedBox(
                            width: 15.0,
                          ),
                          Text('Camera'),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Container(
                  child: TextField(
                    key: Key('encode_screen_msg_input'),
                    controller: this.msgCtrl,
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
                          Text('Encode'),
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
