
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/ShopApp/cubit/states.dart';

import '../../shared/components/component.dart';
import '../../shared/components/constants.dart';
import '../../shared/network/Endpoint.dart';
import '../../shared/network/remote/shop_dio_helper.dart';
import '../../shop_app_models/CategoriyModel.dart';
import '../../shop_app_models/FavouriteModel.dart';
import '../../shop_app_models/GetFavouriteModel.dart';
import '../../shop_app_models/home_model.dart';
import '../../shop_app_models/shop_login_model.dart';
import '../../shop_app_modules/CategoriesScreen/Categories.dart';
import '../../shop_app_modules/FavourateScreen/Favourate.dart';
import '../../shop_app_modules/ProductsScreen/Products.dart';
import '../../shop_app_modules/SettingScreen/Setting.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> ShopScreens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavourateScreen(),
    SettingScreen()
  ];

  void ChangeBottomNavBar(int index) {
    currentIndex = index;
    emit(ShopBottomNavBar());
  }

  HomeModel? home_model;
  Map<int, bool> favourite = {};
  void GetHomeData() {
    emit(ShopLoaddingState());
    ShopDioHelper.getData(url: HOME, token: token).then((value) {
      home_model = HomeModel.fromjson(value.data);
      print(home_model!.data!.banners[0].id);
      print(token);
      home_model!.data!.products.forEach((element) {
        favourite.addAll({
          element.id!: element.in_favorites!,
        });
      });
      print(favourite.toString());
      emit(ShopSuccessHomeState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorHomeState());
    });
  }

  CategoryModel? categoryModel;

  void GetCategories() {
    ShopDioHelper.getData(url: CATEGORIES).then((value) {
      categoryModel = CategoryModel.fromjson(value.data);
      emit(ShopSuccessCategoriesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorCategoriesState());
    });
  }

  FavouriteModel? Favourite;

  Favourite_Model? favouriteModel;

  void ChangeFavourite(int id) {
    favourite[id] = !favourite[id]!;
    emit(ShopChangedFavouriteState());
    print(token);
    ShopDioHelper.postData(
            url: FAVOURITE,
            Data: {
              'product_id': id,
            },
            Token: token)
        .then((value) {
      Favourite = FavouriteModel.fromjson(value.data);
      if (Favourite!.statue == false) {
        favourite[id] = !favourite[id]!;
        showTost(Favourite!.message!, TostStatus.ERROR);
      } else {
        favouriteModel = null;
        GetFavourites();
      }

      emit(ShopSuccessChangeFavouriteState());
    }).catchError((error) {
      print('error');
      favourite[id] = !favourite[id]!;
      showTost(Favourite!.message!, TostStatus.ERROR);
      emit(ShopErrorChangeFavouriteState());
    });
  }

  void GetFavourites() {
    emit(ShopSuccessFavouriteLoadingState());
    ShopDioHelper.getData(url: FAVOURITE, token: token).then((value) {
      favouriteModel = Favourite_Model.fromJson(value.data);
      print("Anton");
      print(favouriteModel.toString());
      emit(ShopSuccessFavouriteState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorFavouriteState());
    });
  }

  ShopLoginModel? UserModel;

  void GetUserModel() {
    ShopDioHelper.getData(url: USERMODEL, token: token).then((value) {
      UserModel = ShopLoginModel.fromJson(value.data);
      print(UserModel!.uermodel!.name);
      emit(ShopSuccessUserState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUserState());
    });
  }

  void UpdadteUserModel({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(ShopSuccessUpdateLoadingState());
    ShopDioHelper.UpdateData(
      url: Update_USERMODEL,
      Token: token,
      Data: {
        'name': name,
        'email': email,
        'phone': phone,
      },
    ).then((value) {
      UserModel = ShopLoginModel.fromJson(value.data);
      print(UserModel!.uermodel!.name);
      emit(ShopSuccessUpdateState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUpdateState());
    });
  }
}
