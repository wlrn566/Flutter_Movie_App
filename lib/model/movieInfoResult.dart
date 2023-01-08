// To parse this JSON data, do
//
//     final movieInfoResult = movieInfoResultFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

MovieInfoResult movieInfoResultFromJson(String str) => MovieInfoResult.fromJson(json.decode(str));

String movieInfoResultToJson(MovieInfoResult data) => json.encode(data.toJson());

class MovieInfoResult {
    MovieInfoResult({
        required this.movieInfoResult,
    });

    final MovieInfoResultClass movieInfoResult;

    factory MovieInfoResult.fromJson(Map<String, dynamic> json) => MovieInfoResult(
        movieInfoResult: MovieInfoResultClass.fromJson(json["movieInfoResult"]),
    );

    Map<String, dynamic> toJson() => {
        "movieInfoResult": movieInfoResult.toJson(),
    };
}

class MovieInfoResultClass {
    MovieInfoResultClass({
        required this.movieInfo,
        required this.source,
    });

    final MovieInfo movieInfo;
    final String source;

    factory MovieInfoResultClass.fromJson(Map<String, dynamic> json) => MovieInfoResultClass(
        movieInfo: MovieInfo.fromJson(json["movieInfo"]),
        source: json["source"],
    );

    Map<String, dynamic> toJson() => {
        "movieInfo": movieInfo.toJson(),
        "source": source,
    };
}

class MovieInfo {
    MovieInfo({
        required this.movieCd,
        required this.movieNm,
        required this.movieNmEn,
        required this.movieNmOg,
        required this.showTm,
        required this.prdtYear,
        required this.openDt,
        required this.prdtStatNm,
        required this.typeNm,
        required this.nations,
        required this.genres,
        required this.directors,
        required this.actors,
        required this.showTypes,
        required this.companys,
        required this.audits,
        required this.staffs,
    });

    final String movieCd;
    final String? movieNm;
    final String? movieNmEn;
    final String? movieNmOg;
    final String? showTm;
    final String? prdtYear;
    final String? openDt;
    final String? prdtStatNm;
    final String? typeNm;
    final List<Nation?>? nations;
    final List<Genre?>? genres;
    final List<Director?>? directors;
    final List<Actor?>? actors;
    final List<ShowType?>? showTypes;
    final List<Company?>? companys;
    final List<Audit?>? audits;
    final List<dynamic>? staffs;

