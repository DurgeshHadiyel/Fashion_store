import 'package:carousel_slider/carousel_slider.dart';
import 'package:fashion_store/data.dart';
import 'package:fashion_store/detail_page.dart';
import 'package:flutter/material.dart';

var tabBar = ['Top', 'Men', 'Women', 'Kids'];
List<IconData> listOfIcons = [
  Icons.home_filled,
  Icons.search,
  Icons.shopping_cart,
  Icons.favorite_outline_sharp,
];

class HomPage extends StatefulWidget {
  const HomPage({Key? key}) : super(key: key);

  @override
  State<HomPage> createState() => _HomPageState();
}

class _HomPageState extends State<HomPage> {
  var currentIndex = 0;
  List<Map<dynamic, dynamic>> item2 = [];

  @override
  void initState() {
    // TODO: implement initState
    currentIndex = 0;
    super.initState();
    item2 = GetData().filterSearch(byItem: tabBar[currentIndex].toLowerCase());
  }

  Widget getCard() {
    return Container(
      child: Card(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.red,
              ),
            ),
            FloatingActionButton(
              child: Icon(Icons.favorite_border),
              onPressed: () {},
            ),
          ],
        ),

      ),
    );
  }

  List<Widget> l = [
    Container(
      child: Card(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.red,
              ),
            )
          ],
        ),
      ),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CircleAvatar(
                    backgroundImage: AssetImage("assets/images/myimage.jpg"),
                    radius: 25,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Hello, Durgesh!",
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: "f8",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(child: Container()),
                  InkWell(
                    child: const Icon(
                      Icons.search,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 200,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CarouselSlider(
                    items: [
                      Container(
                        margin: EdgeInsets.all(6.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          image: DecorationImage(
                            image: AssetImage("assets/images/cloth2.jpg"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(6.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          image: DecorationImage(
                            image: AssetImage("assets/images/cloth3.jpg"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(6.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          image: DecorationImage(
                            image: AssetImage("assets/images/cloth4.webp"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                    options: CarouselOptions(
                      height: 180.0,
                      enlargeCenterPage: true,
                      autoPlay: true,
                      aspectRatio: 16 / 9,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enableInfiniteScroll: true,
                      autoPlayAnimationDuration: Duration(milliseconds: 200),
                      viewportFraction: 0.9,
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: 50,
              width: double.infinity,
              // margin: EdgeInsets.only(left: 80),
              child: ListView.builder(
                itemCount: tabBar.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        currentIndex = index;
                        item2 = GetData().filterSearch(
                            byItem: tabBar[currentIndex].toLowerCase());
                        // print(item);
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.all(3),
                      width: 120,
                      decoration: BoxDecoration(
                          color: currentIndex == index
                              ? Colors.black
                              : Colors.white,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(50),
                          ),
                          border: Border.all(color: Colors.black12)),
                      child: Center(
                        child: Text(
                          tabBar[index],
                          style: TextStyle(
                              fontSize: 20,
                              color: currentIndex == index
                                  ? Colors.white
                                  : Colors.black),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              height: 500,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemCount: 6,
                itemBuilder: (context, i) => DetailPage(
                  types: item2[i],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
