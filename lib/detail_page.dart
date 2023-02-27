import 'dart:convert';

import 'package:fashion_store/data.dart';
import 'package:fashion_store/data/api.dart';
import 'package:fashion_store/data/api_service.dart';
import 'package:fashion_store/explore_page.dart';
import 'package:fashion_store/favorite_page.dart';
import 'package:fashion_store/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'data.dart';


// ignore: must_be_immutable
class DetailPage extends StatefulWidget {
  Map<dynamic, dynamic> types;
  int? index;

  DetailPage({required this.types, this.index, super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final ApiService api = ApiService();
  late List<Data> casesList = <Data>[];
  late Map<dynamic, dynamic> types;
  List imagesUrl = [];

  Future<List<Data>> loadList() async => await api.cartItem();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataFromServer();
    types = widget.types;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        width: 75,
        height: 50,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 2),
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
              Icons.favorite,
              color: types['favorite'] == true
                  ? Colors.red.shade900
                  : Colors.white,
              size: 26,
            ),
            onPressed: () {
              setState(
                () {
                  types['favorite'] = api.addRemoveFavroite(types);
                },
              );
            },
          ),
          onPressed: () {},
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
      body: FutureBuilder<http.Response>(
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data!);
            return Column(
              children: [
                Padding(
                    padding: EdgeInsets.all(8),
                    child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ExplorePage(
                                        types: types,
                                      )));
                        },
                        child: Card(
                          child: Container(
                            child: Image.network(
                              jsonDecode(snapshot.data!.body.toString())[0][types['image']],
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        )
                        // GridView.builder(
                        //   gridDelegate:
                        //       SliverGridDelegateWithFixedCrossAxisCount(
                        //           crossAxisCount: 2),
                        //   itemCount: imagesUrl.length,
                        //   itemBuilder: (BuildContext context, int index) {
                        //     return Image.network(
                        //       imagesUrl[index],
                        //       fit: BoxFit.cover,
                        //     );
                        //   },
                        // )
                        ))
              ],
            );
          } else {
            return Center(
              child: CircularProgressIndicator(
                  color: Colors.blue, backgroundColor: Colors.grey),
            );
          }
        },
        future: getDataFromServer(),
      ),
    );
  }

  Future<http.Response> getDataFromServer() async {
    var response = await http
        .get(Uri.parse("https://63f472bb3f99f5855dafa665.mockapi.io/Data"));
    var getData = jsonDecode(response.body);

    setState(() {
      data = getData;
      for(var element in getData){
        imagesUrl.add(element['Uri']);
      }
    });
    return response;
  }

}
