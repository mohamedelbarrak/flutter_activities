import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:m2miage/screens/login_screen.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import '../../../utils/base_controller.dart';
import '../utils/constant.dart';
import '../utils/widgets.dart';

class ForgetPasswordScreen extends StatefulWidget {
  static String tag = '/ForgetPasswordScreen';

  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  ForgetPasswordScreenState createState() => ForgetPasswordScreenState();
}

class ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  FocusNode email = FocusNode();
  TextEditingController emailController = TextEditingController();
  var form_key = GlobalKey<FormState>();

  @override
  void initState() {
    baseController = BaseController(context, () {});
    super.initState();
    init();
  }

  init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
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
          title: const Text("Forget Password",
            textAlign: TextAlign.center,
            style: TextStyle(fontFamily: popinsFont,fontWeight: FontWeight.w700,fontSize: 18),),
          backgroundColor: mainPrimaryColor,

        ),
        body: SizedBox(
          height: context.height(),
          width: context.width(),
          child: Stack(
            alignment: AlignmentDirectional.topCenter,
            children: [
              Container(
                  margin: const EdgeInsets.only(top: 30),
                  padding: const EdgeInsets.only(
                      top: 30, left: 16, right: 16, bottom: 16),
                  width: context.width(),
                  height: context.height(),
                  decoration: boxDecorationWithShadow(
                      backgroundColor: context.cardColor,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30))),
                  child: SingleChildScrollView(
                      child: Form(
                    key: form_key,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                    color: Colors.grey.withOpacity(0.2),
                                    width: 0.5)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                16.height,
                                AppTextField(
                                  controller: emailController,
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
                                  isValidationRequired: true,

                                ),
                                30.height,

                                GestureDetector(
                                  onTap: () {
                                    if (form_key.currentState!.validate()) {
                                      forgetPassword();
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
                                    Text('Send Email', style: boldTextStyle(color: white)),
                                  ),
                                ),


                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const LoginWithPassScreen()));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Back to login?",
                                    style: TextStyle(
                                        fontSize: 16, fontFamily: popinsFont)),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text('Sign In',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: mainPrimaryColor,
                                        fontFamily: popinsFont)),
                              ],
                            ),
                          )
                        ]),
                  )))
            ],
          ).paddingTop(90),
        ),
      ),
    );
  }

  void forgetPassword() async {
    try {
      baseController?.showProgress("");
      FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text)
          .then((value) {
        baseController?.hideProgress();
        const LoginWithPassScreen().launch(context);
        QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          text: 'Forget password email has been sent to you',
        );
      });
    } on FirebaseAuthException catch (e) {
      baseController?.hideProgress();
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        text: e.message,
      );
      if (kDebugMode) {
        print("print :${e.message}");
      }
    }
  }
}
