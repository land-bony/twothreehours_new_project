import 'package:flutter/material.dart';
import 'package:twothreehours_dev/reserv_dir/reserv_detail_page.dart';

Widget reservListView(int listCount) {
  return ListView.builder(
    padding: EdgeInsets.zero,
    shrinkWrap: true,
    primary: false,
    itemCount: listCount,
    itemBuilder: (context, index) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const ReservPageDetail();
                },
              ),
            );
          },
          child: Container(
            width: double.infinity,
            color: Colors.white,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 104,
                  height: 104,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      'assets/images/test_photo.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 72,
                          height: 28,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Theme.of(context).primaryColor),
                          child: const Text(
                            '모집중',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(width: 4),
                        Container(
                          width: 72,
                          height: 28,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.black),
                          child: const Text(
                            '카풀 미제공',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.event, size: 16),
                        SizedBox(width: 8),
                        Text(
                          '3월 16일(토)',
                          style: TextStyle(fontSize: 14),
                        )
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.departure_board, size: 16),
                        SizedBox(width: 8),
                        Text('삼평동'),
                        SizedBox(width: 2),
                        Text(
                          '•',
                        ),
                        SizedBox(width: 2),
                        Text(
                          '10시 50분 출발',
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.groups, size: 16),
                        SizedBox(width: 8),
                        Text('카풀 1/3'),
                        SizedBox(width: 2),
                        Text(
                          '•',
                        ),
                        SizedBox(width: 2),
                        Text(
                          '비카풀 1/2',
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
