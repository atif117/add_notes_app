import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/firebase_options.dart';
import 'package:notes_app/ui/screens/add_note/add_note_screen.dart';
import 'package:notes_app/ui/screens/auth_services/login_screen.dart';
import 'package:notes_app/ui/screens/auth_services/login_screen.dart';
import 'package:notes_app/ui/screens/auth_services/login_signup_view_model.dart';
import 'package:notes_app/ui/screens/home/home_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      // builder: (context, Widget) => MultiProvider(providers: [
      //   ChangeNotifierProvider(
      //     create: (context) => LoginSignupViewModel(),
      //   )
      // ]),
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,

        // useMaterial3: true,
      ),
      home: FirebaseAuth.instance.currentUser != null
          ? const HomeScreen()
          : LogInScreen(),
    );
  }
}
