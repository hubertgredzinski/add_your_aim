import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:moja_apka/features/auth/pages/user_profile.dart';

class AddAimPage extends StatelessWidget {
  AddAimPage({
    Key? key,
  }) : super(key: key);

  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(226, 236, 236, 236),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          FirebaseFirestore.instance.collection('goal').add;
          ({
            'title': controller.text,
          });
          controller.clear();
        },
        child: const Icon(Icons.add),
      ),
      body: ListView(
        children: [
          TextField(
            controller: controller,
          )
        ],
      ),
    );
  }
}
