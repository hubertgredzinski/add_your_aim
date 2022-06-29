import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moja_apka/features/add/pages/add_page.dart';
import 'package:moja_apka/features/auth/pages/user_profile.dart';
import 'package:moja_apka/features/home/cubit/home_cubit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moja_apka/features/weather/pages/weather_page.dart';
import 'package:moja_apka/model/goal_model.dart';
import 'package:moja_apka/repositories/goal_repository.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        title: Builder(builder: (context) {
          if (currentIndex == 1) {
            return const Center(
              child: Text('Pogoda'),
            );
          }
          return const Center(
            child: Text('Cele'),
          );
        }),
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
      floatingActionButton: Builder(builder: (context) {
        if (currentIndex == 1) {
          return const SizedBox.shrink();
        }
        return FloatingActionButton(
          backgroundColor: const Color.fromARGB(221, 50, 50, 50),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                fullscreenDialog: true,
                builder: (context) => const AddPage(),
              ),
            );
          },
          child: const Icon(Icons.add),
        );
      }),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white54,
        iconSize: 25,
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Cele',
              backgroundColor: Colors.green),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Pogoda',
              backgroundColor: Colors.green)
        ],
      ),
      body: Builder(builder: (context) {
        if (currentIndex == 1) {
          return const WeatherPage();
        }
        return BlocProvider(
          create: (context) => HomeCubit(GoalRepository())..start(),
          child: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              final goalsModel = state.goalslist;
              return ListView(
                padding: const EdgeInsets.symmetric(vertical: 10),
                children: [
                  for (final goalModel in goalsModel)
                    Dismissible(
                      key: ValueKey(goalModel.id),
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
                        context
                            .read<HomeCubit>()
                            .remove(documentID: goalModel.id);
                      },
                      child: AimCategory(
                        goalModel: goalModel,
                      ),
                    ),
                ],
              );
            },
          ),
        );
      }),
    );
  }
}

class AimCategory extends StatelessWidget {
  const AimCategory({
    Key? key,
    required this.goalModel,
  }) : super(key: key);

  final GoalModel goalModel;

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
                goalModel.title,
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
                    goalModel.imageURL,
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
                      Row(
                        children: [
                          Text(
                            goalModel.goal,
                            style: GoogleFonts.lato(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            goalModel.unit,
                            style: GoogleFonts.lato(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ],
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
                        goalModel.daysLeft(),
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
                goalModel.endDateFormatted(),
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
