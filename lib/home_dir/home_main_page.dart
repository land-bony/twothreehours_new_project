import 'package:flutter/material.dart';
import 'package:twothreehours_dev/reserv_dir/reserv_detail_page.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  // notice animation Declaration of Variables
  late AnimationController _noticeAnimationController;
  late Animation<double> _noticeAnimation;
  bool _noticeIndex = false;

  // 두세시간 기획전 Variables
  final PageController _exhibitionsPageController =
      PageController(viewportFraction: 0.9);

  // Photo by 두세시간 Variables
  final PageController _photoPageController =
      PageController(viewportFraction: 0.8);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // notice animation and controller define
    _noticeAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _noticeAnimation = Tween<double>(begin: 0.0, end: 0.125)
        .animate(_noticeAnimationController);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // 상단 메인 배너
          SliverAppBar(
            backgroundColor: Colors.white,
            centerTitle: false,
            title: SizedBox(
              width: 112,
              child: Image.asset('assets/images/2-3hours_logo.png'),
            ),
            pinned: true,
            stretch: true,
            expandedHeight: 328,
            actions: [
              IconButton(
                  onPressed: () {}, icon: const Icon(Icons.notifications))
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    'assets/images/test_photo.jpg',
                    fit: BoxFit.cover,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0),
                          Colors.black.withOpacity(0.75)
                        ],
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          '테스트 데이터',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              collapseMode: CollapseMode.pin,
            ),
          ),
          // 공지사항
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0, left: 16, right: 16),
              child: AnimatedContainer(
                height: _noticeIndex ? 130 : 48,
                decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(8)),
                duration: const Duration(milliseconds: 300),
                curve: Curves.fastOutSlowIn,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 12.0),
                        child: Icon(
                          Icons.campaign,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Flexible(
                        fit: FlexFit.tight,
                        child: Padding(
                          padding:
                              const EdgeInsets.only(top: 14.0, bottom: 14.0),
                          child: Text(
                              '3월 봉사 일정은 2월 25일 오픈 예정입니다.\n1. 테스트\n2. 테스트\n3. 테스트\n4. 테스트',
                              maxLines: _noticeIndex ? 5 : 1,
                              overflow: TextOverflow.ellipsis),
                        ),
                      ),
                      RotationTransition(
                        turns: _noticeAnimation,
                        child: IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: _toggleAnimation,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          //두세시간 기획전
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 16.0, left: 16),
                  child: Text(
                    '두세시간 기획전',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: SizedBox(
                    height: 184,
                    child: Stack(
                      children: [
                        PageView.builder(
                          controller: _exhibitionsPageController,
                          itemCount: 10,
                          itemBuilder: (_, index) => Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Stack(
                                children: [
                                  SizedBox.expand(
                                    child: Image.asset(
                                      'assets/images/test_photo.jpg',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Colors.black.withOpacity(0),
                                          const Color(0xff0AF0E8)
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          //두세시간 카테고리
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 32.0, left: 16),
                  child: Text(
                    '두세시간 카테고리',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: SizedBox(
                    height: 144,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(32.0),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                SizedBox(
                                  width: 144,
                                  child: Image.asset(
                                    'assets/images/test_photo.jpg',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Container(
                                  width: 144,
                                  color: Colors.black.withOpacity(0.6),
                                ),
                                const SizedBox(
                                  width: 112,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '두세시간 정규',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 4.0),
                                        child: Text(
                                          '봉사리더와 함께하는 두세시간',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(32.0),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                SizedBox(
                                  width: 144,
                                  child: Image.asset(
                                    'assets/images/test_photo.jpg',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Container(
                                  width: 144,
                                  color: Colors.black.withOpacity(0.6),
                                ),
                                const SizedBox(
                                  width: 112,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '두세시간 Light',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 4.0),
                                        child: Text(
                                          '나홀로 진행하는\n 두세시간',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(32.0),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                SizedBox(
                                  width: 144,
                                  child: Image.asset(
                                    'assets/images/test_photo.jpg',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Container(
                                  width: 144,
                                  color: Colors.black.withOpacity(0.6),
                                ),
                                const SizedBox(
                                  width: 112,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '두세시간 스페셜',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 4.0),
                                        child: Text(
                                          '두세시간이 진행하는\n특별기획전',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          //최신 업데이트 일정
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 32, left: 16.0),
                  child: Text(
                    '최신 업데이트 일정',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      primary: false,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return ReservPageDetail();
                                },
                              ),
                            );
                          },
                          child: Padding(
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
                          ),
                        );
                      },
                      itemCount: 5,
                    ),
                  ),
                ),
              ],
            ),
          ),
          //광고 및 기타 관련 문의
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 48.0),
              child: Column(
                children: [
                  const Text(
                    '광고 및 기타 관련 문의',
                    style: TextStyle(color: Colors.black54),
                  ),
                  FittedBox(
                    child: MaterialButton(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 16,
                            child: Image.asset(
                              'assets/images/instagram.png',
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 4.0),
                            child: Text(
                              '@twothreehours',
                              style: TextStyle(
                                color: Colors.black54,
                              ),
                            ),
                          ),
                        ],
                      ),
                      onPressed: () async {
                        final url = Uri.parse(
                            'https://www.instagram.com/twothreehours/?utm_medium=copy_link');
                        if (await canLaunchUrl(url)) {
                          launchUrl(url);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('일시적인 오류입니다.')));
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // notice animation function
  void _toggleAnimation() {
    if (_noticeAnimationController.isDismissed) {
      _noticeAnimationController.forward();
      setState(() {
        _noticeIndex = true;
      });
    } else {
      _noticeAnimationController.reverse();
      setState(() {
        _noticeIndex = false;
      });
    }
  }
}
