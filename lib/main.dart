
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';
import 'package:shop_app/ShopApp/cubit/states.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/cashHelper.dart';
import 'package:shop_app/shared/network/remote/shop_dio_helper.dart';

import 'ShopApp/cubit/cubit.dart';
import 'ShopApp/shop_layout.dart';
// hi
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();


  ShopDioHelper.init();
  await CashHelper.init();
  Widget widget_;
  bool? isdark =CashHelper.getBoolean("isDark");
  // bool? onboarding=CashHelper.getData('onboarding');
  //token=CashHelper.getData('token');
  uId=CashHelper.getData('uId');
  // print(onboarding);

  // print(token);
  // if(onboarding!=null)
  //   {
  //     if(token!=null) widget_=ShopLayout();
  //     else
  //       widget_=Shop_Login_Screen();
  //   }
  // else
  //   widget_=OnboardingScreen();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build (BuildContext context) {
    return MultiBlocProvider(
      providers: [

        BlocProvider( create: (BuildContext context)=>ShopCubit()..GetHomeData()..GetCategories()..GetUserModel()..GetFavourites()),
      ],

      child: BlocConsumer<ShopCubit,ShopStates>(
        listener: (context,state){},
        builder: (context,state){
          return  MaterialApp( home:ShopLayout(),
            debugShowCheckedModeBanner: false,

          );
        },

      ),
    );
  }
}