import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twothreehours_dev/reserv_dir/reservListViewFunction.dart';
import 'package:twothreehours_dev/reserv_dir/reserv_detail_page.dart';

class ReservMainPage extends StatefulWidget {
  const ReservMainPage({super.key});

  @override
  State<ReservMainPage> createState() => _ReservMainPageState();
}

class _ReservMainPageState extends State<ReservMainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: false,
        title: SizedBox(
          width: 112,
          child: Image.asset('assets/images/2-3hours_logo.png'),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.tune),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SizedBox(
          child: reservListView(10),
        ),
      ),
    );
  }

}
