import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:email_validator/email_validator.dart'; // 이메일 형식 확인

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  late ScrollController _scrollControl = ScrollController();
  TextEditingController _idController = TextEditingController();
  TextEditingController _pwController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _idFocusNode = FocusNode();
  final _pw1FocusNode = FocusNode();
  final _pw2FocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _phoneFocusNode = FocusNode();
  final _keyFocusNode = FocusNode();

  Map<String, String> info = Map();
  bool idck = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollControl.dispose();
    _idFocusNode.dispose();
    _pw1FocusNode.dispose();
    _pw2FocusNode.dispose();
    _emailFocusNode.dispose();
    _phoneFocusNode.dispose();
    _keyFocusNode.dispose();

  }

  static const mainColor = Color(0xff565D6D);
  static const backColor = Color(0xffD9D9D9);
  static const double midSize = 25;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backColor,
      body:Scrollbar(
        controller: _scrollControl,
        child: Center(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              controller: _scrollControl,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 44),
                    child: Text(
                      "Sign in",
                      style: TextStyle(
                        fontSize: 40,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 342,
                    height: 51,
                    child: TextFormField(
                      autofocus: true,
                      validator: (value){
                        if(value!.isEmpty){
                          return "이름을 입력하세요";
                        }else return null;
                      },
                      decoration: const InputDecoration(
                        hintText: "이름",
                      ),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_){
                        FocusScope.of(context).requestFocus(_idFocusNode);
                      },
                      onSaved: (value){
                        info["name"] = value!;
                      },
                    ),
                  ), //이름 입력
                  SizedBox(
                    height: midSize,
                  ),
                  SizedBox(
                    width: 342,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 230,
                          height: 51,
                          child: TextFormField(
                            controller: _idController,
                            validator: (value){
                              if(value!.isEmpty){
                                return "아이디를 입력하세요";
                              }else return null;
                            },
                            decoration: const InputDecoration(
                              hintText: "ID",
                            ),
                            focusNode: _idFocusNode,
                            onFieldSubmitted: (_){
                              FocusScope.of(context).requestFocus(_pw1FocusNode);
                            },

                          ),
                        ),
                      SizedBox(
                          width: 110,
                          height: 51,
                          child: ElevatedButton(
                            onPressed: (){
                              if(_idController.text == ''){
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                    "아이디 값을 입력하세요",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  duration: Duration(seconds: 1),
                                ));
                              }else{
                                setState(() {
                                  idck = true;
                                });
                                //비어 있지 않을 때
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                    "검사중입니다",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  duration: Duration(seconds: 1),
                                ));
                              }
                            },
                            child: Text(
                              "중복확인",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: mainColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),//아이디 입력 및 중복확인
                  SizedBox(
                    width: 342,
                    child: Padding(
                      padding: EdgeInsets.only(top:32),
                      child: TextFormField(
                        controller: _pwController,
                        validator: (value){
                          if(value!.isEmpty){
                            return "비밀번호를 입력하세요";
                          }else return null;
                        },
                        decoration: const InputDecoration(
                          hintText: "비밀번호",
                        ),
                        focusNode: _pw1FocusNode,
                        onFieldSubmitted: (_){
                          FocusScope.of(context).requestFocus(_pw2FocusNode);
                        },
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 342,
                    child: Padding(
                      padding: EdgeInsets.only(top:32),
                      child: TextFormField(
                        validator: (value){
                          if(value!.isEmpty){
                            return "비밀번호를 입력하세요";
                          }else if(value.toString() != _pwController.text){
                            return "두 비밀번호가 다릅니다.";
                          }else return null;
                        },
                        decoration: const InputDecoration(
                          hintText: "비밀번호 확인",
                        ),
                        focusNode: _pw2FocusNode,
                        onFieldSubmitted: (_){
                          FocusScope.of(context).requestFocus(_emailFocusNode);
                        },
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 342,
                    child: Padding(
                      padding: EdgeInsets.only(top:midSize),
                      child: TextFormField(
                        validator: (value){
                          if(value!.isEmpty){
                            return "email을 입력하세요";
                          }else if(!EmailValidator.validate(value!)){
                            return "올바른 형식의 email을 입력하세요";
                          }else return null;
                        },
                        decoration: const InputDecoration(
                          hintText: "Email",
                        ),
                        focusNode: _emailFocusNode,
                        onFieldSubmitted: (_){
                          FocusScope.of(context).requestFocus(_phoneFocusNode);
                        },
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 342,
                    child: Padding(
                      padding: EdgeInsets.only(top:midSize),
                      child: TextFormField(
                        validator: (value){
                          if(value!.isEmpty){
                            return "전화번호를 입력하세요";
                          }else return null;
                        },
                        decoration: const InputDecoration(
                          hintText: "전화번호",
                        ),
                        focusNode: _phoneFocusNode,
                        onFieldSubmitted: (_){
                          FocusScope.of(context).requestFocus(_keyFocusNode);
                        },
                        keyboardType: TextInputType.phone,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 342,
                    child: Padding(
                      padding: EdgeInsets.only(top:midSize),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          hintText: "학원초대키",
                        ),
                        focusNode: _keyFocusNode,
                        onFieldSubmitted: (_){

                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 342,
                    child: Padding(
                      padding: EdgeInsets.only(top:midSize),
                      child: ElevatedButton(
                        onPressed: (){
                          if(!idck){
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                "아이디 중복확인을 누르세요",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              duration: Duration(seconds: 1),
                            ));
                            FocusScope.of(context).requestFocus(_idFocusNode);
                          }
                          _formKey.currentState!.validate();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "회원가입",
                            style: TextStyle(
                              fontSize: 24,
                            ),
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: mainColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      )
    );
  }
}
