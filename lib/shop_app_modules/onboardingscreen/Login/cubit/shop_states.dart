

import '../../../../shop_app_models/shop_login_model.dart';

abstract class ShopAppStates{}

class ShopAppInitialState extends ShopAppStates{}

class ShopAppLoadinglState extends ShopAppStates{}
class ShopAppSuccessState extends ShopAppStates{
  ShopLoginModel? UserModel;
  ShopAppSuccessState( this.UserModel);

}
class ShopAppErrorState extends ShopAppStates{
  final String error;
  ShopAppErrorState (
  {
    required this.error
}
      );
}

class ShopApppasswordVisiability extends ShopAppStates{}

