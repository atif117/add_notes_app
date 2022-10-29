import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/core/color.dart';
import 'package:notes_app/core/style.dart';
import 'package:notes_app/ui/custom_widgets/custom_textfield.dart';
import 'package:notes_app/ui/screens/auth_services/login_signup_view_model.dart';
import 'package:notes_app/ui/screens/auth_services/signup_screen.dart';
import 'package:provider/provider.dart';

import '../../custom_widgets/custom_button.dart';

class LogInScreen extends StatelessWidget {
  LogInScreen({super.key});

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
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          upperSection(),
                          textFieldSection(model),
                          const SizedBox(height: 50),
                          CustomButton(
                            labelText: 'Login',
                            buttonColor: kPrimaryColor,
                            onTap: () {
                              if (formKey.currentState!.validate()) {
                                model.logInWithEmailAndPassword();
                              }
                            },
                          ),
                          const SizedBox(height: 15),
                          lowerTextSection()
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ));
  }

  upperSection() {
    return Column(
      children: [
        Text('Welcome Back!', style: headingTextStyle),
        Text("Login to your account", style: subHeadingTextStyle),
        const SizedBox(
          height: 50,
        )
      ],
    );
  }

  textFieldSection(LoginSignupViewModel model) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          CustomTextField(
            labelText: 'Email',
            icon: Icons.email,
            onChanged: (value) {
              model.appUser.email = value;
            },
            validate: (val) {
              if (val.isEmpty) {
                return 'Please enter email';
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
                return "Enter password";
              }
            },
          ),
        ],
      ),
    );
  }

  lowerTextSection() {
    return RichText(
        text: TextSpan(children: [
      TextSpan(text: "Don't have account? ", style: bodyTextStyle),
      TextSpan(
          recognizer: TapGestureRecognizer()
            ..onTap = () => Get.to(SignUpScreen()),
          text: 'Sign Up',
          style: bodyTextStyle.copyWith(
            color: kPrimaryColor,
          )),
    ]));
  }
}
