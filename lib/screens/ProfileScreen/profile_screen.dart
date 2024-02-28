import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:m2miage/screens/Dashboard/dashboard_screen.dart';
import 'package:m2miage/screens/login_screen.dart';
import 'package:m2miage/utils/constant.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../../utils/base_controller.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var nameCon = TextEditingController();
  var addrCon = TextEditingController();
  var birthdayCon = TextEditingController();
  var postalCon = TextEditingController();
  var cityCon = TextEditingController();
  var emailCon = TextEditingController();
  var passCon = TextEditingController();

  FocusNode nameFocusNode = FocusNode();
  FocusNode addressFocusNode = FocusNode();
  FocusNode birthdayFocusNode = FocusNode();
  FocusNode postalFocusNode = FocusNode();
  FocusNode cityFocusNode = FocusNode();

  final _formKey = GlobalKey<FormState>();
  BaseController? baseController;

  @override
  void initState() {
    baseController = BaseController(context, () {});
    nameCon.text = Constants.userModel!.name!;
    addrCon.text = Constants.userModel!.address!;
    birthdayCon.text = Constants.userModel!.birthday!;
    postalCon.text = Constants.userModel!.postalCode!.toString();
    cityCon.text = Constants.userModel!.city!;
    emailCon.text = Constants.userModel!.email!;
    passCon.text = Constants.userModel!.password!;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          "Profile",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: popinsFont,
              fontWeight: FontWeight.w700,
              fontSize: 18),
        ),
        actions: [
          Center(
      child:
          Container(
            margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: GestureDetector(
                child: Text(
                  'Logout',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 17,
                    shadows: [
                      Shadow(color: Colors.white, offset: Offset(0, -2))
                    ],
                    color: Colors.transparent,
                    decoration: TextDecoration.underline,
                    decorationColor: mainPrimaryColor,
                    decorationThickness: 4,
                    decorationStyle: TextDecorationStyle.solid,
                  ),
                ),
                onTap: () async {
                  Constants.userList.removeWhere((element) =>
                  element.email ==
                      Constants.userModel!.email);
                  await FirebaseAuth.instance.signOut();
                  finish(context);
                  const LoginWithPassScreen().launch(context);
                },
              ))),
        ],
        backgroundColor: mainPrimaryColor,
      ),
      body: SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  AppTextField(
                    controller: emailCon,
                    textFieldType: TextFieldType.EMAIL,
                    enabled: false,
                    textStyle: const TextStyle(color: Colors.black54),
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(color: black),
                      hintStyle: TextStyle(fontSize: 12),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                    isValidationRequired: false,
                    onFieldSubmitted: (v) {
                      FocusScope.of(context).requestFocus(birthdayFocusNode);
                    },
                  ),
                  AppTextField(
                    controller: passCon,
                    textFieldType: TextFieldType.PASSWORD,
                    enabled: false,
                    textStyle: const TextStyle(color: Colors.black54),
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(color: black),
                      hintStyle: TextStyle(fontSize: 12),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                    isValidationRequired: false,
                    onFieldSubmitted: (v) {
                      FocusScope.of(context).requestFocus(birthdayFocusNode);
                    },
                  ),
                  AppTextField(
                    controller: nameCon,
                    textFieldType: TextFieldType.NAME,
                    textStyle: const TextStyle(color: Colors.black54),
                    focus: nameFocusNode,
                    nextFocus: birthdayFocusNode,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      labelStyle: TextStyle(color: black),
                      hintStyle: TextStyle(fontSize: 12),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                    isValidationRequired: true,
                    onFieldSubmitted: (v) {
                      FocusScope.of(context).requestFocus(birthdayFocusNode);
                    },
                  ),
                  AppTextField(
                    controller: birthdayCon,
                    textFieldType: TextFieldType.NAME,
                    textStyle: const TextStyle(color: Colors.black54),
                    focus: birthdayFocusNode,
                    nextFocus: addressFocusNode,
                    decoration: const InputDecoration(
                      hintText: "02/02/23",
                      labelText: 'Birthday',
                      labelStyle: TextStyle(color: black),
                      hintStyle: TextStyle(fontSize: 12),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                    isValidationRequired: false,
                    onFieldSubmitted: (v) {
                      FocusScope.of(context).requestFocus(cityFocusNode);
                    },
                  ),
                  AppTextField(
                    controller: addrCon,
                    textFieldType: TextFieldType.ADDRESS,
                    textStyle: const TextStyle(color: Colors.black54),
                    focus: addressFocusNode,
                    nextFocus: cityFocusNode,
                    decoration: const InputDecoration(
                      labelText: 'Address',
                      labelStyle: TextStyle(color: black),
                      hintStyle: TextStyle(fontSize: 12),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                    isValidationRequired: false,
                    onFieldSubmitted: (v) {
                      FocusScope.of(context).requestFocus(cityFocusNode);
                    },
                  ),
                  AppTextField(
                    controller: postalCon,
                    textFieldType: TextFieldType.NUMBER,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                    textStyle: const TextStyle(color: Colors.black54),
                    focus: postalFocusNode,
                    decoration: const InputDecoration(
                      labelText: 'Postal Code',
                      labelStyle: TextStyle(color: black),
                      hintStyle: TextStyle(fontSize: 12),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                    isValidationRequired: false,
                    onFieldSubmitted: (v) {
                      FocusScope.of(context).unfocus();
                    },
                  ),
                  AppTextField(
                    controller: cityCon,
                    textFieldType: TextFieldType.NAME,
                    textStyle: const TextStyle(color: Colors.black54),
                    focus: cityFocusNode,
                    nextFocus: postalFocusNode,
                    decoration: const InputDecoration(
                      labelText: 'City',
                      labelStyle: TextStyle(color: black),
                      hintStyle: TextStyle(fontSize: 12),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                    isValidationRequired: false,
                    onFieldSubmitted: (v) {
                      FocusScope.of(context).requestFocus(postalFocusNode);
                    },
                  ),

                  const SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        update();
                      }
                    },
                    child: Container(
                      height: screenHeight(context) * 0.07,
                      width: screenWidth(context) * 0.6,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: boxDecorationWithRoundedCorners(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        backgroundColor: mainPrimaryColor!,
                      ),
                      child: Text('Save', style: boldTextStyle(color: white)),
                    ),
                  ),
                ],
              ),
            )),
      ),
    ));
  }

  void update() async {
    try {
      baseController?.showProgress("");

      Constants.userModel!.name = nameCon.text;
      Constants.userModel!.address = addrCon.text;
      Constants.userModel!.timestamp = Timestamp.now();
      Constants.userModel!.birthday = birthdayCon.text;
      Constants.userModel!.city = cityCon.text;
      Constants.userModel!.postalCode = int.parse(postalCon.text);

      await Constants.userModel!.update();

      baseController?.hideProgress();
      DashBoardScreen().launch(context);
      QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        text: 'Your account saved Successfully',
      );
    } on FirebaseAuthException catch (e) {
      baseController?.hideProgress();
      print(e.toString());
    }
  }
}
