import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:a_knitting_app/knit.dart';
import 'shop.dart';
import 'package:http/http.dart' as http;
import 'package:a_knitting_app/screens/knitscreen.dart';
import 'package:a_knitting_app/user.dart';

class ShopScreenDetails extends StatefulWidget {
  final Shop shop;
  final User user;

  const ShopScreenDetails({Key key, this.shop, this.user}) : super(key: key);


  @override
  _ShopScreenDetailsState createState() => _ShopScreenDetailsState();
}

class _ShopScreenDetailsState extends State<ShopScreenDetails> {
  double screenHeight, screenWidth;
  List stuffList;
  String titlecenter = "Loading Stuff...";
  String type = "Knitting";
  GlobalKey<RefreshIndicatorState> refreshKey;

  @override
  void initState() {
    super.initState();
    _loadFoods(type);
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.shop.shopname),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: Colors.white,
            ),
            onPressed: () {
              //_shoppinCartScreen();
            },
          )
        ],
      ),
      body: Column(children: [
        Container(
            height: screenHeight / 4.8,
            width: screenWidth / 0.3,
            child: CachedNetworkImage(
              imageUrl:
                  "http://itprojectoverload.com/knittingstuff/images/shop/${widget.shop.shopimage}.png",
              fit: BoxFit.cover,
              placeholder: (context, url) => new CircularProgressIndicator(),
              errorWidget: (context, url, error) => new Icon(
                Icons.broken_image,
                size: screenWidth / 2,
              ),
            )),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.checkroom_rounded),
                  iconSize: 32,
                  onPressed: () {
                    setState(() {
                      type = "Knitting";
                      _loadFoods(type);
                    });
                  },
                ),
                Text(
                  "Knitting",
                  style: TextStyle(fontSize: 10),
                )
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.card_giftcard_rounded),
                  iconSize: 32,
                  onPressed: () {
                    setState(() {
                      type = "Doll";
                      _loadFoods(type);
                    });
                  },
                ),
                Text(
                  "Doll",
                  style: TextStyle(fontSize: 10),
                )
              ],
            ),
            Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.phone),
                        iconSize: 32,
                        onPressed: () {
                          setState(() {});
                        },
                      ),
                      Text(
                        "Call",
                        style: TextStyle(fontSize: 10),
                      )
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.map),
                        iconSize: 32,
                        onPressed: () {
                          setState(() {});
                        },
                      ),
                      Text(
                        "Map",
                        style: TextStyle(fontSize: 10),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
        Text("Menu for $type "),
        Divider(
          color: Colors.grey,
        ),
        stuffList == null
            ? Flexible(
                child: Container(
                    child: Center(
                        child: Text(
                titlecenter,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ))))
            : Flexible(
                child: RefreshIndicator(
                    key: refreshKey,
                    color: Colors.red,
                    onRefresh: () async {
                      _loadFoods(type);
                    },
                    child: GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: (screenWidth / screenHeight) / 0.62,
                      children: List.generate(stuffList.length, (index) {
                        return Padding(
                            padding: EdgeInsets.all(2),
                            child: Card(
                                child: InkWell(
                              onTap: () => _loadFoodDetails(index),
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Container(
                                        height: screenHeight / 5,
                                        width: screenWidth / 1.2,
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              "http://itprojectoverload.com/knittingstuff/images/stuff/${stuffList[index]['imgname']}.png",
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) =>
                                              new CircularProgressIndicator(),
                                          errorWidget: (context, url, error) =>
                                              new Icon(
                                            Icons.broken_image,
                                            size: screenWidth / 2,
                                          ),
                                        )),
                                    SizedBox(height: 5),
                                    Text(
                                      stuffList[index]['stuffname'],
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text("RM " +
                                        stuffList[index]['stuffprice'] +
                                        " | Qty:" +
                                        stuffList[index]['stuffqty']),
                                  ],
                                ),
                              ),
                            )));
                      }),
                    )),
              )
      ]),
    );
  }


  Future<void> _loadFoods(String ftype) async {
    ProgressDialog pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false);
    pr.style(message: "Loading...");
    await pr.show();
    http.post("https://itprojectoverload.com/knittingstuff/php/load_stuff.php", body: {
      "shopid": widget.shop.shopid,
      "type": ftype,
    }).then((res) {
      print(res.body);
      if (res.body == "nodata") {
        stuffList = null;
        setState(() {
          titlecenter = "No $type Available";
        });
      } else {
        setState(() {
          var jsondata = json.decode(res.body);
          stuffList = jsondata["stuff"];
        });
      }
    }).catchError((err) {
      print(err);
    });
    await pr.hide();
  }

  _loadFoodDetails(int index) {
    Stuff curfood = new Stuff(
        stuffid: stuffList[index]['stuffid'],
        stuffname: stuffList[index]['stuffname'],
        stuffprice: stuffList[index]['stuffprice'],
        stuffqty: stuffList[index]['stuffqty'],
        stuffimg: stuffList[index]['stuffname'],
        stuffcurqty: "1",
        shopid: widget.shop.shopid);

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => FoodScreenDetails(
                  stuff: curfood,
                  user: widget.user,
                )));
  }
}