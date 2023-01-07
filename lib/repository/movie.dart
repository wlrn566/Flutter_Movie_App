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
  
  Future<DailyBoxOfficeList> getMovie() async {
    dio.interceptors.add(logger);
    
    DateTime now = DateTime.now();
    DateTime yesterDay = now.subtract(Duration(days: 1));

    String targetDtNow = DateFormat('yyyyMMdd').format(now).replaceAll("-", "");
    String targetDtYesterDay = DateFormat('yyyyMMdd').format(yesterDay).replaceAll("-", "");
    
    try {
      final responseData = await dio.get("http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=$MOVIE_KEY&targetDt=$targetDtNow");
      
      // 만약 오늘날짜의 박스오피스가 없으면 어제의 박스오피스를 조회 (오늘 박스오피스가 안 나온 경우)
      if (responseData.data['boxOfficeResult']['dailyBoxOfficeList'].toList().isEmpty) {
        final responseData2 = await dio.get("http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=$MOVIE_KEY&targetDt=$targetDtYesterDay");
      
        if (responseData2.data['boxOfficeResult']['dailyBoxOfficeList'].isNotEmpty) {
          return DailyBoxOfficeList.fromJson(responseData2.data);
        
        } else {
          return throw "boxOfficeResult is Empty";
        }

      } else {
        return DailyBoxOfficeList.fromJson(responseData.data);
      }

    } catch (e) {
      return throw e.toString();
    }
    
  }

}