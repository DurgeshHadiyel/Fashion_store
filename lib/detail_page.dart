import 'package:fashion_store/data.dart';
import 'package:fashion_store/explore_page.dart';
import 'package:fashion_store/favorite_page.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DetailPage extends StatefulWidget {
  Map<dynamic, dynamic> types;
  int? index;

  DetailPage({Key? key, required this.types, this.index}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late Map<dynamic, dynamic> types;
  int countCart = 0;
  var data = GetData();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    types = widget.types;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        // foregroundColor: Colors.red,
        backgroundColor: Colors.orange,
        label: Container(
          child: IconButton(
            icon: Icon(
              Icons.favorite_border,
              color: types['favorite'] == true ? Colors.red : Colors.white,
              size: 26,
            ),
            onPressed: () {
              setState(() {
                types['favorite'] = data.addRemoveFavroite(types);
              });
            },
          ),
          // margin: EdgeInsets.all(20),
        ),
        onPressed: () {
          // Navigator.push(context, MaterialPageRoute(builder: (context) => FavoritePage(),));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,
      body: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ExplorePage(
                        types: types,
                      )));
        },
        child: Card(
          elevation: 0,
          child: Stack(
              children: [
            Container(

              child: Image.asset(
                types['img'],
                fit: BoxFit.fitWidth,
              ),
            ),
          ]),
          //
          //
          // Center(
          //   child: Container(
          //     child: Image.asset(types['img'],fit: BoxFit.fitWidth,),
          //   ),
          // ),
        ),
      ),
    );
  }
}
