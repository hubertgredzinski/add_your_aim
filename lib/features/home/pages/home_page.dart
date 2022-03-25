import 'package:flutter/material.dart';
import 'package:moja_apka/features/add_aim/pages/add_aim_page.dart';
import 'package:moja_apka/features/aims/pages/aims_page.dart';
import 'package:moja_apka/features/history/pages/history_pages.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currrentIndex = 0;
  final screens = [
    const AimsPage(),
     AddAimPage(),
    const HistoryPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currrentIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        iconSize: 30,
        currentIndex: currrentIndex,
        onTap: (index) => setState(() => currrentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.toc), label: 'Cele'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Dodaj cel'),
          BottomNavigationBarItem(
              icon: Icon(Icons.assignment), label: 'Historia'),
        ],
      ),
    );
  }
}
