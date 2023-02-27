import 'dart:convert';
import 'package:http/http.dart';
import 'api.dart';

class ApiService {
  final String apiUrl =
      "https://63f472bb3f99f5855dafa665.mockapi.io/Data";

  Future<List<Data>> filterSearch({String? byItem, int? limit}) async {
    print("Filter Called : $byItem");
    Response res = await get(apiUrl as Uri);
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<Data> data =
          body.map((dynamic types) => Data.fromJson(types)).toList();
      data = data.where((Data types) => types.types == byItem).toList();
      return data;
    } else {
      return throw "Failed to load data list";
    }
  }

  Future<List<Data>> getData() async {
    Response res = await get(apiUrl as Uri);
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<Data> data =
          body.map((dynamic types) => Data.fromJson(types)).toList();
      return data;
    } else {
      throw "Failed to load data list";
    }
  }

  Future<Data> getCaseById(id) async {
    Response response = await get('$apiUrl/$id' as Uri);
    if (response.statusCode == 200) {
      return Data.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load a case by Id');
    }
  }

  Future<Data> createCase(Data data) async {
    late Map datamap;
    datamap = {
      'id': data.id,
      'image': data.image,
      'title': data.title,
      'price': data.price,
      'types': data.types,
      'favorite': data.favorite,
      'cart': data.cart,
    };

    final Response response = await post(
      apiUrl as Uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(datamap),
    );
    if (response.statusCode == 200) {
      return Data.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to post data');
    }
  }

  Future<Data> updateData(id, Data data) async {
    Map dataMap = Data.toJson(data);
    // Future<Data> dataMap = getCaseById(id);

    final Response response = await put(
      '$apiUrl/$id' as Uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(dataMap),
    );
    if (response.statusCode == 200) {
      return Data.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update a case');
    }
  }

  Future<void> deleteCase(id) async {
    Response res = await delete('$apiUrl/$id' as Uri);

    if (res.statusCode == 200) {
      print("Case deleted");
    } else {
      throw "Failed to delete a case.";
    }
  }

  Future<List<Data>> favoriteItem() async {
    Response res = await get(apiUrl as Uri);
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<Data> data =
          body.map((dynamic types) => Data.fromJson(types)).toList();
      data = data.where((Data item) => item.favorite == true).toList();
      return data;
    } else {
      return throw "Failed to load data list";
    }
  }

  Future<List<Data>> cartItem() async {
    Response res = await get(apiUrl as Uri);
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<Data> data =
          body.map((dynamic types) => Data.fromJson(types)).toList();
      data = data.where((Data types) => types.cart > 0).toList();
      return data;
    } else {
      return throw "Failed to load data list";
    }
  }

  Future<void> removeCartItem(id) async {
    var data = await getCaseById(id);
    print(data);
    data.cart = 0;
    data = await updateData(id, data);
  }

  Future<bool> addRemoveFavroite(data) async {
    bool flag = data.favorite;
    data.favorite = !flag;
    data = await updateData(data.id, data);
    return !flag;
  }

  Future<Data> addCart(data, count) async {
    data.cart = count;
    data = await updateData(data.id, data);
    return data;
  }
}
