import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyDio{
  var dio = new Dio();
  var response;
  static const storage = FlutterSecureStorage();
  MyDio() {
    // 기본 정보
    dio.options.baseUrl =
    'http://192.168.0.12:8000'; //개발 중 주소는 내 아이피 localhost는 x
    dio.options.connectTimeout = Duration(seconds: 5); // 5s
    dio.options.receiveTimeout = Duration(seconds: 10);
    dio.options.headers =
    {'Content-Type': 'application/json'};
  }

  //post 요청
  dynamic post(String path, {data})async{
    response = await dio.post(path, data:data);
    return response;
  }
  // get요청
  dynamic get(String path, {Options? options}) async{
    response = await dio.get(path, options: options);
    return response;
  }
  //delete 요청
  dynamic delete(String path) async{
    response = await dio.delete(path);
    return response;
  }
  // put 요청
  dynamic put(String path, {data}) async{
    response = await dio.put(path, data: data);
    return response;
  }

  // download 요청
  dynamic download(String path, String savePath) async{
    response = await dio.download(path, savePath);
    return response;
  }

  // 에러 인터셉터 추가 코드
  void addErrorInterceptor(BuildContext context){
    dio.interceptors.add(InterceptorsWrapper(
      onError: (DioException error, ErrorInterceptorHandler handler){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
                error.response!.data['message'], //에러코드 : 에러메세지
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
            duration: const Duration(seconds: 3),
            backgroundColor: Colors.redAccent,
          )
        );
        return handler.next(error);
      }
    ));
  }

  void addResponseInterceptor(String headerKey, String headerValue){
      dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) async {
            if(headerKey == 'Authorization'){
              String tmp = await _refreshToken(headerValue);
              options.headers[headerKey] = tmp;
            }else{
              options.headers[headerKey] = headerValue;
            }
            return handler.next(options);
          }
        )
      );
  }
  Future<String> _refreshToken(String token)async{
    Dio _dio = Dio(
      BaseOptions(
        baseUrl: 'http://192.168.0.12:8000',
        contentType: 'application/json',
      )
    ); // accessToken 재발급을 위한 추가 dio
    String? accessTime = await storage.read(key:'accessTokenTime');
    DateTime befTime = DateTime.parse(accessTime.toString());
    if(befTime.add(Duration(hours: 1)).isBefore(DateTime.now())){ // accessToken 저장한지 1시간이 지났으면 AccessToken 다시 받아옴.
      _dio.options.headers['Authorization'] = token;
      String? refreshToken = await storage.read(key: 'refreshToken');
      _dio.options.headers['cookie'] = refreshToken.toString();
      var res1 = await _dio.post('/user/refresh-token');

      final setCookie = res1.headers['set-cookie'];
      await storage.delete(key: 'accessToken');
      await storage.write(key: 'accessToken', value: res1.data['accessToken']);
      await storage.delete(key: 'refreshToken');
      await storage.write(key: 'refreshToken', value: setCookie![0]);

      await storage.delete(key: 'accessTokenTime');
      await storage.write(key: 'accessTokenTime', value: DateTime.now().toString());
      return 'Bearer '+res1.data['accessToken'];
    }else{
      return token;
    }
  }


}