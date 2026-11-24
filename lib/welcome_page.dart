
import 'package:material_ui/material_ui.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  static const Color green = Color(0xFF40594A);
  static const Color cream = Color(0xFFF5F2EA);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cream,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(28),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                const Icon(
                  Icons.spa_outlined,
                  size: 75,
                  color: green,
                ),

                const SizedBox(height: 15),

                const Text(
                  'SKINOTIC',
                  style: TextStyle(
                    fontSize: 38,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 5,
                    color: green,
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  'BEAUTY MEETS SCIENCE',
                  style: TextStyle(
                    fontSize: 12,
                    letterSpacing: 3,
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 55),

                const Text(
                  'Welcome to SKINOTIC',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                    color: green,
                  ),
                ),

                const SizedBox(height: 12),

                const Text(
                  'Discover the science behind your cosmetics.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),

                const SizedBox(height: 40),

                // SIGN IN BUTTON
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/signin');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: green,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('SIGN IN'),
                  ),
                ),

                const SizedBox(height: 18),

                // LOG IN BUTTON
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: green,
                      side: const BorderSide(color: green),
                    ),
                    child: const Text('LOG IN'),
                  ),
                ),

                const SizedBox(height: 18),

                // GUEST BUTTON
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/home');
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: green,
                      side: const BorderSide(color: green),
                    ),
                    child: const Text('CONTINUE AS GUEST'),
                  ),
                ),

                const SizedBox(height: 35),

                const Text(
                  'Understand your ingredients. Know your products.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black45,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
