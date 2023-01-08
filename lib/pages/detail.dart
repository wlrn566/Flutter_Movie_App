import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parse;
import 'package:movie_app/model/movieInfoResult.dart';
import 'package:movie_app/repository/movie.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key, required this.movieCd, required this.imageUrl, required this.link});

  final String movieCd;
  final String imageUrl;
  final String link;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final MovieRepository _movieRepository = MovieRepository();

  late MovieInfoResult movieInfoResult;
  bool loading = false;

  String content = ""; // 줄거리

  @override
  void initState() {
    super.initState();
    init();
    getContent();
  }

  void init() async {
    log(widget.movieCd);
    log(widget.link);
    setState(() {
      _movieRepository.getMovieDetail(movieCd: widget.movieCd).then((value) {
        movieInfoResult = value;
        setLoading();
      });
    });
  }

  void setLoading() {
    setState(() {
      loading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!loading) {
      return const SizedBox(
        height: 250,
        child: Center(
          child: CircularProgressIndicator()
        )
      );
    } else {
      return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.dstATop),
            image: NetworkImage(widget.imageUrl),
          )
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text("영화 상세 정보"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 250,
                      child: Column(
                        children: [
                          getText(movieInfoResult.movieInfoResult.movieInfo.movieNm!, 24.0),
                          SizedBox(
                            height: 200,
                            child: Image.network(widget.imageUrl, fit: BoxFit.fill,)
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height - kToolbarHeight - 300,
                      child: Column(
                        children: [
                          Flexible(
                            child: RichText(
                            overflow: TextOverflow.ellipsis,
                            maxLines: 100,
                            strutStyle: StrutStyle(fontSize: 16.0),
                            text: TextSpan(
                                text: content,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.0,
                                  )
                                ),
                            )
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }
  }

  void getContent() async {
    final response = await http.get(Uri.parse(widget.link));

    dom.Document document = parse.parse(response.body);

    setState(() {
      content = document.getElementsByClassName('con_tx')[0].innerHtml.toString().replaceAll("<br>&nbsp;", "");
      log(content);
    });
  }

  Widget getText(String text, double fontSize) {
    return Text(
      text, 
      style: TextStyle(
        fontSize: fontSize,
        color: Colors.white,
        fontWeight: FontWeight.w700
      )
    );
  }
}