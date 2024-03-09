import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:twothreehours_dev/Mytime_dir/my_time_main_page.dart';
import 'package:twothreehours_dev/home_dir/home_main_page.dart';
import 'package:twothreehours_dev/reserv_dir/reserv_main_page.dart';
import 'package:twothreehours_dev/shelter_dir/shelter_main_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '2-3HOURS',
      theme: ThemeData(
        primaryColor: const Color(0xff0465f2),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff0465f2)),
        fontFamily: 'Pretendard',
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 1;
  final List _pages = [
    const ShelterPage(),
    const HomePage(),
    const ReservPage(),
    const MytimePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Padding(
        padding:
            const EdgeInsets.only(left: 15, right: 15, bottom: 24, top: 8),
        child: GNav(
          // backgroundColor: Colors.black,
          selectedIndex: _selectedIndex,
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
