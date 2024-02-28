
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../model/user_model.dart';
import '../utils/AppTextFieldEdit.dart';
import '../utils/base_controller.dart';
import '../utils/constant.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var nameCon = TextEditingController();
  var addrCon = TextEditingController();
  var emailCon = TextEditingController();
  var birthdayCon = TextEditingController();
  var postalCon = TextEditingController();
  var cityCon = TextEditingController();
  var passwordCon = TextEditingController();
  var confirmPasswordCon = TextEditingController();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passWordFocusNode = FocusNode();
  FocusNode nameFocusNode = FocusNode();
  FocusNode confirmPassWordFocusNode = FocusNode();
  FocusNode addressFocusNode = FocusNode();
  FocusNode birthdayFocusNode = FocusNode();
  FocusNode postalFocusNode = FocusNode();
  FocusNode cityFocusNode = FocusNode();

  final _formKey = GlobalKey<FormState>();
  BaseController? baseController;
  @override
  void initState() {
    baseController = BaseController(context, () {});

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
            leading:  IconButton(
              onPressed: () {
                finish(context);
              },
              icon: const Icon(Icons.arrow_back_ios_new,
                  color: Colors.white, size: 18),
              color: Colors.white,
            ),            centerTitle: true,
            title: const Text("MIAGED",
              textAlign: TextAlign.center,
              style: TextStyle(fontFamily: popinsFont,fontWeight: FontWeight.w700,fontSize: 18),),
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
                    controller: nameCon,
                    textFieldType: TextFieldType.NAME,
                    textStyle: const TextStyle(color: Colors.black54),
                    focus: nameFocusNode,
                    nextFocus: emailFocusNode,
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
                      FocusScope.of(context).requestFocus(emailFocusNode);
                    },
                  ),
                  AppTextField(
                    controller: emailCon,
                    textFieldType: TextFieldType.EMAIL,
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
                    focus: emailFocusNode,
                    nextFocus: addressFocusNode,
                    isValidationRequired: true,
                    onFieldSubmitted: (v) {
                      FocusScope.of(context).requestFocus(passWordFocusNode);
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
                  AppTextField(
                    controller: postalCon,
                    textFieldType: TextFieldType.NUMBER,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],

                    textStyle: const TextStyle(color: Colors.black54),
                    focus: postalFocusNode,
                    nextFocus: passWordFocusNode,
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
                      FocusScope.of(context).requestFocus(passWordFocusNode);
                    },
                  ),
                  AppTextField(
                    controller: passwordCon,
                    textFieldType: TextFieldType.PASSWORD,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],

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
                    focus: passWordFocusNode,
                    nextFocus: confirmPassWordFocusNode,
                    isValidationRequired: true,
                    onFieldSubmitted: (v) {
                      FocusScope.of(context)
                          .requestFocus(confirmPassWordFocusNode);
                    },
                  ),
                  AppTextFieldEdit(
                    textInputAction: TextInputAction.done,
                    retypePassword: passwordCon,
                    decoration: const InputDecoration(
                      labelText: 'Confirm Password',
                      labelStyle: TextStyle(color: black),
                      hintStyle: TextStyle(fontSize: 12),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                    textFieldTypeEdit: TextFieldType.PASSWORD,

                    isPassword: true,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],

                    controller: confirmPasswordCon,
                    focus: confirmPassWordFocusNode,
                    isValidationRequired: true,
                    onFieldSubmitted: (_) => FocusScope.of(context)
                        .unfocus(), // Unfocus and hide keyboard
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        createAccount();
                      }
                    },
                    child: Container(
                      height: screenHeight(context) * 0.07,
                      width: screenWidth(context) * 0.6,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: boxDecorationWithRoundedCorners(
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                        backgroundColor:mainPrimaryColor!,
                      ),
                      child:
                          Text('Sign Up', style: boldTextStyle(color: white)),
                    ),
                  ),
                  SizedBox(height: 8),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LoginWithPassScreen()),
                      );
                    },
                    child: Text.rich(
                      TextSpan(
                        text: "Already have an account? ",
                        style: secondaryTextStyle(),
                        children: [
                          TextSpan(
                              text: ' Sign in', style: boldTextStyle(size: 14)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ),
    ));
  }

  void createAccount() async {
    try {
      baseController?.showProgress("");
      FirebaseAuth auth = FirebaseAuth.instance;
      UserCredential newUser = await auth.createUserWithEmailAndPassword(
          email: emailCon.text, password: passwordCon.text);
      if (kDebugMode) {
        print("user id : ${newUser.user?.uid}");
      }

        UserModel userModel = UserModel();
        userModel.name = nameCon.text;
        userModel.email = emailCon.text;
        userModel.address = addrCon.text;
        userModel.timestamp = Timestamp.now();
        userModel.id = newUser.user?.uid;
        userModel.birthday = birthdayCon.text;
        userModel.city = cityCon.text;
        userModel.postalCode = int.parse(postalCon.text);
        userModel.password = passwordCon.text;

        await userModel.add();

      baseController?.hideProgress();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginWithPassScreen()),
      );
      QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        text: 'Your account created Successfully',
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        baseController?.hideProgress();
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          text: 'The password provided is too weak.',
        );
      } else if (e.code == 'email-already-in-use') {
        baseController?.hideProgress();
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          text: 'The account already exists for that email.',
        );
      }
    } catch (e) {
      baseController?.hideProgress();
      print(e.toString());
    }
  }
}
