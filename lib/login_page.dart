
import 'package:material_ui/material_ui.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F2EA),

      appBar: AppBar(
        title: const Text('SKINOTIC Login'),
        backgroundColor: const Color(0xFFF5F2EA),
      ),

      body: const Center(
        child: Text(
          'Welcome Back to SKINOTIC!',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xFF40594A),
          ),
        ),
      ),
    );
  }
}
