import 'package:flutter/material.dart';
import '../model/user_model.dart';
import 'base_controller.dart';

BaseController? baseController;
const String popinsFont = "Poppins";
var mainPrimaryColor = Colors.green[400];

class Constants {
  static UserModel? userModel;
  static List<UserModel> userList = [];
}

double screenHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

double screenWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}
