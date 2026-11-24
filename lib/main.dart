 
import 'package:material_ui/material_ui.dart';
 

import 'welcome_page.dart';
import 'home_page.dart';
import 'login_page.dart';
import 'signup_page.dart';


void main() {
  runApp(const SkinoticApp());
}

class SkinoticApp extends StatelessWidget {
  const SkinoticApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SKINOTIC',

      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF7EEE9),

        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF967365),
        ),

        useMaterial3: true,
      ),

      home: const WelcomePage(),

      routes: {
        '/home': (context) => const HomePage(),
        '/login': (context) => const LoginPage(),
        '/signin': (context) => const SignupPage(),
      },
    );
  }
}
