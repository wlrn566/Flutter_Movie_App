import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:movie_app/const.dart';
import 'package:movie_app/model/dailyBoxOfficeList.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class MovieRepository {
  
  final dio = Dio();

  final logger = PrettyDioLogger(
    requestHeader: true,
    requestBody: true,
    responseBody: true,
    responseHeader: false,
    compact: false,
  );

  // 일일 박스오피스 조회
  Future<List<DailyBoxOfficeListElement>> getMovieBoxOffice() async {
    // dio.interceptors.add(logger);
    
    DateTime now = DateTime.now();
    DateTime yesterDay = now.subtract(const Duration(days: 1));

    String targetDtNow = DateFormat('yyyyMMdd').format(now).replaceAll("-", "");
    String targetDtYesterDay = DateFormat('yyyyMMdd').format(yesterDay).replaceAll("-", "");
    
    try {
      final responseData = await dio.get("http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=$MOVIE_KEY&targetDt=$targetDtNow");
      
      // 만약 오늘날짜의 박스오피스가 없으면 어제의 박스오피스를 조회 (오늘 박스오피스가 안 나온 경우)
      if (responseData.data['boxOfficeResult']['dailyBoxOfficeList'].toList().isEmpty) {
        final responseData2 = await dio.get("http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=$MOVIE_KEY&targetDt=$targetDtYesterDay");
        

        return await getMovieDetail(dailBoxOfficeList:  DailyBoxOfficeList.fromJson(responseData2.data).boxOfficeResult!.dailyBoxOfficeList);

      } else {
        return await getMovieDetail(dailBoxOfficeList: DailyBoxOfficeList.fromJson(responseData.data).boxOfficeResult!.dailyBoxOfficeList);
      }

    } catch (e) {
      return throw e.toString();
    }
    
  }

  // 박스오피스 영화들의 코드를 이용해 제작년도 조회
  Future<List<DailyBoxOfficeListElement>> getMovieDetail({required List<DailyBoxOfficeListElement> dailBoxOfficeList}) async {

    log(dailBoxOfficeList.length.toString());

    try {
      for (int i=0; i<dailBoxOfficeList.length; i++) {
        final responseData = await dio.get("http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json?key=$MOVIE_KEY&movieCd=${dailBoxOfficeList[i].movieCd!}");
        
        // 감독명 값 넣어주기
        // dailBoxOfficeList[i].prdtYear = responseData.data['movieInfoResult']['movieInfo']['prdtYear'];

        // 제작년도 값 넣어주기
        dailBoxOfficeList[i].peopleNm = responseData.data['movieInfoResult']['movieInfo']['directors'][0]['peopleNm'];
      }

      return await getMoviePosterImages(dailBoxOfficeList: dailBoxOfficeList);

    } catch (e) {
      return throw e.toString();
    }
    
  }

  // 박스오피스 영화들의 포스터 이미지 조회
  Future<List<DailyBoxOfficeListElement>> getMoviePosterImages({required List<DailyBoxOfficeListElement> dailBoxOfficeList}) async {

    dio.options.headers = {
      "X-Naver-Client-Id" : NAVER_CLIENT_ID,
      "X-Naver-Client-Secret" : NAVER_CLIENT_SECRET
    };


    try {
      for (int i=0; i<dailBoxOfficeList.length; i++) {
        final responseData = await dio.get(
          // "https://openapi.naver.com/v1/search/movie.json?query=${dailBoxOfficeList[i].movieNm}&yearfrom=${dailBoxOfficeList[i].prdtYear}&yearto=${dailBoxOfficeList[i].prdtYear}"
          "https://openapi.naver.com/v1/search/movie.json?query=${dailBoxOfficeList[i].movieNm!}"
        );

        for (int j=0; j<responseData.data['items'].toList().length; j++) {
          if (responseData.data['items'][j]['director'].toString().contains(dailBoxOfficeList[i].peopleNm!)) {
            dailBoxOfficeList[i].imageUrl = responseData.data['items'][j]['image'];
          }
        }
      }

      return dailBoxOfficeList;

    } catch (e) {
      return throw e.toString();
    }

  } 

}