import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:movie_app/model/dailyBoxOfficeList.dart';
import 'package:movie_app/model/movieInfoResult.dart';
import 'package:movie_app/repository/movie.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int indicatorIndex = 0;

  final MovieRepository _movieRepository = MovieRepository();

  List<DailyBoxOfficeListElement> _dailyBoxOfficeList = [];

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    setState(() {
      _movieRepository.getDailyBoxOffice().then((value) {
        _dailyBoxOfficeList = value;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    List<Widget> imagePaths = [
      SizedBox(width: MediaQuery.of(context).size.width, child: Image.asset("assets/images/img1.jpg", fit: BoxFit.fitWidth)),
      SizedBox(width: MediaQuery.of(context).size.width, child: Image.asset("assets/images/img2.jpg", fit: BoxFit.fitWidth)),
      SizedBox(width: MediaQuery.of(context).size.width, child: Image.asset("assets/images/img3.jpg", fit: BoxFit.fitWidth)),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                CarouselSlider(
                  options: CarouselOptions(
                    autoPlay: true,
                    enlargeCenterPage: false, // 사라지는 이미지 효과
                    scrollDirection: Axis.horizontal,
                    viewportFraction: 1.0, // 화면 채우기
                    onPageChanged: (index, reason) {
                      setState(() {
                        indicatorIndex = index;
                      });
                    },
                  ),
                  items: imagePaths
                ),
                Positioned(
                  bottom: 10,
                  right: 0,
                  left: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (int i=0; i<imagePaths.length; i++)
                        Icon(Icons.circle, color: indicatorIndex == i ? Colors.black : Colors.white)
                    ],
                  )
                ),
              ],
            ),
            if (_dailyBoxOfficeList.isEmpty)
              const SizedBox(
                height: 250,
                child: Center(
                  child: CircularProgressIndicator()
                )
              ),
            if (_dailyBoxOfficeList.isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:  [
                      const Text(
                        "일일 박스오피스",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w700
                        ),
                      ),
                      Text(
                        DateFormat("MM.dd").format(DateTime.now()),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 300,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: index == 0 
                          ? const EdgeInsets.fromLTRB(10, 10, 5, 10) 
                          : index == 4
                            ? const EdgeInsets.fromLTRB(5, 10, 10, 10)
                            : const EdgeInsets.fromLTRB(5, 10, 5, 10),
                        child: InkWell(
                          onTap: () async {
                            Navigator.pushNamed(
                              context, '/detail', 
                              arguments: {
                                'movieCd' : _dailyBoxOfficeList[index].movieCd, 
                                'imageUrl' : _dailyBoxOfficeList[index].imageUrl,
                                'link' : _dailyBoxOfficeList[index].link,
                              }
                            );
                          },
                          child: SizedBox(
                            width: 200,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 250,
                                  decoration: BoxDecoration(
                                    border: Border.all(width: 2, color: Colors.grey)
                                  ),
                                  child: Image.network(_dailyBoxOfficeList[index].imageUrl!, fit: BoxFit.fill,),
                                ),
                                Text(
                                  "${_dailyBoxOfficeList[index].rank}. ${_dailyBoxOfficeList[index].movieNm}",
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: _dailyBoxOfficeList.length,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}