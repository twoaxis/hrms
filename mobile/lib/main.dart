import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hrms/view/onboarding/login/screen/login_page.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HRMS',
      theme: ThemeData(primarySwatch: Colors.blue),

      home: const LoginPage(),
    );
  }
}
