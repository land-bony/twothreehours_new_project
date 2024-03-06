import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class ReservPageDetail extends StatelessWidget {
  const ReservPageDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          '신청하기',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // 메인 사진
            SizedBox(
              width: double.infinity,
              height: 240,
              child: Image.asset(
                'assets/images/test_photo.jpg',
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 8),
            // 일정 안내
            SizedBox(
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(
                  '일정안내',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Text(
                          '봉사일정',
                          style: TextStyle(fontSize: 16, color: Colors.black54),
                        ),
                        SizedBox(width: 16),
                        Text(
                          '2월 23일',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(width: 4),
                        Text(
                          '•',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(width: 4),
                        Text(
                          '오전 11시 시작',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    const Row(
                      children: [
                        Text(
                          '봉사장소',
                          style: TextStyle(fontSize: 16, color: Colors.black54),
                        ),
                        SizedBox(width: 16),
                        Text(
                          '안성보호소(안성 중앙대학교 부근)',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    Row(
                      children: [
                        const Text(
                          '카풀장소',
                          style: TextStyle(fontSize: 16, color: Colors.black54),
                        ),
                        SizedBox(width: 16),
                        const Text(
                          '판교공영주차장',
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: () async {
                            final url = Uri.parse('https://naver.me/5aVtsW6K');
                            if (await canLaunchUrl(url)) {
                              launchUrl(url);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('일시적인 오류입니다.')));
                            }
                          },
                          child: const Icon(
                            Icons.location_on,
                            size: 16,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 8.0),
                    Row(
                      children: [
                        Text(
                          '카풀시간',
                          style: TextStyle(fontSize: 16, color: Colors.black54),
                        ),
                        SizedBox(width: 16),
                        Text(
                          '오전 9시 50분 출발 (1시간 소요)',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.0),
                    Row(
                      children: [
                        Text(
                          '모집인원',
                          style: TextStyle(fontSize: 16, color: Colors.black54),
                        ),
                        SizedBox(width: 16),
                        Text(
                          '카풀(1/3)',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(width: 4),
                        Text(
                          '•',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(width: 4),
                        Text(
                          '비카풀(1/6)',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.0),
                    Row(
                      children: [
                        Text(
                          '제공물품',
                          style: TextStyle(fontSize: 16, color: Colors.black54),
                        ),
                        SizedBox(width: 16),
                        Text(
                          '방진복 / 장화 / 장갑',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            // 금액 안내
            SizedBox(
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(
                  '금액안내',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor),
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 168,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all()),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  'assets/images/test_photo.jpg',
                                  fit: BoxFit.cover,
                                  opacity: const AlwaysStoppedAnimation(.2),
                                ),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const SizedBox(height: 16),
                                Text(
                                  '카풀로 함께해요!',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  '카풀리더가 지정한 장소에서\n다 같이 만나 출발해요!',
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '15,900 ',
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                    Text(
                                      '원',
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 168,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all()),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  'assets/images/test_photo.jpg',
                                  fit: BoxFit.cover,
                                  opacity: const AlwaysStoppedAnimation(.2),
                                ),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const SizedBox(height: 16),
                                Text(
                                  '비카풀로 함께해요!',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  '따로 이동해서\n보호소에서 만나요!',
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '8,900 ',
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                    Text(
                                      '원',
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '금액 사용처',
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                  SizedBox(height: 8),
                  Text('* 봉사자 대상 봉사 물품 제공'),
                  Text('* 카풀 차량 유류비 지원'),
                  Text('* 보호소 후원'),
                  Text('* 일부 서비스 운영 비용'),
                ],
              ),
            ),
            // 보호소 정보
            const SizedBox(height: 32),
            SizedBox(
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(
                  '보호소 정보',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor),
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 100,
                      height: 100,
                      child: CircleAvatar(
                        radius: 8.0,
                        backgroundImage:
                            AssetImage('assets/images/test_photo.jpg'),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                '안성보호소',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(width: 8),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 16,
                              )
                            ],
                          ),
                          Text(
                            '300마리 강아지의 행복한 보금자리',
                            style: TextStyle(color: Colors.black54),
                          ),
                          Text(
                            '김계영 소장님',
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor: Colors.black,
                                    surfaceTintColor: Colors.transparent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: Text('웹페이지'),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor: Colors.black,
                                    surfaceTintColor: Colors.transparent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: Text('봉사방법'),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // 리더 정보
            const SizedBox(height: 32),
            SizedBox(
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(
                  '리더 정보',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor),
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 72,
                      height: 72,
                      child: CircleAvatar(
                        radius: 8.0,
                        backgroundImage:
                            AssetImage('assets/images/test_photo.jpg'),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                '이다은 리더님',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(width: 8),
                            ],
                          ),
                          Text(
                            '한줄평 입니다.',
                            style: TextStyle(color: Colors.black54),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(
                  '주의사항',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor),
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  width: double.infinity,
                  constraints: const BoxConstraints(
                    minHeight: 160,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.only(
                        top: 8.0, left: 16.0, right: 16.0, bottom: 8),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('1. '),
                            SizedBox(width: 4),
                            Flexible(
                                child: Text('사람들을 싫어하는 강아지들이 있으니 섣불리 접근하지 마세요.', maxLines: 2,))
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('2. '),
                            SizedBox(width: 4),
                            Flexible(
                                child: Text('사람들을 싫어하는 강아지들이 있으니 섣불리 접근하지 마세요.', maxLines: 2,))
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('3. '),
                            SizedBox(width: 4),
                            Flexible(
                                child: Text('사람들을 싫어하는 강아지들이 있으니 섣불리 접근하지 마세요.', maxLines: 2,))
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                width: double.infinity,
                height: 1,
                color: Colors.black12,
              ),
            ),
            const SizedBox(height: 120),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SizedBox(
          width: double.infinity,
          child: FloatingActionButton(
            onPressed: () {
              showModalBottomSheet(context: context, builder: buildBottomSheet);
            },
            backgroundColor: Theme.of(context).primaryColor,
            child: const Text(
              '신청하기',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  // Floating btn Bottom Sheet
  Widget buildBottomSheet(BuildContext context) {
    return Column(
      children: [
        Container(

        ),
      ],
    );
  }
}
