import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moja_apka/features/add_distance/pages/cubit/add_distance_cubit.dart';
import 'package:moja_apka/features/add_distance/pages/cubit/add_distance_state.dart';
import 'package:moja_apka/repositories/goal_repository.dart';

class AddDistance extends StatefulWidget {
  const AddDistance({
    Key? key,
  }) : super(key: key);

  @override
  State<AddDistance> createState() => _AddDistanceState();
}

class _AddDistanceState extends State<AddDistance> {
  String? distance;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddDistanceCubit(GoalRepository()),
      child: BlocListener<AddDistanceCubit, AddDistanceState>(
        listener: (context, state) {
          if (state.saved) {
            Navigator.of(context).pop();
          }
          if (state.errorMessage.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Row(
                  children: [
                    const Icon(
                      Icons.info_outline,
                      color: Colors.white,
                    ),
                    Expanded(
                      child:
                          Text(state.errorMessage, textAlign: TextAlign.center),
                    ),
                  ],
                ),
                backgroundColor: Colors.red,
                duration: const Duration(seconds: 3),
              ),
            );
          }
        },
        child: BlocBuilder<AddDistanceCubit, AddDistanceState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: const Center(
                  child: Text('Dodaj odległość'),
                ),
                actions: [
                  IconButton(
                    onPressed: distance == null
                        ? null
                        : () {
                            context.read<AddDistanceCubit>().add(
                                  distance!,
                                );
                          },
                    icon: const Icon(Icons.check),
                  )
                ],
              ),
              body: _AddDistancePageBody(
                onDistanceChanged: (newValue) {
                  setState(
                    () {
                      distance == null ? const Text('0') : newValue;
                    },
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class _AddDistancePageBody extends StatelessWidget {
  const _AddDistancePageBody({Key? key, required this.onDistanceChanged})
      : super(key: key);
  final Function(String) onDistanceChanged;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(30),
      children: [
        TextField(
          decoration: const InputDecoration(
            labelText: 'Dodaj pokonaną odległość',
            hintText: ' 5 km',
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.green, width: 2),
            ),
          ),
          onChanged: onDistanceChanged,
        ),
      ],
    );
  }
}
