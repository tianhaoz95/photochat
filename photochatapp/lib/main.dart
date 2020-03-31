import 'package:flutter/material.dart';
import 'package:photochatapp/app/app.dart';
import 'package:photochatapp/services/states/app_running_states.dart';

/// Entry Point
/// 
/// {@category App}
void main() => runApp(PhotoChatApp(AppRunningState.PRODUCTION));
