class SearchModel {
  bool? status;
  Data? data;
SearchModel.fromJson(Map<String, dynamic> json) {

    status = json['status'];
    data = json['data'] != null ?Data.fromJson(json['data']) : null;
  }


}

class Data {
  int? currentPage;
  List<Product>? data;


  Data.fromJson(Map<String, dynamic> json) {

    currentPage = json['current_page'];

    if (json['data'] != null) {
      data = <Product>[];
      json['data'].forEach((v) {
        data!.add(Product.fromJson(v));
      });
    }

  }


}


class Product {
  int? id;
  dynamic? price;
  String? image;
  String? name;
  String? description;
  bool? in_favorites;

  Product.fromJson(Map<String, dynamic> json) {

    id = json['id'];

    price = json['price'];

    image = json['image'];

    name = json['name'];

    description = json['description'];

    in_favorites=json['in_favorites'];

  }


}
