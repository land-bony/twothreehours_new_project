import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twothreehours_dev/main_route_page.dart';
import 'package:twothreehours_dev/reserv_dir/reservListViewFunction.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  // Main Images CarouselSlider Declaration of Variables;
  int mainImageActiveIndex = 0;
  CarouselController mainImageCarouselController = CarouselController();

  // notice animation Declaration of Variables
  late AnimationController _noticeAnimationController;
  late Animation<double> _noticeAnimation;
  bool _noticeIndex = false;

  // 두세시간 기획전 Variables
  final PageController _exhibitionsController =
      PageController(viewportFraction: 0.9);

  // Firebase CloudStorage Instance 선언
  final Stream<DocumentSnapshot<Map<String, dynamic>>> homeMainImages =
      FirebaseFirestore.instance
          .collection('HomeMainPage')
          .doc('homeMainImages')
          .snapshots();
  final Stream<DocumentSnapshot<Map<String, dynamic>>> homeNotice =
  FirebaseFirestore.instance
      .collection('HomeMainPage')
      .doc('homeNotice')
      .snapshots();
  final Stream<DocumentSnapshot<Map<String, dynamic>>> homeExhibitions =
      FirebaseFirestore.instance
          .collection('HomeMainPage')
          .doc('homeExhibitions')
          .snapshots();
  final Stream<QuerySnapshot<Map<String, dynamic>>> homeCategory =
  FirebaseFirestore.instance
      .collection('HomeMainPage')
      .doc('homeCategory').collection('Category').snapshots();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // 공지 애니메이션 및 컨트롤러 선언
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
          // 상단 메인 이미지
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
              background: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                stream: homeMainImages,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CupertinoActivityIndicator());
                  }

                  var mainImages = snapshot.data;

                  return Stack(
                    fit: StackFit.expand,
                    children: [
                      Container(
                        color: const Color(0xffececec),
                      ),
                      CarouselSlider.builder(
                        carouselController: mainImageCarouselController,
                        itemCount: mainImages!['imageUrl'].length,
                        itemBuilder: (context, index, realIndex) {
                          return Image.network(
                            mainImages['imageUrl'][index],
                            width: double.infinity,
                            fit: BoxFit.cover,
                          );
                        },
                        options: CarouselOptions(
                          height: double.infinity,
                          autoPlay: true,
                          enableInfiniteScroll: true,
                          viewportFraction: 1,
                          autoPlayAnimationDuration: const Duration(seconds: 3),
                          onPageChanged: (index, reason) =>
                              setState(() => mainImageActiveIndex = index),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AnimatedSmoothIndicator(
                            onDotClicked: (int index) =>
                                mainImageCarouselController
                                    .animateToPage(index),
                            effect: const ExpandingDotsEffect(
                              dotWidth: 14,
                              dotHeight: 14,
                              dotColor: Color(0xffececec),
                              activeDotColor: Color(0xff0AF0E8),
                            ),
                            activeIndex: mainImageActiveIndex,
                            count: mainImages['imageUrl'].length,
                          ),
                          const SizedBox(
                            height: 16,
                          )
                        ],
                      ),
                    ],
                  );
                },
              ),
              collapseMode: CollapseMode.pin,
            ),
          ),
          // 공지사항
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0, left: 16, right: 16),
              child: AnimatedContainer(
                height: _noticeIndex ? 160 : 48,
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
                          child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                            stream: homeNotice,
                            builder: (context, snapshot) {

                              if(!snapshot.hasData){
                                return const SizedBox.shrink();
                              }

                              var noticeText = snapshot.data;

                              return Text(
                                  noticeText!['noticeText'].toString().replaceAll('\\n', '\n'),
                                  maxLines: _noticeIndex ? 5 : 1,
                                  overflow: TextOverflow.ellipsis);
                            }
                          ),
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
                    child:
                        StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                            stream: homeExhibitions,
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return const Center(
                                    child: CupertinoActivityIndicator());
                              }

                              var exhibitionImages = snapshot.data;

                              return Stack(
                                children: [
                                  PageView.builder(
                                    controller: _exhibitionsController,
                                    itemCount:
                                        exhibitionImages!['imageUrl'].length,
                                    itemBuilder: (_, index) => Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, right: 8.0),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Stack(
                                          children: [
                                            Container(
                                              color: const Color(0xffececec),
                                            ),
                                            SizedBox.expand(
                                              child: Image.network(
                                                exhibitionImages['imageUrl']
                                                    [index],
                                                width: double.infinity,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }),
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
                    height: 120,
                    child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                      stream: homeCategory,
                      builder: (context, snapshot) {

                        if(!snapshot.hasData) {
                          return const CupertinoActivityIndicator();
                        }

                        var categoryInfo = snapshot.data!.docs;

                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: categoryInfo.length,
                          padding: const EdgeInsets.only(left: 8.0),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16.0),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    SizedBox(
                                      width: 144,
                                      child: Image.network(
                                        categoryInfo[index]['categoryImageUrl'],
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Container(
                                      width: 144,
                                      color: Colors.black.withOpacity(0.6),
                                    ),
                                    SizedBox(
                                      width: 112,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            categoryInfo[index]['categoryMainText'],
                                            style: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 4.0),
                                            child: Text(
                                              categoryInfo[index]['categorySubText'].toString().replaceAll('\\n', '\n'),
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
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
                            );
                          },
                        );
                      }
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
              children: <Widget>[
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
                      child: reservListView(4)),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const MainRoutePage(selectPageIndex: 2);
                          },
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      surfaceTintColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      side: const BorderSide(width: 0.8),
                    ),
                    child: Container(
                      width: double.infinity,
                      height: 40,
                      alignment: Alignment.center,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '더보기',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.black),
                          ),
                          SizedBox(width: 4),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 14,
                            color: Colors.black,
                          )
                        ],
                      ),
                    ),
                  ),
                )
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
