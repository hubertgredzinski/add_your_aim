import 'package:flutter/material.dart';
import 'package:moja_apka/features/auth/pages/user_profile.dart';

class AddAimPage extends StatelessWidget {
  const AddAimPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Ustaw cel'),
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
