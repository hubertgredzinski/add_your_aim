import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:moja_apka/features/auth/pages/user_profile.dart';

class AimsPage extends StatelessWidget {
  const AimsPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(226, 236, 236, 236),
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

      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('goal').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Wystąpił błąd');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Proszę czekać trwa ładowanie danych');
          }

          final documents = snapshot.data!.docs;

          return ListView(
            children: [
              for (final document in documents) ...[
                Dismissible(
                  key: ValueKey(document.id),
                  onDismissed: (_) {FirebaseFirestore.instance.collection('goal').doc(document.id).delete();},
                  child: AimCategory(
                    document['title'],
                  ),
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}

class AimCategory extends StatelessWidget {
  const AimCategory(
    this.title, {
    Key? key,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          title,
        ),
      ),
      color: Colors.amber,
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.all(10),
    );
  }
}
