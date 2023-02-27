import 'package:ecommerce_app/auth/registration_page.dart';
import 'package:ecommerce_app/home.dart';
import 'package:ecommerce_app/services/auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

final GlobalKey<FormState> formKey = GlobalKey<FormState>();
String p =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

RegExp regExp = new RegExp(p);
String? email;
String? password;
String error = '';
bool isHideText = true;

class _LoginPageState extends State<LoginPage> {
  final AuthService auth = AuthService();

  void validatation() async {
    final FormState form = formKey.currentState!;
    if (formKey.currentState!.validate()) {
      dynamic result = await auth.signInWithEmailandPassword(email!, password!);
      if (result == null) {
        setState(() {
          error = "Email does not exist";
        });
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      }
    } else {
      print("Something is incorrect");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          reverse: true,
          child: Form(
            key: formKey,
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/login.png'),
                      fit: BoxFit.cover)),
              child: Column(
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    alignment: Alignment.bottomCenter,
                    height: 150,
                    child: Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    height: 320,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextFormField(
                          onChanged: (val) {
                            setState(() {
                              email = val;
                            });
                          },
                          validator: (value) {
                            if (value == "") {
                              return "Please fill the email box";
                            } else if (!regExp.hasMatch(value!)) {
                              return "Invalid email format";
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.email),
                              hintText: "Email",
                              border: OutlineInputBorder(),
                              hintStyle: TextStyle(color: Colors.black)),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          obscureText: isHideText,
                          validator: (value) {
                            if (value == "") {
                              return "Please type password";
                            } else {
                              return null;
                            }
                          },
                          onChanged: (val) {
                            setState(() {
                              password = val;
                            });
                          },
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.lock),
                              hintText: "Password",
                              hintStyle: TextStyle(color: Colors.black),
                              border: OutlineInputBorder(),
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isHideText = !isHideText;
                                  });
                                },
                                child: Icon(
                                  isHideText == true
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.black,
                                ),
                              )),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: double.infinity,
                          child: ElevatedButton(
                            child: Text("Login"),
                            onPressed: () async {
                              validatation();
                            },
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          child: ElevatedButton(
                            child: Text("Guest mode"),
                            onPressed: () async {
                              dynamic result = await auth.signInAnon();
                              if (result == null) {
                                print("Error sign in");
                              } else {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomePage()));
                                print(result.uid);
                              }
                            },
                          ),
                        ),
                        Row(
                          children: [
                            Text("Don't have an account?"),
                            SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, '/registration');
                              },
                              child: Text(
                                "Create an account",
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.w800),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: Text(
                            error,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w800),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
