import 'package:fashion_store/cart_page.dart';
import 'package:fashion_store/data.dart';
import 'package:fashion_store/detail_page.dart';
import 'package:fashion_store/favorite_page.dart';
import 'package:fashion_store/home_page.dart';
import 'package:fashion_store/search_page.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';


var tabBar = ['Top', 'Men', 'Women', 'Kids'];
List<IconData> listOfIcons = [
  Icons.home_filled,
  Icons.search,
  Icons.shopping_cart,
  Icons.person,
];

List<Widget> widgets =[
  HomPage(),
  SearchPage(),
  CartPage(),
  FavoritePage()
];

class FirstScreen extends StatefulWidget {
  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  var currentIndex2 = 0;


  @override
  Widget build(BuildContext context) {
    double displayWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: widgets[currentIndex2],
      bottomNavigationBar: Container(
        margin: EdgeInsets.all(displayWidth * .05),
        height: displayWidth * .144,
        decoration: BoxDecoration(
            color: Colors.black,
            boxShadow: [
              BoxShadow(
                color: Colors.white,
                blurRadius: 30,
                offset: Offset(0, 10),
              )
            ],
            borderRadius: BorderRadius.circular(50)),
        child: ListView.builder(
          itemCount: 4,
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: displayWidth * .02),
          itemBuilder: (context, index) => InkWell(
            onTap: () {
              setState(
                () {
                  currentIndex2 = index;
                  HapticFeedback.lightImpact();
                },
              );
            },
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,

            child: Center(
              child: Row(
                children: [
                  Stack(
                    children: [
                      AnimatedContainer(
                        duration: Duration(seconds: 1),
                        curve: Curves.fastLinearToSlowEaseIn,
                        width: index == currentIndex2
                            ? displayWidth * 0.32
                            : displayWidth * 0.18,
                        alignment: Alignment.center,
                        child: AnimatedContainer(
                          duration: Duration(seconds: 1),
                          curve: Curves.fastLinearToSlowEaseIn,
                          height:
                              index == currentIndex2 ? displayWidth * 0.12 : 0,
                          width:
                              index == currentIndex2 ? displayWidth * 0.32 : 0,
                          decoration: BoxDecoration(
                            color: index == currentIndex2
                                ? Colors.deepOrangeAccent
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                      ),
                      AnimatedContainer(
                        duration: Duration(seconds: 1),
                        curve: Curves.fastLinearToSlowEaseIn,
                        width: index == currentIndex2
                            ? displayWidth * 0.31
                            : displayWidth * 0.18,
                        alignment: Alignment.center,
                        child: Stack(
                          children: [
                            Row(
                              children: [
                                AnimatedContainer(
                                  duration: Duration(seconds: 1),
                                  curve: Curves.fastLinearToSlowEaseIn,
                                  width: index == currentIndex2
                                      ? displayWidth * 0.13
                                      : 0,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                AnimatedContainer(
                                  duration: Duration(seconds: 1),
                                  curve: Curves.fastLinearToSlowEaseIn,
                                  width: index == currentIndex2
                                      ? displayWidth * 0.25
                                      : 20,
                                ),
                              ],
                            ),
                            Center(
                              child: Icon(
                                listOfIcons[index],
                                size: displayWidth * 0.090,
                                color: index == currentIndex2
                                    ? Colors.white
                                    : Colors.white38,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
