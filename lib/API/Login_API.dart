import 'package:academy_manager/Dio/MyDio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:dio/dio.dart';

class LoginApi {
  final dio = MyDio();
  static final storage = FlutterSecureStorage();

  // 로그인 요청을 보내는 메서드
  Future<Response> login(String id, String pw) async {
    return await dio.post('/user/login', data: {"user_id": id, "password": pw});
  }

  // ID 중복 체크 요청을 보내는 메서드
  Future<Response> checkId(String id) async {
    return await dio.get('/user/check-id/$id');
  }

  // 회원가입 요청을 보내는 메서드
  Future<Response> signupUser(Map<String, dynamic> signupData) async {
    return await dio.post('/user/signup', data: signupData);
  }

  // 로그인 후 학원 등록 요청을 보내는 메서드
  Future<Response> registerAcademy(String userId, String academyKey, String role) async {
    final accessToken = await storage.read(key: 'accessToken');
    dio.addResponseInterceptor('Authorization', 'Bearer $accessToken');
    return await dio.post('/registeration/request/user', data: {
      'user_id': userId,
      'academy_key': academyKey,
      'role': role
    });
  }

  // 로그인 정보 저장 (자동 로그인)
  Future<void> saveLoginInfo(String id, String pw, bool isAutoLogin) async {
    if (isAutoLogin) {
      await storage.write(key: "login", value: "user_id $id password $pw");
    }
  }

  // 로그인 후 받은 토큰 저장
  Future<void> saveTokens(Response response, String id) async {
    await storage.delete(key: 'accessToken');
    await storage.write(key: 'accessToken', value: response.data['accessToken']);
    await storage.write(key: 'accessTokenTime', value: DateTime.now().toString());

    // 수정된 부분: null 체크 추가
    final setCookie = response.headers['set-cookie'];
    if (setCookie != null && setCookie.isNotEmpty) {
      await storage.delete(key: 'refreshToken');
      await storage.write(key: 'refreshToken', value: setCookie[0]);
    }

    await storage.delete(key: 'id');
    await storage.write(key: 'id', value: id);
  }

  // 로그인 시 사용자 정보 저장
  Future<void> saveUserInfo(Map<String, dynamic> data) async {
    await storage.write(key: 'user_name', value: data['user']['user_name']);
    await storage.write(key: 'email', value: data['user']['email']);
    await storage.write(key: 'phone', value: data['user']['phone_number']);
  }

  // 저장된 로그인 정보 가져오기
  Future<String?> getUserInfo() async {
    return await storage.read(key: "login");
  }
}
