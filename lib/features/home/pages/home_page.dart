import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moja_apka/features/aims/pages/aims_page.dart';
import 'package:moja_apka/features/auth/pages/user_profile.dart';
import 'package:moja_apka/features/home/cubit/home_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
              builder: (context) => const AimsPage(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: BlocProvider(
        create: (context) => HomeCubit()..start(),
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            state.documents;
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
                    background: const DecoratedBox(
                      decoration: BoxDecoration(color: Colors.red),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Icon(Icons.delete),
                        ),
                      ),
                    ),
                    onDismissed: (direction) {
                      context.read<HomeCubit>().remove(documentID: document.id);
                    },
                    child: AimCategory(
                      document['title'],
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
