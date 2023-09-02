class HomeModel{
  bool? status;
  DataModel? data;
  HomeModel.fromjson(Map<String,dynamic>json){
    status=json['status'];
    data=DataModel.fromjson(json['data']);

  }
}

class DataModel{

  List<BannerModel> banners=[];
  List<ProductModel> products=[];
  int counter=0;

  DataModel.fromjson(Map<String,dynamic>json){
    json['banners'].forEach((element) {
      print(element.toString());
      banners.add(BannerModel.fromjson(element)) ;
    });
    json['products'].forEach((element) {
      products.add(ProductModel.fromjson(element));

    });
  }
  

}

class BannerModel{

int? id;
String? image;

  BannerModel.fromjson(Map<String,dynamic>json){
    id=json['id'];
    image=json['image'];

  }
}

class ProductModel{

  int? id;
  dynamic? price;
  dynamic? old_price;
  dynamic? discount;
  String? image;
  String? name;
  bool? in_favorites;
  bool? in_cart;

  ProductModel.fromjson(Map<String,dynamic>json){
    id=json['id'];
    price=json['price'];
    old_price=json['old_price'];
    discount=json['discount'];
    image=json['image'];
    name=json['name'];
    in_favorites=json['in_favorites'];
    in_cart=json['in_cart'];

  }

}
