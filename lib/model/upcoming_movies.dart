// To parse this JSON data, do
//
//     final upcomingMovies = upcomingMoviesFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

UpcomingMovies upcomingMoviesFromJson(String str) => UpcomingMovies.fromJson(json.decode(str));

String upcomingMoviesToJson(UpcomingMovies data) => json.encode(data.toJson());

class UpcomingMovies {
    UpcomingMovies({
        required this.movieListResult,
    });

    final MovieListResult? movieListResult;

    factory UpcomingMovies.fromJson(Map<String, dynamic> json) => UpcomingMovies(
        movieListResult: MovieListResult.fromJson(json["movieListResult"]),
    );

    Map<String, dynamic> toJson() => {
        "movieListResult": movieListResult!.toJson(),
    };
}

class MovieListResult {
    MovieListResult({
        required this.totCnt,
        required this.source,
        required this.movieList,
    });

    final int totCnt;
    final String source;
    final List<MovieList> movieList;

    factory MovieListResult.fromJson(Map<String, dynamic> json) => MovieListResult(
        totCnt: json["totCnt"],
        source: json["source"],
        movieList: List<MovieList>.from(json["movieList"].map((x) => MovieList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "totCnt": totCnt,
        "source": source,
        "movieList": movieList,
    };
}

class MovieList {
    MovieList({
        required this.movieCd,
        required this.movieNm,
        required this.movieNmEn,
        required this.prdtYear,
        required this.openDt,
        required this.typeNm,
        required this.prdtStatNm,
        required this.nationAlt,
        required this.genreAlt,
        required this.repNationNm,
        required this.repGenreNm,
        required this.directors,
        required this.companys,
        required this.imageUrl,
    });

    final String? movieCd;
    final String? movieNm;
    final String? movieNmEn;
    final String? prdtYear;
    final String? openDt;
    final String? typeNm;
    final String? prdtStatNm;
    final String? nationAlt;
    final String? genreAlt;
    final String? repNationNm;
    final String? repGenreNm;
    final List<Director?>? directors;
    final List<Company?>? companys;
    late String? imageUrl;

    factory MovieList.fromJson(Map<String, dynamic> json) => MovieList(
        movieCd: json["movieCd"],
        movieNm: json["movieNm"],
        movieNmEn: json["movieNmEn"],
        prdtYear: json["prdtYear"],
        openDt: json["openDt"],
        typeNm: json["typeNm"],
        prdtStatNm: json["prdtStatNm"],
        nationAlt: json["nationAlt"],
        genreAlt: json["genreAlt"],
        repNationNm: json["repNationNm"],
        repGenreNm: json["repGenreNm"],
        directors: json["directors"] == null ? [] : List<Director?>.from(json["directors"]!.map((x) => Director.fromJson(x))),
        companys: json["companys"] == null ? [] : List<Company?>.from(json["companys"]!.map((x) => Company.fromJson(x))),
        imageUrl: null,
    );

    Map<String, dynamic> toJson() => {
        "movieCd": movieCd,
        "movieNm": movieNm,
        "movieNmEn": movieNmEn,
        "prdtYear": prdtYear,
        "openDt": openDt,
        "typeNm": typeNm,
        "prdtStatNm": prdtStatNm,
        "nationAlt": nationAlt,
        "genreAlt": genreAlt,
        "repNationNm": repNationNm,
        "repGenreNm": repGenreNm,
        "directors": directors == null ? [] : List<dynamic>.from(directors!.map((x) => x!.toJson())),
        "companys": companys == null ? [] : List<dynamic>.from(companys!.map((x) => x!.toJson())),
        "imageUrl": imageUrl,
    };
}

class Company {
    Company({
        required this.companyCd,
        required this.companyNm,
    });

    final String? companyCd;
    final String? companyNm;

    factory Company.fromJson(Map<String, dynamic> json) => Company(
        companyCd: json["companyCd"],
        companyNm: json["companyNm"],
    );

    Map<String, dynamic> toJson() => {
        "companyCd": companyCd,
        "companyNm": companyNm,
    };
}

class Director {
    Director({
        required this.peopleNm,
    });

    final String? peopleNm;

    factory Director.fromJson(Map<String, dynamic> json) => Director(
        peopleNm: json["peopleNm"],
    );

    Map<String, dynamic> toJson() => {
        "peopleNm": peopleNm,
    };
}
