import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moja_apka/features/aims/pages/cubit/aims_cubit.dart';
import 'package:moja_apka/features/aims/pages/cubit/aims_state.dart';

class AimsPage extends StatefulWidget {
  const AimsPage({
    Key? key,
  }) : super(key: key);

  @override
  State<AimsPage> createState() => _AimsPageState();
}

class _AimsPageState extends State<AimsPage> {
  String? _title;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AimsCubit(),
      child: BlocBuilder<AimsCubit, AimsState>(
        builder: (context, state) {
          if (state.errorMessage.isNotEmpty) {
            return Center(
              child: Text('Wystąpił błąd : ${state.errorMessage}'),
            );
          }

          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return Scaffold(
            appBar: AppBar(
              title: const Center(child: Text('Dodaj cel')),
              actions: [
                IconButton(
                    onPressed: _title == null
                        ? null
                        : () {
                            context.read<AimsCubit>().add(_title!);
                          },
                    icon: const Icon(Icons.check))
              ],
            ),
            body: _AimsPageBody(
              onTitleChanged: (newValue) {
                setState(() {
                  _title = newValue;
                });
              },
            ),
          );
        },
      ),
    );
  }
}

class _AimsPageBody extends StatelessWidget {
  const _AimsPageBody({
    Key? key,
    required this.onTitleChanged,
  }) : super(key: key);

  final Function(String) onTitleChanged;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(30),
      children: [
        TextField(
          decoration: const InputDecoration(
            labelText: 'Aktywność',
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.green, width: 2),
            ),
          ),
          onChanged: onTitleChanged,
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
