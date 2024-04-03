import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:twothreehours_dev/reserv_dir/reserv_main_page.dart';
import 'package:twothreehours_dev/shelter_dir/shelter_main_page.dart';

import 'Mytime_dir/my_time_main_page.dart';
import 'home_dir/home_main_page.dart';

class MainRoutePage extends StatefulWidget {
  final int selectPageIndex;

  const MainRoutePage({Key? key, required this.selectPageIndex}) : super(key: key);

  @override
  State<MainRoutePage> createState() => _MainRoutePageState();
}

class _MainRoutePageState extends State<MainRoutePage> {

  int? _selectedIndex;
  final List _pages = [
    const ShelterPage(),
    const HomePage(),
    const ReservMainPage(),
    const MytimePage()
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedIndex = widget.selectPageIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex!],
      bottomNavigationBar: Padding(
        padding:
        const EdgeInsets.only(left: 15, right: 15, bottom: 24, top: 8),
        child: GNav(
          // backgroundColor: Colors.black,
          selectedIndex: _selectedIndex!,
          color: Colors.grey,
          activeColor: Colors.white,
          tabBackgroundGradient:
          const LinearGradient(colors: [Color(0xff0465f2), Color(0xff0AF0E8)]),
          gap: 8,
          padding: const EdgeInsets.all(16),
          onTabChange: _onItemsTapped,
          tabs: const [
            GButton(icon: Icons.pets, text: 'Shelter'),
            GButton(icon: Icons.home, text: 'Home'),
            GButton(icon: Icons.event_available, text: 'Schedule'),
            GButton(icon: Icons.person, text: 'My time'),
          ],
        ),
      ),
    );
  }

  void _onItemsTapped(int value) {
    setState(() {
      _selectedIndex = value;
    });
  }
}