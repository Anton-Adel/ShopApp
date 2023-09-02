class ShopLoginModel
{
  bool? status;
  String? message;
  UserModel? uermodel;
  ShopLoginModel.fromJson(model)
  {

    status=model['status'];
   // print("iam in");
    message=model['message'];
    //print("iam in aaaa");
    uermodel= (model['data'] !=null)? UserModel.fromJson(model['data']) : null;
   // print("login done");
  }


}

class UserModel
{
   int? id;
   String? name;
   String? email;
    String? phone;
   String? image;
   int? points;
   int? credit;
   String? token;

  UserModel.fromJson(model)
  {

    id=model['id'];
    name=model['name'];
    email=model['email'];
    phone=model['phone'];
    image=model['image'];
    points=model['points'];
    credit=model['credit'];
    token=model['token'];
    print("user done");
  }

}