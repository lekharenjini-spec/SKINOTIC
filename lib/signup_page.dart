
import 'package:material_ui/material_ui.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F2EA),

      appBar: AppBar(
        title: const Text('Sign Up'),
        backgroundColor: const Color(0xFFF5F2EA),
      ),

      body: const Center(
        child: Text(
          'Create Your SKINOTIC Account',
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
