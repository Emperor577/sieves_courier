import 'package:flutter/material.dart';
import 'package:sieves_courier/screens/home/home.dart';

class AuthenticateScreen extends StatelessWidget {
  const AuthenticateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body:  Container(
        width: size.width,
        height: size.height,
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: 10,
          top: size.height * 0.2
        ),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(
                    'Добро пожаловать',
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(height: 12,),
                  Container(
                    width: size.width * 0.6,
                    child: Text(
                      'Напишите логин и пароль для входа в систему',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF807D7D)
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
              SizedBox(height: 55.0,),
              Container(
                width: size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Имя пользователя',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w400
                      ),
                    ),
                    SizedBox(height: 15,),
                    TextField(
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w400
                      ),
                      autofocus: false,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(
                            left: 10,
                            right: 10,
                            top: 5,
                            bottom: 5
                        ),
                        filled: true,
                        fillColor: Color(0XFFDCE9FF),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide.none
                        ),
                      ),
                    ),
                    SizedBox(height: 13,),
                    Text(
                      'Пароль',
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w400
                      ),
                    ),
                    SizedBox(height: 15,),
                    TextField(
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w400
                      ),
                      autofocus: false,
                      obscureText: true,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(
                            left: 10,
                            right: 10,
                            top: 5,
                            bottom: 5
                        ),
                        filled: true,
                        fillColor: Color(0XFFDCE9FF),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide.none
                        ),
                      ),
                    ),
                    SizedBox(height: 50.0,),
                    Container(
                      width: size.width,
                      height: 50.0,
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => HomeScreen()),
                            );
                          },
                          child: Text(
                            'Продолжить',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w600
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)
                            )
                          ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        child: Text(
            '© 2021 Sieves copyright',
          textAlign: TextAlign.center,
        ),
        elevation: 0,
      ),
    );
  }
}
