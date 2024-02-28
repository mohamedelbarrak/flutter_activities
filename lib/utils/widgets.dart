
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import 'constant.dart';


InputDecoration waInputDecoration({
  IconData? prefixIcon,
  required String hint,
}) {
  return InputDecoration(
    contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
    counter: const Offstage(),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide(color: mainPrimaryColor!)),
    enabledBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(5)),
      borderSide: BorderSide(color: Colors.grey.withOpacity(0.2)),
    ),
    fillColor: white,
    hintText: hint,
    prefixIcon:
        prefixIcon != null ? Icon(prefixIcon, color: mainPrimaryColor) : null,
    hintStyle: secondaryTextStyle(fontFamily: popinsFont),
    filled: true,
  );
}
