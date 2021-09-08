import '../../models/http_exception.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sieves_courier/providers/auth.provider.dart';
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
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(
            top: 100
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
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
              AuthCard(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(
          bottom: 30
        ),
        child: new BottomAppBar(
          color: Colors.transparent,
          child: Text(
              '© 2021 Sieves copyright',
            textAlign: TextAlign.center,
          ),
          elevation: 0,
        ),
      ),
    );
  }
}

class AuthCard extends StatefulWidget {
  const AuthCard({Key? key}) : super(key: key);

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _usernameIsInvalid = false;
  bool _passwordIsInvalid = false;
  var _isLoading = false;

  bool validateFields() {
    if (_usernameController.text.isEmpty && _passwordController.text.isEmpty) {
      setState(() {
        _usernameIsInvalid = true;
        _passwordIsInvalid = true;
      });
      return false;
    }
    if (_usernameController.text.isEmpty || _passwordController.text.isEmpty) {
      if (_usernameController.text.isEmpty) {
        setState(() {
          _usernameIsInvalid = true;
        });
      }
      if (_usernameController.text.isNotEmpty) {
        setState(() {
          _usernameIsInvalid = false;
        });
      }
      if (_passwordController.text.isEmpty) {
        setState(() {
          _passwordIsInvalid = true;
        });
      }
      if (_passwordController.text.isNotEmpty) {
        setState(() {
          _passwordIsInvalid = false;
        });
      }
      return false;
    }
    else {
      setState(() {
        _passwordIsInvalid = false;
        _usernameIsInvalid = false;
      });
    }
    return true;
  }

  Future<void> _submit() async{
    if (validateFields() == false) {
      return;
    }
    setState(() {
      _isLoading = true;
    });

    try {
      await Provider.of<Auth>(context, listen: false).login(
          _usernameController.text,
          _passwordController.text
      );
      // Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    } on HttpException catch(error) {
      var errorMessage = error.toString();
      _showErrorDialog(errorMessage);
    } catch (error) {
      const errorMessage = 'Не могу распознать вас. Пожалуйста, попробуйте позже';
      _showErrorDialog(errorMessage);
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _showErrorDialog(String message) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Произошла ошибка'),
          content: Text(message),
          actions: <Widget>[
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Ok')
            )
          ],
        )
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: size.width,
            child: Text(
              'Имя пользователя',
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w400
              ),
              textAlign: TextAlign.start,
            ),
          ),
          SizedBox(height: 15,),
          TextField(
            controller: _usernameController,
            style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w400
            ),
            autofocus: false,
            decoration: InputDecoration(
              errorText: _usernameIsInvalid ? 'это поле не может быть пустым' : null,
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
          Container(
            width: size.width,
            child: Text(
              'Пароль',
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w400
              ),
              textAlign: TextAlign.start,
            ),
          ),
          SizedBox(height: 15,),
          TextField(
            controller: _passwordController,
            style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w400
            ),
            autofocus: false,
            obscureText: true,
            decoration: InputDecoration(
              errorText: _passwordIsInvalid ? 'это поле не может быть пустым' : null,
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
          if (_isLoading)
            CircularProgressIndicator()
          else
          Container(
            width: size.width,
            height: 50.0,
            child: ElevatedButton(
              onPressed: () {
                _submit();
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
    );
  }
}
