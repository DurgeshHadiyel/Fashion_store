import 'package:fashion_store/cart_page.dart';
import 'package:fashion_store/data.dart';
import 'package:fashion_store/data/api.dart';
import 'package:fashion_store/data/api_service.dart';
import 'package:fashion_store/detail_page.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  int currentItem = 0;
  bool isRefresh = false;
  final ApiService api = ApiService();
  List<Map<dynamic, dynamic>> _types = [];

  bool loader = true;

  @override
  void initState() {
    print(
        "============================= Init Called ==================================");
    // TODO: implement initState
    super.initState();
    refreshData();
  }

  void refreshData() {
    print(
        "======================== Refresh Data Page ==================================");
    _types = GetData().favoriteItem();
    currentItem = 0;
    loader = true;
  }

  Future<List<Data>> loadList() async => await api.favoriteItem();

  Widget getCard(int i) {
    var currentItem = i;
    return Container(
        // height: 500,
        padding: const EdgeInsets.all(5),
        child: InkWell(
            borderRadius: BorderRadius.circular(30),
            onTap: () async {
              isRefresh = await Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          DetailPage(types: _types[i]["img"]))) ??
                  false;
              // isRefresh = isRefresh==null?false:true;

              if (isRefresh) {
                print("refresh : $isRefresh");
                setState(() {
                  refreshData();
                });
              }
            },
            child: Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                  side: BorderSide(color: Colors.black.withOpacity(0.05)),
                ),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AspectRatio(
                        aspectRatio: 5 / 4,
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Image.asset(
                            _types[i]["img"],
                            width: 75,
                            height: 100,
                            // fit: BoxFit.
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 25,
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            _types[currentItem]["title"],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 23,
                            ),
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "${_types[i].entries}, Price",
                          style:
                              const TextStyle(fontSize: 20, color: Colors.grey),
                          softWrap: true,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "\$${_types[i]["price"]}",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 27,
                                fontFamily: "Gilroy"),
                          ),
                          SizedBox(
                            width: 45,
                            height: 45,
                            child: ElevatedButton(
                              onPressed: () async {
                                api.addRemoveFavroite(_types[i]);
                                setState(() {
                                  refreshData();
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green[400],
                                textStyle: const TextStyle(
                                  fontSize: 25,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ), // <-- Radius
                              ),
                              child: const Text("+"),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ))));
  }

  Widget screenReturn() {
    if (_types.isEmpty) {
      return const Center(
        child: Text(
          'Favorite Item is Empty',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      );
    } else {
      return Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: const Center(
              child: Text(
                "Favorite Item",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: loader ? loadList() : null,
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.waiting &&
                    snapshot.hasData) {
                  _types = snapshot.data!.cast<Map>();

                  loader = false;

                  if (_types.isEmpty) {
                    return const Center(
                        child: Text(
                      'Favorite Item is Empty',
                      style:
                          TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                    ));
                  } else {
                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, childAspectRatio: 3 / 5),
                      itemBuilder: (context, index) => getCard(index),
                      itemCount: _types.length,
                    );
                  }
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: screenReturn(),
      ),
    );
  }
}
