import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginpageState();
}

class _LoginpageState extends State<LoginPage> {
  // 입력 받은 아이디/비밀번호를 가져오기 위한 컨트롤러
  TextEditingController _idController = TextEditingController();
  TextEditingController _pwController = TextEditingController();
  // 자동로그인 체크 여부 저장 변수
  bool isAutoLogin = false;

  @override
  Widget build(BuildContext context) {
    const mainColor = Color(0xff565D6D);
    const backColor = Color(0xffD9D9D9);

    return Scaffold(
      backgroundColor: backColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Log in",
              style: TextStyle(
                fontSize: 40.0,
              ),
            ),
            const SizedBox(
              height: 104.0,
            ),
            SizedBox(
              width: 341.99,
              height: 51.43,
              child: TextField(
                controller: _idController,
                autofocus: true,
                decoration: const InputDecoration(
                  //labelText: "ID",
                  hintText: "ID",
                ),
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            SizedBox(
              width: 341.99,
              height: 51.43,
              child: TextField(
                controller: _pwController,
                decoration: const InputDecoration(
                  hintText: "Password",
                ),
                obscureText: true,
              ),
            ),
            const SizedBox(
              height: 13.0,
            ),
            SizedBox(
              width: 341.99,
              height: 51.43,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Checkbox(
                      value: isAutoLogin,
                      onChanged: (bool? value){
                        setState(() {
                          isAutoLogin = value!;
                        });
                        print(isAutoLogin);
                      },

                  ),
                  const Text("자동로그인",
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            SizedBox(
              width: 342.0,
              height: 63.0,
              child: ElevatedButton(
                  onPressed: (){
                    String id = _idController.text;
                    String pw = _pwController.text;
                    // id, pw를 서버에 보내 맞는 정보인지 확인.
                  },
                  child: Text("로그인",
                  style: TextStyle(
                      fontSize: 24.0,
                      color: Colors.white,
                    ),
                  ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: mainColor,
                ),
              ),
            ),
            SizedBox(
              width: 280,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: (){
                      // ID찾기 페이지 이동
                    },
                    child: Text("ID 찾기",
                      style: TextStyle(
                        fontSize: 24.0,
                        color: Color(0xff6A6666)
                      ),
                    )
                  ),

                  TextButton(
                      onPressed: (){
                        // 비밀번호 찾기 페이지 이동
                      },
                      child: Text("비밀번호 찾기",
                        style: TextStyle(
                            fontSize: 24.0,
                            color: Color(0xff6A6666)
                        ),
                      )
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

