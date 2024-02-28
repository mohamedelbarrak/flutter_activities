
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:m2miage/screens/forget_password_screen.dart';
import 'package:m2miage/screens/sign_up_screen.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../model/user_model.dart';
import '../utils/base_controller.dart';
import '../utils/constant.dart';
import 'Dashboard/dashboard_screen.dart';

class LoginWithPassScreen extends StatefulWidget {
  const LoginWithPassScreen({Key? key}) : super(key: key);

  @override
  State<LoginWithPassScreen> createState() => _LoginWithPassScreenState();
}

class _LoginWithPassScreenState extends State<LoginWithPassScreen> {
  var emailCon = TextEditingController();
  var passwordCon = TextEditingController();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passWordFocusNode = FocusNode();
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
            automaticallyImplyLeading: false,
            centerTitle: true,
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

                  const SizedBox(height: 20),

                  AppTextField(
                    controller: emailCon,
                    textFieldType: TextFieldType.EMAIL,
                    keyboardType: TextInputType.emailAddress,
                    textStyle: const TextStyle(color: Colors.black54),
                    focus: emailFocusNode,
                    nextFocus: passWordFocusNode,
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
                    isValidationRequired: true,
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
                    isValidationRequired: true,
                    onFieldSubmitted: (_) => FocusScope.of(context).unfocus(),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        _login();
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
                          Text('Log in', style: boldTextStyle(color: white)),
                    ),
                  ),

                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: () {
                     ForgetPasswordScreen().launch(context);
                    },
                    child:
                        Text('Forgot the password ?', style: boldTextStyle()),
                  ),

                  const SizedBox(height: 24),

                  TextButton(
                    onPressed: () {
                    SignUpScreen().launch(context);
                    },
                    child: Text.rich(
                      TextSpan(
                        text: "Don't have an account? ",
                        style: secondaryTextStyle(),
                        children: [
                          TextSpan(
                              text: ' Sign up', style: boldTextStyle(size: 14)),
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

  void _login() async {
    baseController?.showProgress("");
    final FirebaseAuth auth = FirebaseAuth.instance;
    try {
      await auth.signInWithEmailAndPassword(
          email: emailCon.text, password: passwordCon.text);
      User? currentUser = auth.currentUser;
      Constants.userList = await UserModel().getList();
      Constants.userModel = Constants.userList.firstWhere(
          (element) => element.id == currentUser?.uid,
          orElse: () => UserModel());

      baseController!.hideProgress();
      DashBoardScreen().launch(context);
    } on FirebaseException catch (e) {
      baseController?.hideProgress();
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        text: e.message,
      );
    }
  }
}
