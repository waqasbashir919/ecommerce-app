import 'package:ecommerce_app/services/auth.dart';
import 'package:flutter/material.dart';

class RegistrationPage extends StatefulWidget {
  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

final formKey = GlobalKey<FormState>();
String p =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

RegExp regExp = new RegExp(p);
String? username;
String? email;
String? phone;
String? password;
String? confirmPassword;
String error = '';
bool isHideText = true;

class _RegistrationPageState extends State<RegistrationPage> {
  final AuthService auth = AuthService();

  void validatation() async {
    if (formKey.currentState!.validate()) {
      dynamic result =
          await auth.registerWithEmailandPassword(email!, password!);

      if (result == null) {
        setState(() {
          error = "Email already in use try another one";
        });
      }
    } else {
      print("Something is incorrect");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.grey[900],
          body: SingleChildScrollView(
            reverse: true,
            child: Form(
              key: formKey,
              child: Container(
                child: Column(
                  children: [
                    Container(
                      height: 100,
                      width: double.infinity,
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        "Registration",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w800,
                            color: Colors.orangeAccent),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                              validator: (value) {
                                if (value!.length < 6) {
                                  return "Username is too short";
                                } else if (value == "") {
                                  return "Please fill the Username";
                                } else {
                                  return null;
                                }
                              },
                              onChanged: (val) {
                                setState(() {
                                  username = val;
                                });
                              },
                              style: TextStyle(color: Colors.green),
                              decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.person,
                                    color: Colors.orangeAccent,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.orangeAccent)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.green)),
                                  hintText: 'Username',
                                  hintStyle:
                                      TextStyle(color: Colors.orangeAccent),
                                  border: OutlineInputBorder())),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                              validator: (value) {
                                if (value == "") {
                                  return "Please fill the Username";
                                } else if (!regExp.hasMatch(value!)) {
                                  return "Invalid Email";
                                } else {
                                  return null;
                                }
                              },
                              onChanged: (val) {
                                setState(() {
                                  email = val;
                                });
                              },
                              style: TextStyle(color: Colors.green),
                              decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.email,
                                    color: Colors.orangeAccent,
                                  ),
                                  hintText: 'Email',
                                  hintStyle:
                                      TextStyle(color: Colors.orangeAccent),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.orangeAccent)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.green)),
                                  border: OutlineInputBorder())),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value == "") {
                                  return "Please fill the Phone Number";
                                } else if (value!.length < 11) {
                                  return "Phone number must be 11 digit";
                                } else {
                                  return null;
                                }
                              },
                              onChanged: (val) {
                                setState(() {
                                  phone = val;
                                });
                              },
                              style: TextStyle(color: Colors.green),
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.phone,
                                  color: Colors.orangeAccent,
                                ),
                                hintText: 'Phone',
                                hintStyle:
                                    TextStyle(color: Colors.orangeAccent),
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.orangeAccent)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.green)),
                                border: OutlineInputBorder(),
                              )),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                              obscureText: isHideText,
                              onChanged: (val) {
                                setState(() {
                                  password = val;
                                });
                              },
                              validator: (value) {
                                if (value == "") {
                                  return "Please fill the password";
                                } else if (value!.length < 8) {
                                  return "Password is too short";
                                } else {
                                  return null;
                                }
                              },
                              style: TextStyle(color: Colors.green),
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: Colors.orangeAccent,
                                ),
                                hintText: 'Password',
                                suffixIcon: InkWell(
                                  onTap: () {
                                    setState(() {
                                      isHideText = !isHideText;
                                    });
                                    FocusScope.of(context).unfocus();
                                  },
                                  child: Icon(
                                      isHideText == true
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Colors.orangeAccent),
                                ),
                                hintStyle:
                                    TextStyle(color: Colors.orangeAccent),
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.orangeAccent)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.green)),
                                border: OutlineInputBorder(),
                              )),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                              obscureText: isHideText,
                              onChanged: (val) {
                                setState(() {
                                  confirmPassword = val;
                                });
                              },
                              validator: (value) {
                                if (value == "") {
                                  return "Please fill the confirm password";
                                } else if (confirmPassword != password) {
                                  return "Password doesn't match";
                                } else {
                                  return null;
                                }
                              },
                              style: TextStyle(color: Colors.green),
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: Colors.orangeAccent,
                                ),
                                hintText: 'Confirm Password',
                                suffixIcon: InkWell(
                                  onTap: () {
                                    setState(() {
                                      isHideText = !isHideText;
                                    });
                                    FocusScope.of(context).unfocus();
                                  },
                                  child: Icon(
                                      isHideText == true
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Colors.orangeAccent),
                                ),
                                hintStyle:
                                    TextStyle(color: Colors.orangeAccent),
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.orangeAccent)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.green)),
                                border: OutlineInputBorder(),
                              )),
                          SizedBox(
                            height: 20,
                          ),
                          Row(children: [
                            Text(
                              "Already have an account ?",
                              style: TextStyle(color: Colors.orangeAccent),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Text("Login",
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.w800)),
                            ),
                          ]),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () async {
                                validatation();
                              },
                              child: Text("Register"),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: Text(
                              error,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
