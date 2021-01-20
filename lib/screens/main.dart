import 'package:a_knitting_app/screens/shop.dart';
import 'package:a_knitting_app/screens/shoppage.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:toast/toast.dart';
import 'package:a_knitting_app/user.dart';
import 'package:a_knitting_app/screens/knitdetail.dart';


class MainScreen extends StatefulWidget {
  final User user;

  const MainScreen({Key key, this.user}) : super(key: key);
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  GlobalKey<RefreshIndicatorState> refreshKey;


  List shopList;
  double screenHeight, screenWidth;
  String _titlecenter = "Shop Loading....";
  var locList = {"Puchong", "Petaling Jaya", "Subang"};
  var ratingList = {"Highest", "Lowest"};
  bool _visible = false;
  String selectedLoc = "Puchong";
  String selectedRating = "Highest";

  @override
  void initState() {
    super.initState();
    _loadShop(selectedLoc, selectedRating);
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Lets Shop'),
      ),
      body: Column(
        children: <Widget>[
          shopList == null
              ? Flexible(
                  child: Container(
                      child: Center(
                )))
              : Flexible(
                  child: GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: (screenWidth / screenHeight) / 0.8,
                  children: List.generate(shopList.length, (index) {
                    return Padding(
                        padding: EdgeInsets.all(1),
                        child: Card(
                            child: InkWell(
                          onTap: () => _loadShopDetail(index),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Container(
                                    height: screenHeight / 3.8,
                                    width: screenWidth / 1.2,
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          "http://itprojectoverload.com/knittingstuff/images/shop/${shopList[index]['shopimage']}.png",
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
                                  shopList[index]['shopname'],
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(shopList[index]['shoplocation']),
                                Text(shopList[index]['shopphone']),
                              ],
                            ),
                          ),
                        )));
                  }),
                ))
        ],
      ),
     
    );}
          
            void _loadShop(String loc, String rat) {
              http.post("http://itprojectoverload.com/knittingstuff/php/load_shop.php",
                  body: {
                    "location": loc,
                    "rating": rat,
                  }).then((res) {
                print(res.body);
                if (res.body == "nodata") {
                  shopList = null;
                  setState(() {
                    _titlecenter = "No Shop Found";
                  });
                } else {
                  setState(() {
                    var jsondata = json.decode(res.body);
                    shopList = jsondata["shop"];
                  });
                }
              }).catchError((err) {
                print(err);
              });
            }
          
            _loadShopDetail(int index) async {
              ProgressDialog pr = new ProgressDialog(context,
                  type: ProgressDialogType.Normal, isDismissible: false);
              pr.style(message: "Loading...");
              await pr.show();
              print(shopList[index]['shopname']);
              Shop shop = new Shop(
                  shopid: shopList[index]['shopid'],
                  shopname: shopList[index]['shopname'],
                  shoplocation: shopList[index]['shopphone'],
                  shopphone: shopList[index]['shoplocation]'],
                  shopimage: shopList[index]['shopimage'],
                  shoprating: shopList[index]['shoptrating']);
          
              await pr.hide();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => ShopScreenDetails(
                            shop: shop,
                            user: widget.user,
                          )));
            }
          
}
