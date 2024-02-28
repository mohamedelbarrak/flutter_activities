import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'dialogs.dart';
import 'loading_progress.dart';

//**************************************************
class BaseController //**************************************************
{
  final BuildContext _context;
  BuildContext? _dialogContext;
  Function? onStateChange;

  //**************************************************
  BaseController(this._context, this.onStateChange)
  //**************************************************
  {
    dismissKeyBoard();
    /* KeyboardVisibilityNotification().addNewListener(
      onChange: (bool visible) {
        print("keyboard");
        print(visible);
        if (visible) {
          KeyBoardController.showOverlay(_context);
          return;
        }
        KeyBoardController.removeOverlay();
      },
    );*/
  }

  //**************************************************
  void dismissKeyBoard()
  //**************************************************
  {
    // FocusScope.of(_context).requestFocus(FocusNode());
  }

  //**************************************************
  void showProgress(String description)
  //**************************************************
  {
    // QuickAlert.show(
    //   barrierDismissible: false,
    //   context: _context,
    //   type: QuickAlertType.loading,
    //   title: "Loading .......",
    //   text: description,
    // );
    showDialog(
        context: _context,
        barrierDismissible: false,
        builder: (context) {
          _dialogContext = context;
          return AlertDialog(
              title: Column(
            children: [
              Row(
                children: [
                  kIsWeb?CircularProgressIndicator():NativeProgress(showNative: true),
                  SizedBox(width: 20),
                  Text(
                    "Loading....",
                    style: TextStyle(fontSize: 17),
                  ),
                ],
              )
            ],
          ));
        });
  }

  //***************************************************************************
  void showMessage(String title, String message, Function positiveCallBack,
      {String? positiveText, String? negativeText, Function? negativeCallBack})
  //***************************************************************************
  {
    if (negativeText != null && negativeCallBack != null) {
      AppDialog().showOSDialog(
          _context, title, message, positiveText ?? "OK", positiveCallBack,
          secondButtonText: negativeText);
      return;
    }
    AppDialog().showOSDialog(
        _context, title, message, positiveText ?? "OK", positiveCallBack);
  }

  //**************************************************
  void stateChange()
  //**************************************************
  {
    onStateChange?.call();
  }

  //**************************************************
  void hideProgress()
  //**************************************************
  {
    try {
      if (_dialogContext != null) Navigator.pop(_dialogContext!);
    } catch (E) {}
  }
}
