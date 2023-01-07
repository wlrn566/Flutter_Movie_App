// To parse this JSON data, do
//
//     final dailyBoxOfficeList = dailyBoxOfficeListFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

DailyBoxOfficeList? dailyBoxOfficeListFromJson(String str) => DailyBoxOfficeList.fromJson(json.decode(str));

String dailyBoxOfficeListToJson(DailyBoxOfficeList? data) => json.encode(data!.toJson());

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

    final String? boxofficeType;
    final String? showRange;
    final List<DailyBoxOfficeListElement?>? dailyBoxOfficeList;

    factory BoxOfficeResult.fromJson(Map<String, dynamic> json) => BoxOfficeResult(
        boxofficeType: json["boxofficeType"],
        showRange: json["showRange"],
        dailyBoxOfficeList: json["dailyBoxOfficeList"] == null ? [] : List<DailyBoxOfficeListElement?>.from(json["dailyBoxOfficeList"]!.map((x) => DailyBoxOfficeListElement.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "boxofficeType": boxofficeType,
        "showRange": showRange,
        "dailyBoxOfficeList": dailyBoxOfficeList == null ? [] : List<dynamic>.from(dailyBoxOfficeList!.map((x) => x!.toJson())),
    };
}

class DailyBoxOfficeListElement {
    DailyBoxOfficeListElement({
        required this.rnum,
        required this.rank,
        required this.rankInten,
        required this.rankOldAndNew,
        required this.movieCd,
        required this.movieNm,
        required this.openDt,
        required this.salesAmt,
        required this.salesShare,
        required this.salesInten,
        required this.salesChange,
        required this.salesAcc,
        required this.audiCnt,
        required this.audiInten,
        required this.audiChange,
        required this.audiAcc,
        required this.scrnCnt,
        required this.showCnt,
    });

    final String? rnum;
    final String? rank;
    final String? rankInten;
    final String? rankOldAndNew;
    final String? movieCd;
    final String? movieNm;
    final DateTime? openDt;
    final String? salesAmt;
    final String? salesShare;
    final String? salesInten;
    final String? salesChange;
    final String? salesAcc;
    final String? audiCnt;
    final String? audiInten;
    final String? audiChange;
    final String? audiAcc;
    final String? scrnCnt;
    final String? showCnt;

    factory DailyBoxOfficeListElement.fromJson(Map<String, dynamic> json) => DailyBoxOfficeListElement(
        rnum: json["rnum"],
        rank: json["rank"],
        rankInten: json["rankInten"],
        rankOldAndNew: json["rankOldAndNew"],
        movieCd: json["movieCd"],
        movieNm: json["movieNm"],
        openDt: DateTime.parse(json["openDt"]),
        salesAmt: json["salesAmt"],
        salesShare: json["salesShare"],
        salesInten: json["salesInten"],
        salesChange: json["salesChange"],
        salesAcc: json["salesAcc"],
        audiCnt: json["audiCnt"],
        audiInten: json["audiInten"],
        audiChange: json["audiChange"],
        audiAcc: json["audiAcc"],
        scrnCnt: json["scrnCnt"],
        showCnt: json["showCnt"],
    );

    Map<String, dynamic> toJson() => {
        "rnum": rnum,
        "rank": rank,
        "rankInten": rankInten,
        "rankOldAndNew": rankOldAndNew,
        "movieCd": movieCd,
        "movieNm": movieNm,
        "openDt": "${openDt!.year.toString().padLeft(4, '0')}-${openDt!.month.toString().padLeft(2, '0')}-${openDt!.day.toString().padLeft(2, '0')}",
        "salesAmt": salesAmt,
        "salesShare": salesShare,
        "salesInten": salesInten,
        "salesChange": salesChange,
        "salesAcc": salesAcc,
        "audiCnt": audiCnt,
        "audiInten": audiInten,
        "audiChange": audiChange,
        "audiAcc": audiAcc,
        "scrnCnt": scrnCnt,
        "showCnt": showCnt,
    };
}
