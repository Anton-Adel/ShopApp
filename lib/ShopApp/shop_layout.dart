
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../shared/components/component.dart';
import '../shop_app_modules/SearchScreen/Search.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class ShopLayout extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit=ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('7agatk'),
            actions: [
              IconButton(onPressed: (){
                navigate(context, SearchScreen());
              }, icon: Icon(Icons.search))
            ],
          ),
          body: cubit.ShopScreens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index)
            {
              cubit.ChangeBottomNavBar(index);
            },
            currentIndex: cubit.currentIndex,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(icon: Icon(Icons.apps),
                label: 'Categories',
              ),
              BottomNavigationBarItem(icon: Icon(Icons.favorite_border),
                label: 'Favourites',
              ),
              BottomNavigationBarItem(icon: Icon(Icons.settings),
                label: 'Setting',
              ),
            ],
          ),

        );

      },

    );
  }
}
