import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

enum ActionStyle { normal, destructive, important, important_destructive }

class AppDialog {
  static Color _normal = Colors.black;
  static Color _destructive = Colors.red;

  /// show the OS Native dialog
  showOSDialog(BuildContext context, String title, String message,
      String firstButtonText, Function firstCallBack,
      {ActionStyle firstActionStyle = ActionStyle.normal,
      String? secondButtonText,
      Function? secondCallback,
      ActionStyle secondActionStyle = ActionStyle.normal}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        if (Platform.isIOS) {
          return WillPopScope(
            onWillPop: () async => false,
            child: _iosDialog(
                context, title, message, firstButtonText, firstCallBack,
                firstActionStyle: firstActionStyle,
                secondButtonText: secondButtonText,
                secondCallback: secondCallback,
                secondActionStyle: secondActionStyle),
          );
        } else {
          return WillPopScope(
            onWillPop: () async => false,
            child: _androidDialog(
                context, title, message, firstButtonText, firstCallBack,
                firstActionStyle: firstActionStyle,
                secondButtonText: secondButtonText,
                secondCallback: secondCallback,
                secondActionStyle: secondActionStyle),
          );
        }
      },
    );
  }

  /// show the android Native dialog
  Widget _androidDialog(BuildContext context, String title, String message,
      String firstButtonText, Function firstCallBack,
      {ActionStyle firstActionStyle = ActionStyle.normal,
      String? secondButtonText,
      Function? secondCallback,
      ActionStyle secondActionStyle = ActionStyle.normal}) {
    List<TextButton> actions = [];
    actions.add(TextButton(
      child: Text(
        firstButtonText,
        style: TextStyle(
            color: (firstActionStyle == ActionStyle.important_destructive ||
                    firstActionStyle == ActionStyle.destructive)
                ? _destructive
                : _normal,
            fontWeight:
                (firstActionStyle == ActionStyle.important_destructive ||
                        firstActionStyle == ActionStyle.important)
                    ? FontWeight.bold
                    : FontWeight.normal),
      ),
      onPressed: () {
        Navigator.of(context).pop();
        firstCallBack();
      },
    ));

    if (secondButtonText != null) {
      actions.add(TextButton(
        child: Text(secondButtonText,
            style: TextStyle(
                color:
                    (secondActionStyle == ActionStyle.important_destructive ||
                            firstActionStyle == ActionStyle.destructive)
                        ? _destructive
                        : _normal)),
        onPressed: () {
          Navigator.of(context).pop();
          secondCallback!();
        },
      ));
    }

    return AlertDialog(
        title: Text(title), content: Text(message), actions: actions);
  }

  /// show the iOS Native dialog
  Widget _iosDialog(BuildContext context, String title, String message,
      String firstButtonText, Function firstCallback,
      {ActionStyle firstActionStyle = ActionStyle.normal,
      String? secondButtonText,
      Function? secondCallback,
      ActionStyle secondActionStyle = ActionStyle.normal}) {
    List<CupertinoDialogAction> actions = [];
    actions.add(
      CupertinoDialogAction(
        isDefaultAction: true,
        onPressed: () {
          Navigator.of(context).pop();
          firstCallback();
        },
        child: Text(
          firstButtonText,
          style: TextStyle(
              color: (firstActionStyle == ActionStyle.important_destructive ||
                      firstActionStyle == ActionStyle.destructive)
                  ? _destructive
                  : _normal,
              fontWeight:
                  (firstActionStyle == ActionStyle.important_destructive ||
                          firstActionStyle == ActionStyle.important)
                      ? FontWeight.bold
                      : FontWeight.normal),
        ),
      ),
    );

    if (secondButtonText != null) {
      actions.add(
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () {
            Navigator.of(context).pop();
            secondCallback!();
          },
          child: Text(
            secondButtonText,
            style: TextStyle(
                color:
                    (secondActionStyle == ActionStyle.important_destructive ||
                            secondActionStyle == ActionStyle.destructive)
                        ? _destructive
                        : _normal,
                fontWeight:
                    (secondActionStyle == ActionStyle.important_destructive ||
                            secondActionStyle == ActionStyle.important)
                        ? FontWeight.bold
                        : FontWeight.normal),
          ),
        ),
      );
    }

    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(message),
      actions: actions,
    );
  }
}

class CustomDialog extends StatelessWidget {
  final String? title, description, buttonText;
  final Image? image;
  final Function? function;

  CustomDialog(
      {this.title,
      this.description,
      this.buttonText,
      this.image,
      this.function});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
            padding: const EdgeInsets.only(
                top: 100, bottom: 16, left: 16, right: 16),
            margin: const EdgeInsets.only(top: 16),
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(17),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10.0,
                    offset: Offset(0.0, 10.0),
                  )
                ]),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  title!,
                  style: const TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 24.0),
                Text(description!, style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 24.0),
                Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton(
                    onPressed: () {
                      if (function != null) {
                        function!.call();
                      } else
                        Navigator.pop(context);
                    },
                    child: Text(buttonText!),
                  ),
                )
              ],
            )),
        Positioned(
            top: 0,
            left: 16,
            right: 16,
            child: CircleAvatar(
              backgroundColor: Colors.blueAccent,
              radius: 50,
              child: ClipOval(
                child: image,
              ),
            ))
      ],
    );
  }
}
