// To parse this JSON data, do
//
//     final dailyBoxOfficeList = dailyBoxOfficeListFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

DailyBoxOfficeList dailyBoxOfficeListFromJson(String str) => DailyBoxOfficeList.fromJson(json.decode(str));

String dailyBoxOfficeListToJson(DailyBoxOfficeList data) => json.encode(data.toJson());

class DailyBoxOfficeList {
    DailyBoxOfficeList({
        required this.boxOfficeResult,
    });

    final BoxOfficeResult? boxOfficeResult;

    factory DailyBoxOfficeList.fromJson(Map<String, dynamic> json) => DailyBoxOfficeList(
        boxOfficeResult: BoxOfficeResult.fromJson(json["boxOfficeResult"]),
    );

    Map<String, dynamic> toJson() => {
        "boxOfficeResult": boxOfficeResult!.toJson(),
    };
}

class BoxOfficeResult {
    BoxOfficeResult({
        required this.boxofficeType,
        required this.showRange,
        required this.dailyBoxOfficeList,
    });

    final String boxofficeType;
    final String showRange;
    final List<DailyBoxOfficeListElement> dailyBoxOfficeList;

    factory BoxOfficeResult.fromJson(Map<String, dynamic> json) => BoxOfficeResult(
        boxofficeType: json["boxofficeType"],
        showRange: json["showRange"],
        dailyBoxOfficeList: List<DailyBoxOfficeListElement>.from(json["dailyBoxOfficeList"]!.map((x) => DailyBoxOfficeListElement.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "boxofficeType": boxofficeType,
        "showRange": showRange,
        "dailyBoxOfficeList":  List<dynamic>.from(dailyBoxOfficeList.map((x) => x.toJson())),
    };
}

class DailyBoxOfficeListElement {
    DailyBoxOfficeListElement({
        required this.rank,
        required this.movieCd,
        required this.movieNm,
        required this.openDt,
        required this.audiAcc,
        required this.peopleNm,
        // required this.prdtYear,
        required this.link,
        required this.imageUrl,
    });

    final String rank;
    final String movieCd;
    final String movieNm;
    final DateTime openDt;
    final String? audiAcc;
    late String? peopleNm;
    // late String? prdtYear;
    late String? link;
    late String? imageUrl;

    factory DailyBoxOfficeListElement.fromJson(Map<String, dynamic> json) => DailyBoxOfficeListElement(
        rank: json["rank"],
        movieCd: json["movieCd"],
        movieNm: json["movieNm"],
        openDt: DateTime.parse(json["openDt"]),
        audiAcc: json["audiAcc"],
        peopleNm: null,
        // prdtYear: null,
        link: null,
        imageUrl: null,
    );

    Map<String, dynamic> toJson() => {
        "rank": rank,
        "movieCd": movieCd,
        "movieNm": movieNm,
        "openDt": "${openDt.year.toString().padLeft(4, '0')}-${openDt.month.toString().padLeft(2, '0')}-${openDt.day.toString().padLeft(2, '0')}",
        "audiAcc": audiAcc,
        "peopleNm": peopleNm,
        // "prdtYear": prdtYear,
        "link": link,
        "image_url": imageUrl,
    };

}
