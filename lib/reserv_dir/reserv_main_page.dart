import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twothreehours_dev/reserv_dir/reservListViewFunction.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReservMainPage extends StatefulWidget {
  const ReservMainPage({super.key});

  @override
  State<ReservMainPage> createState() => _ReservMainPageState();
}

class _ReservMainPageState extends State<ReservMainPage> {
  // Firebase CloudStorage Instance 선언
  final Stream<QuerySnapshot<Map<String, dynamic>>> reservItems =
  FirebaseFirestore.instance.collection('ReservItems').snapshots();

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
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: reservItems,
          builder: (context, snapshot) {
            if(!snapshot.hasData){
              return const CupertinoActivityIndicator();
            }

            var reservItem = snapshot.data!.docs;

            return SizedBox(
              child: reservListView(reservItem, reservItem.length),
            );
          }
        ),
      ),
    );
  }

}
