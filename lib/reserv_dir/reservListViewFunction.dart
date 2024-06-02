import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:twothreehours_dev/reserv_dir/reserv_detail_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

Widget reservListView(
    List<QueryDocumentSnapshot<Map<String, dynamic>>> reservItem,
    int listCount) {
  if (listCount > reservItem.length) {
    listCount = reservItem.length;
  }

  return ListView.builder(
    padding: EdgeInsets.zero,
    shrinkWrap: true,
    primary: false,
    itemCount: listCount,
    itemBuilder: (context, index) {
      // Firebase ReservItems 필드 검증 변수 정의
      List<String> reservItemRequiredFields = [
        'carpoolInfo',
        'carpoolStatus',
        'mainImage',
        'reservDate',
        'reservItemStatus',
        'reservUsers'
      ];

      if (reservItemRequiredFields.every(
              (field) => reservItem[index].data().containsKey(field))){
        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return ReservDetailPage(reservItem: reservItem[index]);
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
                      child: Image.network(
                        reservItem[index]['mainImage'],
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
                          // 예약 일정 상태 함수 정의
                          reservItemStatus(context, reservItem[index]),
                          // 예약 일정 카풀 상태 함수 정의
                          const SizedBox(width: 4),
                          reservItem[index]['carpoolStatus'] == 'Y'
                              ? Container(
                            width: 64,
                            height: 28,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: const Color(0xff0AF0E8)),
                            child: const Text(
                              '카풀 제공',
                              style: TextStyle(fontSize: 12),
                            ),
                          )
                              : Container(
                            width: 72,
                            height: 28,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.black),
                            child: const Text(
                              '카풀 미제공',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.event, size: 16),
                          const SizedBox(width: 8),
                          itemDateFuntion(reservItem[index]['reservDate'])
                        ],
                      ),
                      const SizedBox(height: 4),
                      reservItem[index]['carpoolStatus'] == 'Y'
                          ? Row(
                        children: <Widget>[
                          const Icon(Icons.departure_board, size: 16),
                          const SizedBox(width: 8),
                          Text(reservItem[index]['carpoolInfo']
                          ['carpoolLocation']),
                          const SizedBox(width: 2),
                          const Text(
                            '•',
                          ),
                          const SizedBox(width: 2),
                          Text(
                              '${reservItem[index]['carpoolInfo']['carpoolTime']} 출발'),
                        ],
                      )
                          : const Row(
                        children: <Widget>[
                          Icon(Icons.departure_board, size: 16),
                          SizedBox(width: 8),
                          Text('-'),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.groups, size: 16),
                          const SizedBox(width: 8),
                          reservItem[index]['carpoolStatus'] == 'Y'
                              ? itemCarpoolUserCountFuntion(
                              reservItem[index]['reservUsers']
                              ['carpoolUsers'],
                              reservItem[index]['carpoolInfo']['maxCarpool'])
                              : const SizedBox.shrink(),
                          itemNonCarpoolUserCountFuntion(
                              reservItem[index]['reservUsers']['nonCarpoolUsers'],
                              reservItem[index]['carpoolInfo']['maxNonCarpool']),
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
      }
      return const SizedBox.shrink();
    },
  );
}

// 모집 상태 함수 정의
Widget reservItemStatus(
    context, QueryDocumentSnapshot<Map<String, dynamic>> reservItem) {
  List<dynamic> carpoolUsers = reservItem['reservUsers']['carpoolUsers'];
  List<dynamic> nonCarpoolUsers = reservItem['reservUsers']['nonCarpoolUsers'];

  if (reservItem['reservItemStatus'] == 'active' &&
      (carpoolUsers.length < reservItem['carpoolInfo']['maxCarpool'] ||
          nonCarpoolUsers.length <
              reservItem['carpoolInfo']['maxNonCarpool'])) {
    return Container(
      width: 64,
      height: 28,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Theme.of(context).primaryColor),
      child: const Text(
        '모집중',
        style: TextStyle(
            color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
      ),
    );
  } else if (carpoolUsers.length >= reservItem['carpoolInfo']['maxCarpool'] &&
      nonCarpoolUsers.length >= reservItem['carpoolInfo']['maxNonCarpool']) {
    return Container(
      width: 64,
      height: 28,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), color: Colors.grey),
      child: const Text(
        '모집 마감',
        style: TextStyle(
            color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
      ),
    );
  } else {
    return Container(
      width: 64,
      height: 28,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), color: const Color(0xffF2A305)),
      child: const Text(
        '모집 대기',
        style: TextStyle(
            color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
      ),
    );
  }
}

//카풀 모집시간 함수 정의
Widget itemDateFuntion(String scheduleDate) {
  String date =
      DateFormat('MM월 dd일').format(DateTime.parse(scheduleDate)).toString();
  String week =
      DateFormat('E', 'ko').format(DateTime.parse(scheduleDate)).toString();

  return Text('$date($week)');
}

//카풀 인원 호출 함수 정의
Widget itemCarpoolUserCountFuntion(
    List<dynamic> carpoolUser, int maxCarpoolNum) {
  int carpoolUserCount = carpoolUser.length;

  return Text('카풀 $carpoolUserCount/$maxCarpoolNum • ');
}

//비카풀 인원 호출 함수 정의
Widget itemNonCarpoolUserCountFuntion(
    List<dynamic> nonCarpoolUser, int maxNonCarpoolNum) {
  int carpoolUserCount = nonCarpoolUser.length;

  return Text('비카풀 $carpoolUserCount/$maxNonCarpoolNum');
}
