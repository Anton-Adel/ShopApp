class FavouriteModel{
  bool? statue;
  String? message;
  FavouriteModel.fromjson(Map<String,dynamic> json){
    statue=json['status'];
    message=json['message'];

  }
}