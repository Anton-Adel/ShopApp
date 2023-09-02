import 'package:dio/dio.dart';

class ShopDioHelper{
  static Dio? dio;
  static init(){
    dio=Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/' ,
        receiveDataWhenStatusError: true,

      ),

    );
    print("done");
  }

  static Future<Response> getData( {required String url,Map<String, dynamic>? query,String lang='en',
    String? token,}) async{
    dio!.options.headers={
      'Content-Type':'application/json',
      'lang':lang,
      'Authorization':token
    };
    return await dio!.get(url,queryParameters: query,);
  }

  static Future<Response> postData (
  {
  required String url,
    Map <String,dynamic> ? query,
    required  Map <String,dynamic> ? Data,
    String lang='en',
    String? Token,

  }
  ) async
  {
    dio!.options.headers={
      'Content-Type':'application/json',
      'lang':lang,
      'Authorization':Token
    };
    return await dio!.post(url,queryParameters: query,data:Data);
  }



  static Future<Response> UpdateData (
      {
        required String url,
        Map <String,dynamic> ? query,
        required  Map <String,dynamic> ? Data,
        String lang='en',
        String? Token,

      }
      ) async
  {
    dio!.options.headers={
      'Content-Type':'application/json',
      'lang':lang,
      'Authorization':Token
    };
    return await dio!.put(url,queryParameters: query,data:Data);
  }


}