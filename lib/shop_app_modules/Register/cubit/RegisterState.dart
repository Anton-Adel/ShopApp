
import '../../../shop_app_models/shop_login_model.dart';

abstract class ShopRegisterStates{}

class ShopRegisterInitialState extends ShopRegisterStates{}

class ShopRegisterLoadinglState extends ShopRegisterStates{}
class ShopRegisterSuccessState extends ShopRegisterStates{
  ShopLoginModel? UserModel;
  ShopRegisterSuccessState( this.UserModel);

}
class ShopRegisterErrorState extends ShopRegisterStates{
  final String error;
  ShopRegisterErrorState (
  {
    required this.error
}
      );
}

class ShopRegisterpasswordVisiability extends ShopRegisterStates{}

