import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moja_apka/features/aims/pages/cubit/aims_cubit.dart';
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
      body: BlocProvider(
        create: (context) => AimsCubit()..start(),
        child: BlocBuilder<AimsCubit, AimsState>(
          builder: (context, state) {
            state.documents;
            return StreamBuilder<QuerySnapshot>(
              builder: (context, snapshot) {
                if (state.errorMessage.isNotEmpty) {
                  return Center(
                      child: Text('Wystąpił błąd : ${state.errorMessage}'));
                }

                if (state.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                final documents = state.documents;

                return ListView(
                  children: [
                    for (final document in documents) ...[
                      Dismissible(
                        key: ValueKey(document.id),
                        onDismissed: (_) {
                          FirebaseFirestore.instance
                              .collection('goal')
                              .doc(document.id)
                              .delete();
                        },
                        child: AimCategory(
                          document['title'],
                        ),
                      ),
                    ],
                  ],
                );
              },
            );
          },
        ),
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
