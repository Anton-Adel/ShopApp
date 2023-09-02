
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shop_app_modules/onboardingscreen/Login/cubit/shop_states.dart';

import '../../../../shared/network/Endpoint.dart';
import '../../../../shared/network/remote/shop_dio_helper.dart';
import '../../../../shop_app_models/shop_login_model.dart';

class ShopAppCubit extends Cubit<ShopAppStates>
{
  ShopLoginModel? UserModel;
  ShopAppCubit():super(ShopAppInitialState());
  static ShopAppCubit get(context)=> BlocProvider.of(context);

  void UserLogin(
  {
  required String e_mail,
    required String password
}
      ){
    emit(ShopAppLoadinglState());
    ShopDioHelper.postData(url: LOGIN, Data: {
      'email': e_mail,
      'password': password,
    },).then((value){
      print(value.data);

      UserModel=ShopLoginModel.fromJson(value.data);
      print(UserModel!.message);

      emit(ShopAppSuccessState(UserModel));
    }).catchError((error){
      emit(ShopAppErrorState(error: error.toString()));
    });
  }
  bool password=true;
  void visible(){
    password=!password;
    emit(ShopApppasswordVisiability());
  }
}