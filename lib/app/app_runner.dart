import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meals/src/di/injector.dart';

import 'app.dart';

Stream<String> refreshStream;

void runApplication() async {
  _injectDependencies();
  _setupErrorHandling();
  _setPortraitMode();
  _runApp();
}

void _setupErrorHandling() {
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
  };
}

void _injectDependencies() => Injector.inject();

Future _setPortraitMode() async {
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.landscapeRight,
  ]);
}

void _runApp() {
  runApp(MealsApp());
}
