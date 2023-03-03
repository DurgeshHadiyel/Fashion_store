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
      floatingActionButton: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 4),
          // shape: BoxShape.circle,
          borderRadius: BorderRadius.circular(55),
          boxShadow: [
            BoxShadow(
              color: Colors.white,
              spreadRadius: 4.9,
            )
          ],
        ),
        child: FloatingActionButton.extended(
          // foregroundColor: Colors.red,
          backgroundColor: Colors.orange.shade500,
          extendedPadding: EdgeInsets.symmetric(horizontal: 15),
          label: IconButton(
            icon: Icon(
              Icons.favorite_border,
              color: types['favorite'] == true
                  ? Colors.red.shade900
                  : Colors.white,
              size: 26,
            ),
            onPressed: () {
              setState(
                () {
                  types['favorite'] = data.addRemoveFavroite(types);
                },
              );
            },
          ),
          onPressed: () {},
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
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
          child: Stack(children: [
            Center(
              child: Container(
                child: Image.asset(
                  types['img'],
                  fit: BoxFit.fitWidth,
                ),
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