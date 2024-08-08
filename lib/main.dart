import 'package:flutter/material.dart';

import 'package:academy_manager/LoginPage.dart';
import 'package:academy_manager/SigninPage.dart';

void main(){
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, //앱내 우측 상단 debug 라벨 없애기
      title: 'Academy Manager',
      theme: ThemeData(
        //primarySwatch: Colors.cyan,
        //colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey[900]),
        useMaterial3: false,
      ),
      home: const MainPage(),
      routes: {
        "/login" : (context) => const LoginPage(),
        "/signin" : (context) => const SigninPage(),
      },
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    const backColor = Color(0xffD9D9D9);
    const mainColor = Color(0xff565D6D);
    return Scaffold(
      backgroundColor: backColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // 화면 세로 중앙으로 정렬
          children: [
            Text(
                "AcademyPro",
              style: TextStyle(
                fontSize: 40.0
              ),
            ),
            SizedBox(
              height: 86.5,
            ),
            SizedBox(
              width: 185.0,
              height: 63.0,
              child: ElevatedButton(
                child: Text("로그인", style: TextStyle(
                  fontSize: 24,
                ),),
                onPressed: (){
                  Navigator.of(context).pushNamedAndRemoveUntil("/login", (route)=>false); // 로그인 페이지 이동
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: mainColor,
                ),
              ),
            ),
            SizedBox(
              height: 50.0,
            ),
            SizedBox(
              width: 185.0,
              height: 63.0,
              child: ElevatedButton(
                child: Text("회원가입",
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
                onPressed: (){
                  Navigator.of(context).pushNamedAndRemoveUntil("/signin", (route)=>false);// 회원가입 페이지 이동
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: mainColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


