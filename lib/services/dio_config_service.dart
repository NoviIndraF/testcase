import 'dart:async';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

Dio dioInstance;
createInstance() async {

  var options = BaseOptions(
      baseUrl: "https://imdb8.p.rapidapi.com/auto-complete?q=game%20of%20thr",
      connectTimeout: 12000,
      receiveTimeout: 12000,
      headers: {
        "x-rapidapi-key": "e3467e791dmsh47233efcc5982c3p1cff02jsn5f0ca168691b",
        "x-rapidapi-host": "imdb8.p.rapidapi.com"
      });
  dioInstance = new Dio(options);
  dioInstance.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 90));

}

Future<Dio> dio() async {
  await createInstance();
  dioInstance.options.baseUrl = "https://imdb8.p.rapidapi.com/auto-complete?q=game%20of%20thr";
  return dioInstance;
}