    factory MovieInfo.fromJson(Map<String, dynamic> json) => MovieInfo(
        movieCd: json["movieCd"],
        movieNm: json["movieNm"],
        movieNmEn: json["movieNmEn"],
        movieNmOg: json["movieNmOg"],
        showTm: json["showTm"],
        prdtYear: json["prdtYear"],
        openDt: json["openDt"],
        prdtStatNm: json["prdtStatNm"],
        typeNm: json["typeNm"],
        nations: json["nations"] == null ? [] : List<Nation?>.from(json["nations"]!.map((x) => Nation.fromJson(x))),
        genres: json["genres"] == null ? [] : List<Genre?>.from(json["genres"]!.map((x) => Genre.fromJson(x))),
        directors: json["directors"] == null ? [] : List<Director?>.from(json["directors"]!.map((x) => Director.fromJson(x))),
        actors: json["actors"] == null ? [] : List<Actor?>.from(json["actors"]!.map((x) => Actor.fromJson(x))),
        showTypes: json["showTypes"] == null ? [] : List<ShowType?>.from(json["showTypes"]!.map((x) => ShowType.fromJson(x))),
        companys: json["companys"] == null ? [] : List<Company?>.from(json["companys"]!.map((x) => Company.fromJson(x))),
        audits: json["audits"] == null ? [] : List<Audit?>.from(json["audits"]!.map((x) => Audit.fromJson(x))),
        staffs: json["staffs"] == null ? [] : List<dynamic>.from(json["staffs"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "movieCd": movieCd,
        "movieNm": movieNm,
        "movieNmEn": movieNmEn,
        "movieNmOg": movieNmOg,
        "showTm": showTm,
        "prdtYear": prdtYear,
        "openDt": openDt,
        "prdtStatNm": prdtStatNm,
        "typeNm": typeNm,
        "nations": nations == null ? [] : List<dynamic>.from(nations!.map((x) => x!.toJson())),
        "genres": genres == null ? [] : List<dynamic>.from(genres!.map((x) => x!.toJson())),
        "directors": directors == null ? [] : List<dynamic>.from(directors!.map((x) => x!.toJson())),
        "actors": actors == null ? [] : List<dynamic>.from(actors!.map((x) => x!.toJson())),
        "showTypes": showTypes == null ? [] : List<dynamic>.from(showTypes!.map((x) => x!.toJson())),
        "companys": companys == null ? [] : List<dynamic>.from(companys!.map((x) => x!.toJson())),
        "audits": audits == null ? [] : List<dynamic>.from(audits!.map((x) => x!.toJson())),
        "staffs": staffs == null ? [] : List<dynamic>.from(staffs!.map((x) => x)),
    };
}

class Actor {
    Actor({
        required this.peopleNm,
        required this.peopleNmEn,
        required this.cast,
        required this.castEn,
    });

    final String? peopleNm;
    final String? peopleNmEn;
    final String? cast;
    final String? castEn;

    factory Actor.fromJson(Map<String, dynamic> json) => Actor(
        peopleNm: json["peopleNm"],
        peopleNmEn: json["peopleNmEn"],
        cast: json["cast"],
        castEn: json["castEn"],
    );

    Map<String, dynamic> toJson() => {
        "peopleNm": peopleNm,
        "peopleNmEn": peopleNmEn,
        "cast": cast,
        "castEn": castEn,
    };
}

class Audit {
    Audit({
        required this.auditNo,
        required this.watchGradeNm,
    });

    final String? auditNo;
    final String? watchGradeNm;

    factory Audit.fromJson(Map<String, dynamic> json) => Audit(
        auditNo: json["auditNo"],
        watchGradeNm: json["watchGradeNm"],
    );

    Map<String, dynamic> toJson() => {
        "auditNo": auditNo,
        "watchGradeNm": watchGradeNm,
    };
}

class Company {
    Company({
        required this.companyCd,
        required this.companyNm,
        required this.companyNmEn,
        required this.companyPartNm,
    });

    final String? companyCd;
    final String? companyNm;
    final String? companyNmEn;
    final String? companyPartNm;

    factory Company.fromJson(Map<String, dynamic> json) => Company(
        companyCd: json["companyCd"],
        companyNm: json["companyNm"],
        companyNmEn: json["companyNmEn"],
        companyPartNm: json["companyPartNm"],
    );

    Map<String, dynamic> toJson() => {
        "companyCd": companyCd,
        "companyNm": companyNm,
        "companyNmEn": companyNmEn,
        "companyPartNm": companyPartNm,
    };
}

class Director {
    Director({
        required this.peopleNm,
        required this.peopleNmEn,
    });

    final String? peopleNm;
    final String? peopleNmEn;

    factory Director.fromJson(Map<String, dynamic> json) => Director(
        peopleNm: json["peopleNm"],
        peopleNmEn: json["peopleNmEn"],
    );

    Map<String, dynamic> toJson() => {
        "peopleNm": peopleNm,
        "peopleNmEn": peopleNmEn,
    };
}

class Genre {
    Genre({
        required this.genreNm,
    });

    final String? genreNm;

    factory Genre.fromJson(Map<String, dynamic> json) => Genre(
        genreNm: json["genreNm"],
    );

    Map<String, dynamic> toJson() => {
        "genreNm": genreNm,
    };
}

class Nation {
    Nation({
        required this.nationNm,
    });

    final String? nationNm;

    factory Nation.fromJson(Map<String, dynamic> json) => Nation(
        nationNm: json["nationNm"],
    );

    Map<String, dynamic> toJson() => {
        "nationNm": nationNm,
    };
}

class ShowType {
    ShowType({
        required this.showTypeGroupNm,
        required this.showTypeNm,
    });

    final String? showTypeGroupNm;
    final String? showTypeNm;

    factory ShowType.fromJson(Map<String, dynamic> json) => ShowType(
        showTypeGroupNm: json["showTypeGroupNm"],
        showTypeNm: json["showTypeNm"],
    );

    Map<String, dynamic> toJson() => {
        "showTypeGroupNm": showTypeGroupNm,
        "showTypeNm": showTypeNm,
    };
}
