import 'package:flutter/material.dart';
import 'package:twothreehours_dev/main_route_page.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
          fontFamily: 'Pretendard',
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff0465f2))
              .copyWith(background: Colors.white),),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context)
              .copyWith(textScaler: const TextScaler.linear(1)),
          child: child!,
        );
      },
      home: const MainRoutePage(selectPageIndex: 1),
    );
  }
}
