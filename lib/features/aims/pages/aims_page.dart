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
  String? _aim;
  String? _imageURL;
  DateTime? _releaseDate;

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
              title: const Center(
                child: Text('Dodaj cel'),
              ),
              actions: [
                IconButton(
                    onPressed: _title == null ||
                            _aim == null ||
                            _imageURL == null ||
                            _releaseDate == null
                        ? null
                        : () {
                            context
                                .read<AimsCubit>()
                                .add(_title!, _aim!, _imageURL!, _releaseDate!);
                          },
                    icon: const Icon(Icons.check))
              ],
            ),
            body: _AimsPageBody(
                onTitleChanged: (newValue) {
                  setState(
                    () {
                      _title = newValue;
                    },
                  );
                },
                onAimChanged: (newValue) {
                  setState(
                    () {
                      _aim = newValue;
                    },
                  );
                },
                onImageUrlChanged: (newValue) {
                  setState(
                    () {
                      _imageURL = newValue;
                    },
                  );
                },
                onDateChanged: (newValue) {
                  setState(
                    () {
                      _releaseDate = newValue;
                    },
                  );
                },
                selectedDateFormatted: _releaseDate?.toIso8601String()),
          );
        },
      ),
    );
  }
}

class _AimsPageBody extends StatelessWidget {
  const _AimsPageBody(
      {Key? key,
      required this.onTitleChanged,
      required this.onAimChanged,
      required this.onImageUrlChanged,
      required this.onDateChanged,
      this.selectedDateFormatted})
      : super(key: key);

  final Function(String) onTitleChanged;
  final Function(String) onAimChanged;
  final Function(String) onImageUrlChanged;
  final Function(DateTime?) onDateChanged;
  final String? selectedDateFormatted;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(30),
      children: [
        TextField(
          decoration: const InputDecoration(
            labelText: 'Aktywność',
            hintText: 'Jazda na rowerze',
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
        TextField(
          decoration: const InputDecoration(
            labelText: 'Cel',
            hintText: 'km',
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.green, width: 2),
            ),
          ),
          onChanged: onAimChanged,
        ),
        const SizedBox(height: 20),
        TextField(
          decoration: const InputDecoration(
            labelText: 'Adres linku zdjęcia',
            hintText: 'https://...',
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.green, width: 2),
            ),
          ),
          onChanged: onImageUrlChanged,
        ),
        const SizedBox(height: 30),
        ElevatedButton(
          onPressed: () async {
            final selectedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(
                const Duration(days: 365 * 100),
              ),
            );
            onDateChanged(selectedDate);
          },
          child: Text(selectedDateFormatted ?? 'Wybierz datę wykonania celu'),
        )
      ],
    );
  }
}
