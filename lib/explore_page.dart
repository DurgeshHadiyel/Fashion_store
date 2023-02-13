import 'package:fashion_store/cart_page.dart';
import 'package:fashion_store/data.dart';
import 'package:flutter/material.dart';

var tabBar = ['XS', 'S', 'M', 'L', 'XL', 'XXL', 'XXXL'];

class ExplorePage extends StatefulWidget {
  Map<dynamic, dynamic> types;
  int? index;

  ExplorePage({Key? key, required this.types, this.index}) : super(key: key);

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  var currentIndex = 0;
  List<Map<dynamic, dynamic>> item = [];
  late Map<dynamic, dynamic> types;
  int countCart = 0;
  var data = GetData();

  void initState() {
    // TODO: implement initState
    super.initState();
    types = widget.types;
    // types = GetData().filterSearch(bytypes: 'top')[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        foregroundColor: Colors.black,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.favorite_border),
          )
        ],
        title: Row(
          children: [
            Text(
              'Product Details',
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.all(20),
                  child: Center(
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      child: Container(
                        width: double.infinity,
                        child: Image.asset(
                          types['img'],
                          fit: BoxFit.cover,
                          height: 400,
                        ),
                        // decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(30))),
                        // margin: EdgeInsets.all(20),
                      ),
                    ),
                  ),
                ),
                Text(
                  types['title'],
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Container(
                  child: Row(
                    children: [
                      Container(
                        child: Icon(
                          Icons.star,
                          color: Colors.deepOrange,
                        ),
                      ),
                      Container(
                        child: Icon(
                          Icons.star,
                          color: Colors.deepOrange,
                        ),
                      ),
                      Container(
                        child: Icon(
                          Icons.star,
                          color: Colors.deepOrange,
                        ),
                      ),
                      Container(
                        child: Icon(
                          Icons.star,
                          color: Colors.deepOrange,
                        ),
                      ),
                      Container(
                        child: Icon(
                          Icons.star_half,
                          color: Colors.deepOrange,
                        ),
                      ),
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
                            item = GetData()
                                .filterSearch(byItem: tabBar[currentIndex]);
                            // print(item);
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.all(3),
                          width: 80,
                          decoration: BoxDecoration(
                              color: currentIndex == index
                                  ? Colors.black
                                  : Colors.white,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(15),
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
                Text(
                  'Description',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                    'Casual shirts have less rigid collars – such as the button-down. They are made from similar fabrics, however they typically come in a wider variety of textures and weaves such as Oxford or chambray. While formal shirts are generally quite fitted and have long tails, casual shirts are shorter and cut to give a little more room.'),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(17),
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100), color: Colors.black),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 45,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: () {
                      if (countCart > 0) countCart -= 1;
                      setState(() {});
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      side: BorderSide(
                          color: countCart >= 1 ? Colors.black : Colors.grey),
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(30)), // <-- Radius
                    ),
                    child: Center(
                      child: Text(
                        "-",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: (countCart >= 1 ? Colors.green : Colors.grey),
                          fontSize: 25,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 45,
                  height: 45,
                  child: Center(
                    child: Text(
                      "$countCart",
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(
                  width: 45,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: () {
                      if (countCart >= 0) countCart += 1;
                      setState(() {});
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      elevation: 10,
                      // side: const BorderSide(color: Colors.green),
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(30)), // <-- Radius
                    ),
                    child: const Text(
                      "+",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                InkWell(
                  onTap: () {
                    GetData().addCart(types, countCart);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => CartPage()));
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      color: Colors.deepOrange,
                    ),
                    child: Text(
                      'Add to Cart',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
