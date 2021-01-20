import 'package:flutter/material.dart';
import 'package:a_knitting_app/helper/postcard.dart';
import 'package:a_knitting_app/helper/demo_values.dart';



class CommunityScreen extends StatefulWidget {
  const CommunityScreen({Key key, Function() onTap}) : super(key: key);

  @override
  _CommunityScreenState createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Knitstagram"),
      ),
      body: ListView.builder(
        itemCount: DemoValues.posts.length,
        itemBuilder: (BuildContext context, int index) {
          return PostCard(postData: DemoValues.posts[index]);
        },
      ),
    );
  }
}
