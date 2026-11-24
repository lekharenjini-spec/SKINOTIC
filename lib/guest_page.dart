
import 'package:material_ui/material_ui.dart';

class GuestPage extends StatelessWidget {
  const GuestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Guest')),
      body: const Center(
        child: Text('Welcome to SKINOTIC!'),
      ),
    );
  }
}
