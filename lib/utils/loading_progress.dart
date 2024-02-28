import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'constant.dart';


class NativeProgress extends StatelessWidget {
  bool? showNative;

  NativeProgress({this.showNative});

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid
        ? showNative!
            ? CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(mainPrimaryColor!),
              )
            : const CupertinoActivityIndicator()
        : Theme(
            data: ThemeData(
                cupertinoOverrideTheme: const CupertinoThemeData(
                    brightness: Brightness.light,
                    primaryColor: Colors.white,
                    barBackgroundColor: Colors.white)),
            child: const CupertinoActivityIndicator());
  }
}
