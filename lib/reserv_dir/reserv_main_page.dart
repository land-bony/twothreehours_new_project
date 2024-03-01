import 'package:flutter/material.dart';

class ReservPage extends StatefulWidget {
  const ReservPage({super.key});

  @override
  State<ReservPage> createState() => _ReservPageState();
}

class _ReservPageState extends State<ReservPage> {
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
              onPressed: () {}, icon: const Icon(Icons.tune),),
          IconButton(
            onPressed: () {}, icon: const Icon(Icons.search),),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SizedBox(
          child: ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            primary: false,
            itemCount: 10,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(16)),
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 72,
                              height: 32,
                              decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.circular(8),
                                  color: Colors.grey),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              width: 72,
                              height: 32,
                              decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.circular(8),
                                  color: Colors.grey),
                            )
                          ],
                        ),
                        const SizedBox(height: 8),
                        Container(
                          width: 196,
                          height: 32,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          width: 196,
                          height: 32,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
