import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moja_apka/features/add/pages/add_page.dart';
import 'package:moja_apka/features/auth/pages/user_profile.dart';
import 'package:moja_apka/features/home/cubit/home_cubit.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              fullscreenDialog: true,
              builder: (context) => const AddPage(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: BlocProvider(
        create: (context) => HomeCubit()..start(),
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            final docs = state.goalslist;
            if (docs.isEmpty) {
              return const SizedBox.shrink();
            }
            return ListView(
              padding: const EdgeInsets.symmetric(vertical: 10),
              children: [
                for (final doc in docs) ...[
                  Dismissible(
                    key: ValueKey(doc.id),
                    background: const DecoratedBox(
                      decoration: BoxDecoration(color: Colors.red),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: EdgeInsets.only(right: 32.0),
                          child: Icon(Icons.delete),
                        ),
                      ),
                    ),
                    confirmDismiss: (direction) async {
                      return direction == DismissDirection.endToStart;
                    },
                    onDismissed: (direction) {
                      context.read<HomeCubit>().remove(documentID: doc.id);
                    },
                    child: AimCategory(
                      document: doc,
                    ),
                  ),
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}

class AimCategory extends StatelessWidget {
  const AimCategory({
    required this.document,
    Key? key,
  }) : super(key: key);

  final QueryDocumentSnapshot<Map<String, dynamic>> document;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
      child: Container(
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 35, 252, 2),
        ),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(5),
              padding: const EdgeInsets.all(5),
              child: Text(
                document['title'],
                style:
                    GoogleFonts.lato(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              height: 100,
              decoration: BoxDecoration(
                color: Colors.black12,
                image: DecorationImage(
                  image: NetworkImage(
                    document['image_url'],
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 143, 255, 152),
                  ),
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Text(
                        'Cel',
                        style: GoogleFonts.lato(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        '0 / 20 km',
                        style: GoogleFonts.lato(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 143, 255, 152),
                  ),
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Text(
                        '0',
                        style: GoogleFonts.lato(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Dni do końca',
                        style: GoogleFonts.lato(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(2),
              child: Text(
                (document['release_date'] as Timestamp).toDate().toString(),
                style: GoogleFonts.lato(
                  fontSize: 15,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
