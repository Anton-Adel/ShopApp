class CategoryModel{
  bool? status;
  CategoryData? data;
  CategoryModel.fromjson(Map<String,dynamic> json){
    status=json['status'];
    data= CategoryData.fromjson(json['data']);
  }

}

class CategoryData{

  int? current_page;
  List<Data_Model> data=[];

  CategoryData.fromjson(Map<String,dynamic> json){
    current_page=json['current_page'];
    json['data'].forEach((element){
      data.add(Data_Model.fromjson(element));
    });


  }

}


class Data_Model{
  int? id;
  String? name;
  String? image;
  Data_Model.fromjson(Map<String,dynamic> json){
    id=json['id'];
    name=json['name'];
    image=json['image'];

  }

}