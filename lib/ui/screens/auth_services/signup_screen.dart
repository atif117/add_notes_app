import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/ui/custom_widgets/custom_button.dart';
import 'package:notes_app/ui/custom_widgets/custom_textfield.dart';
import 'package:notes_app/ui/screens/auth_services/login_signup_view_model.dart';
import 'package:provider/provider.dart';

import '../../../core/color.dart';
import '../../../core/style.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => LoginSignupViewModel(),
        child: Consumer<LoginSignupViewModel>(
          builder: (context, model, child) {
            return Scaffold(
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SingleChildScrollView(
                      child: Column(children: [
                        upperBodySection(),
                        textFieldSection(model),
                        const SizedBox(height: 15),
                        CustomButton(
                          labelText: 'Sign Up',
                          buttonColor: kPrimaryColor,
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              model.signUpWithEmailPassword();
                            }
                          },
                        ),
                        const SizedBox(height: 15),
                        lowerTextSection()
                      ]),
                    ),
                  ),
                ],
              ),
            );
          },
        ));
  }

  upperBodySection() {
    return Column(
      children: [
        Column(
          children: [
            Text('Sign Up', style: headingTextStyle),
            Text("Create new account", style: subHeadingTextStyle),
            const SizedBox(
              height: 50,
            )
          ],
        ),
      ],
    );
  }

  textFieldSection(LoginSignupViewModel model) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          CustomTextField(
            labelText: 'Name',
            onChanged: (value) {
              model.appUser.name = value;
            },
            validate: (val) {
              if (val.isEmpty) {
                return 'Enter Name';
              }
            },
          ),
          CustomTextField(
            labelText: 'Email',
            icon: Icons.email,
            onChanged: (value) {
              model.appUser.email = value;
            },
            validate: (val) {
              if (val.isEmpty) {
                return "Enter your Email";
              }
            },
          ),
          CustomTextField(
            labelText: 'Password',
            icon: Icons.lock,
            obscureText: true,
            onChanged: (value) {
              model.appUser.password = value;
            },
            validate: (val) {
              if (val.isEmpty) {
                return 'enter password';
              }
            },
          )
        ],
      ),
    );
  }

  lowerTextSection() {
    return RichText(
        text: TextSpan(children: [
      TextSpan(text: "Already have account? ", style: bodyTextStyle),
      TextSpan(
          recognizer: TapGestureRecognizer()..onTap = () => Get.back(),
          text: 'Log In',
          style: bodyTextStyle.copyWith(
            color: kPrimaryColor,
          )),
    ]));
  }
}
