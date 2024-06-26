import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'global.dart' as global;
import 'adminnav.dart';
import 'teachernav.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  bool _emailValidate = false;
  bool _passValidate = false;
  String err = "";
  Future<void> login() async {
    final resp = await http.get(Uri.parse(
        'http://${global.ipv4}:3001/auth/${_email.text}/${_password.text}'));
    if (resp.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(resp.body);
      final token = await http
          .get(Uri.parse('http://${global.ipv4}:3001/verify/${json['token']}'));

      if (token.statusCode == 201) {
        setState(() {
          global.token = json['token'];
          global.isLoggedIn = true;
          global.email = json['user']['email'];
          global.isAdmin = (json['user']['isAdmin'] == 1) ? true : false;
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            if (global.isAdmin) {
              return const AdminNav();
            } else {
              return const TeachNav();
            }
          }));
        });
      } else {
        err = 'Invalid token';
      }
    } else {
      setState(() {
        err = 'Incorrect email or password';
      });
      throw Exception('Incorrect email or password');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black38,
      body: Align(
          alignment: Alignment.bottomCenter,
          child: Stack(
              alignment: Alignment.topCenter,
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 500,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 238, 238, 238),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    ),
                    border: Border.all(color: Colors.transparent),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      const Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _email,
                              textAlignVertical: TextAlignVertical.center,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'example@gmail.com',
                                  alignLabelWithHint: true,
                                  errorText:
                                      _emailValidate ? "Required Feild" : null,
                                  isDense: true,
                                  prefixIcon: Container(
                                    margin: const EdgeInsets.only(right: 10),
                                    decoration: const BoxDecoration(
                                      color: Color.fromARGB(255, 113, 212, 204),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(8.0),
                                        bottomLeft: Radius.circular(8.0),
                                      ),
                                    ),
                                    child: const Icon(Icons.email,
                                        color: Colors.white),
                                  ),
                                  contentPadding:
                                      const EdgeInsets.only(left: 10),
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 113, 212, 204),
                                        width: 2),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                  )),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                                obscureText: true,
                                controller: _password,
                                autofocus: false,
                                textAlignVertical: TextAlignVertical.center,
                                decoration: InputDecoration(
                                    hintText: 'password',
                                    border: InputBorder.none,
                                    alignLabelWithHint: true,
                                    errorText:
                                        _passValidate ? "Required Feild" : null,
                                    isDense: true,
                                    prefixIcon: Container(
                                      margin: const EdgeInsets.only(right: 10),
                                      decoration: const BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 113, 212, 204),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(8.0),
                                          bottomLeft: Radius.circular(8.0),
                                        ),
                                      ),
                                      child: const Icon(Icons.lock,
                                          color: Colors.white),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color.fromARGB(
                                              255, 113, 212, 204),
                                          width: 2),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                    ))),
                            const SizedBox(
                              height: 20,
                            ),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  _emailValidate = _email.text.isEmpty;
                                  _passValidate = _password.text.isEmpty;
                                  if (!_emailValidate && !_passValidate) {
                                    login();
                                  }
                                });
                              },
                              style: TextButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 113, 212, 204),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30.0, vertical: 12.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              child: const Text(
                                'Login',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              err,
                              style: const TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: -80,
                  child: Container(
                    decoration: const ShapeDecoration(
                        color: Color.fromARGB(255, 238, 238, 238),
                        shape: CircleBorder()),
                    height: 160,
                    width: 160,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    child: const Image(
                      alignment: Alignment.center,
                      image: AssetImage("assets/logo-transparent.png"),
                    ),
                  ),
                )
              ])),
    );
  }
}
