import 'package:flutter/material.dart';

class AimPage extends StatelessWidget {
  const AimPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Ustaw cel'),
        ),
      ),
    );
  }
}
