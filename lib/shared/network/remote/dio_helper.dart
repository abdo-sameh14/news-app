import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/adapter.dart';
import 'package:flutter/foundation.dart';


class DioHelper{

  static Dio? dio;


  static init(){
   dio = Dio(
      BaseOptions(
        baseUrl: 'https://newsapi.org/',
        receiveDataWhenStatusError: true
      )
    );
   if(!kIsWeb){
     (dio?.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
         (HttpClient client) {
       client.badCertificateCallback =
           (X509Certificate cert, String host, int port) => true;
       return client;

   };}

  }

  static Future<Response> getData({
    required String url,
    required Map<String, dynamic> query
}) async {
    return await dio!.get(url, queryParameters: query);
  }
}