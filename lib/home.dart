import 'package:ecommerce_app/auth/login_page.dart';

import 'package:ecommerce_app/model/product.dart';
import 'package:ecommerce_app/product_tile.dart';
import 'package:ecommerce_app/services/auth.dart';
import 'package:ecommerce_app/services/remote_services.dart';
import 'package:ecommerce_app/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
  
}

class _HomePageState extends State<HomePage> {
  Post? posts;
  @override
  void initState() {
    super.initState();
    fetchPosts();
  }

  List? productColors;
  var productId,
      productName,
      productDesc,
      productRating,
      productCategory,
      productCompany,
      productFeatured,
      productPrice,
      productImage;

  bool isloaded = false;
  String? textColor;
  fetchPosts() async {
    posts = await RemoteServices.getPosts();
    if (posts != null) {
      setState(() {
        isloaded = true;

        productName = posts!.products.map((e) => e.name).toList();
        productDesc = posts!.products.map((e) => e.description).toList();
        productRating = posts!.products.map((e) => e.averageRating).toList();
        productPrice = posts!.products.map((e) => e.price).toList();
        productCategory = posts!.products.map((e) => e.category).toList();
        productColors = posts!.products.map((e) => e.colors).toList();
        productCompany = posts!.products.map((e) => e.company).toList();
        productFeatured = posts!.products.map((e) => e.featured).toList();
        productId = posts!.products.map((e) => e.productId).toList();
        productImage = posts!.products.map((e) => e.image).toList();
      });
    }
  }

  AuthService authService = AuthService();
  final scaffoldkey = GlobalKey<ScaffoldState>();
  final padding = EdgeInsets.symmetric(horizontal: 20);
  String name = "Waqas";
  String email = "waqasbashir919@gmail.com";
  String imgURL = "assets/waqas.jpeg";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Color.fromARGB(255, 239, 237, 237),
          key: scaffoldkey,
          drawer: Drawer(
            child: Material(
              color: Color.fromARGB(255, 33, 94, 201),
              child: ListView(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  buildHeader(
                      name: name,
                      email: email,
                      imgURL: imgURL,
                      onclicked: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => UserDetails(
                                name: name, email: email, imgURL: imgURL)));
                      }),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    height: 20,
                    color: Colors.white,
                  ),
                  buildMenuItem(
                      text: 'People',
                      icon: Icons.people,
                      onclicked: () => selectedItem(context, 0)),
                  SizedBox(
                    height: 10,
                  ),
                  buildMenuItem(
                      text: 'Favourites',
                      icon: Icons.favorite,
                      onclicked: () => selectedItem(context, 1)),
                  SizedBox(
                    height: 20,
                  ),
                  buildFooter(
                      text: 'Log out',
                      icon: Icons.logout,
                      onclicked: () async {
                        await authService.signOut();
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                      })
                ],
              ),
            ),
          ),
          appBar: AppBar(
            centerTitle: true,
            title: Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                "Shop X",
                style: TextStyle(fontWeight: FontWeight.w800),
              ),
            ),
            titleSpacing: 5,
            actions: [
              Padding(
                padding: EdgeInsets.only(right: 5),
                child: Icon(Icons.notifications),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: isloaded == true
                ? ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: posts != null ? posts!.count : 1,
                    itemBuilder: (context, index) {
                      return Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  alignment: Alignment.topLeft,
                                  child: Text(posts != null
                                      ? 'Product name: ' + productName[index]
                                      : 'Null'),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  alignment: Alignment.topLeft,
                                  child: Text(posts != null
                                      ? 'Price : ' +
                                          productPrice[index].toString()
                                      : 'Null'),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  alignment: Alignment.topLeft,
                                  child: Text(posts != null
                                      ? 'Brand : ' +
                                          productCompany[index].toString()
                                      : 'Null'),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                TextWidget(
                                    productCategory: productCategory,
                                    index: index),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  alignment: Alignment.topLeft,
                                  child: Text('Colors'),
                                ),
                                GridView.builder(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: productColors![index].length,
                                  itemBuilder: ((context, i) => Row(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                textColor =
                                                    productColors![index][i];
                                              });
                                            },
                                            child: CircleAvatar(
                                              backgroundColor: HexColor(
                                                  productColors![index][i]),
                                            ),
                                          )
                                        ],
                                      )),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 6,
                                    childAspectRatio: 1,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  alignment: Alignment.topLeft,
                                  child: Image(
                                    image: NetworkImage(posts != null
                                        ? index != 0
                                            ? productImage[index]
                                            : 'https://i.ytimg.com/vi/lqlekMT-OuA/maxresdefault.jpg'
                                        : 'Null'),
                                    width: MediaQuery.of(context).size.width,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      alignment: Alignment.topLeft,
                                      child: Text(posts != null
                                          ? 'Ratings : ' +
                                              productRating[index].toString()
                                          : 'Null'),
                                    ),
                                    Container(
                                      alignment: Alignment.topLeft,
                                      child: RatingBar.builder(
                                        initialRating: double.parse(
                                            productRating[index].toString()),
                                        minRating: 0,
                                        direction: Axis.horizontal,
                                        itemCount: 5,
                                        itemSize: 30,
                                        ignoreGestures: true,
                                        itemBuilder: (context, _) => Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        onRatingUpdate: (rating) {
                                          print(rating);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    posts != null
                                        ? 'Product Description : \n\n' +
                                            productDesc[index]
                                        : 'Null',
                                    style: TextStyle(
                                        color: HexColor(textColor != null
                                            ? textColor!
                                            : '#000')),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  )
                : Container(
                    height: MediaQuery.of(context).size.height,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
          )),
    );
  }

  Widget buildHeader(
          {required String name,
          required String email,
          required String imgURL,
          required VoidCallback onclicked}) =>
      InkWell(
          onTap: onclicked,
          child: Container(
            padding: EdgeInsets.all(10),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  CircleAvatar(backgroundImage: AssetImage(imgURL)),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(email, style: TextStyle(color: Colors.white)),
                    ],
                  )
                ],
              ),
            ),
          ));

  Widget buildMenuItem(
      {required String text, required IconData icon, VoidCallback? onclicked}) {
    final color = Colors.white;
    final hoverColor = Colors.white70;
    return Container(
      padding: padding,
      child: ListTile(
        leading: Icon(
          icon,
          color: color,
        ),
        title: Text(
          text,
          style: TextStyle(color: color, fontWeight: FontWeight.w800),
        ),
        hoverColor: hoverColor,
        onTap: onclicked,
      ),
    );
  }

  selectedItem(BuildContext context, int i) {
    Navigator.of(context).pop();
    switch (i) {
      case 0:
        print("Clicked on menu 0");
        break;
      case 1:
        print("Clicked on menu 1");
    }
  }

  Widget TextWidget({
    required var productCategory,
    required var index,
  }) {
    return Container(
        alignment: Alignment.topLeft,
        child: Text(posts != null
            ? 'Product Category : ' + productCategory[index]
            : 'Null'));
  }
}

Widget buildFooter(
    {required String text,
    required IconData icon,
    required VoidCallback onclicked}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 35),
    child: ElevatedButton.icon(
      onPressed: onclicked,
      icon: Icon(icon),
      label: Text(text),
      style: ElevatedButton.styleFrom(primary: Colors.black),
    ),
  );
}
