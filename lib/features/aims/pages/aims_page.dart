import 'package:flutter/material.dart';
import 'package:moja_apka/features/auth/pages/user_profile.dart';

class AimsPage extends StatelessWidget {
  const AimsPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Cele'),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const UserProfile(),
                ),
              );
            },
            icon: const Icon(Icons.person),
          ),
        ],
      ),
    );
  }
}
