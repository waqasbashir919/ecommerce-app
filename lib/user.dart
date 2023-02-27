import 'package:flutter/material.dart';

class UserDetails extends StatelessWidget {
  
  final String name;
  final String email;
  final String imgURL;
  const UserDetails(
      {Key? key, required this.name, required this.email, required this.imgURL})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(name),
          centerTitle: true,
        ),
        body: Container(
          child: Column(children: [
            Image(
              image: AssetImage(imgURL),
              // height: MediaQuery.of(context).size.height,
              fit: BoxFit.cover,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Your Email: $email",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
            ),
          ]),
        ));
  }
}
