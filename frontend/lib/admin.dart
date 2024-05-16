import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AdminPanel extends StatefulWidget {
  @override
  AdminPanelState createState() => AdminPanelState();
}

class AdminPanelState extends State<AdminPanel> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _name = TextEditingController();

  bool _emailValidate = false;
  bool _nameValidate = false;

  Future<void> addUser() async {
    final resp = await http.post(Uri.parse(
        'http://192.168.133.13:3001/auth/${_email.text}/${_name.text}/123e456y'));
    if (resp.statusCode == 200) {
      debugPrint(resp.body);
    } else {
      throw Exception('User already exists');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        'Add User',
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
                                  hintText: 'email@gmail.com',
                                  border: InputBorder.none,
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
                                    child:
                                        const Icon(Icons.email, color: Colors.white),
                                  ),
                                  contentPadding:
                                      const EdgeInsets.symmetric(horizontal: 5),
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
                                controller: _name,
                                textAlignVertical: TextAlignVertical.center,
                                decoration: InputDecoration(
                                    hintText: 'User name',
                                    border: InputBorder.none,
                                    alignLabelWithHint: true,
                                    errorText:
                                        _nameValidate ? "Required Feild" : null,
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
                                      child: const Icon(Icons.person,
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
                                  _nameValidate = _name.text.isEmpty;
                                  if (!_emailValidate && !_nameValidate) {
                                    addUser();
                                  }
                                });
                              },
                              style: TextButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 113, 212, 204),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30.0, vertical: 12.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text(
                                'Adde User',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 100,
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
