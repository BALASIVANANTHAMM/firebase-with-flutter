import 'package:flutter/material.dart';
import 'package:signing/sports.dart';
import 'Home.dart';

class Bottom extends StatefulWidget {
  const Bottom({super.key});

  @override
  State<Bottom> createState() => _BottomState();
}

class _BottomState extends State<Bottom> {
  int _index = 0;
  final screens = [Home(), Sports()];

  void tap(index) {
    setState(() {
      _index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: IndexedStack(index: _index, children: screens),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.pink,
        backgroundColor: Colors.transparent,
        currentIndex: _index,
        onTap: tap,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: Colors.white,
              ),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.sports,
                color: Colors.white,
              ),
              label: 'Sports'),
          // BottomNavigationBarItem(
          //     icon: Icon(
          //       Icons.movie,
          //       color: Colors.blue,
          //     ),
          //     label: 'Movies'),
          // BottomNavigationBarItem(
          //     icon: Icon(
          //       Icons.local_movies,
          //       color: Colors.blue,
          //     ),
          //     label: 'Series'),
        ],
      ),
    );
  }
}
