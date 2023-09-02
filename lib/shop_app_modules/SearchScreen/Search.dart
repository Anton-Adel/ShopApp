
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../ShopApp/cubit/cubit.dart';
import '../../shared/components/component.dart';
import '../../shop_app_models/GetFavouriteModel.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class SearchScreen extends StatelessWidget {

  var searchcontroller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(

      create: (BuildContext context)=>SearchCubit(),
      child: BlocConsumer<SearchCubit,SearchStates>(
        listener: (context,state){

        },
        builder: (context,state){
          return Scaffold(
            appBar: AppBar(
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  if(state is SearchLoadingState)
                    LinearProgressIndicator(),
                  SizedBox(
                    height: 20,
                  ),
                  DefaultTextFeild(controller:searchcontroller ,
                      type: TextInputType.text,
                      label: "Search",
                      prefix: Icons.search,
                      validate: (ss){
                      },
                  suffix: IconButton(onPressed: (){
                    SearchCubit.get(context).Search(searchcontroller.text);
                  },
                      icon: Icon(Icons.search))
                  ),
                  SizedBox(
                    height: 20,
                  ),

              SearchCubit.get(context).searchModel!=null?
                Expanded(
                  child: ListView.separated(itemBuilder:(context,index)=> SearchBuilder(SearchCubit.get(context).searchModel!.data!.data![index] as Product,context) ,
                      separatorBuilder: (context,index)=>seperator(),
                      itemCount:SearchCubit.get(context).searchModel!.data!.data!.length ),
                ):Center(child: CircularProgressIndicator()),


                ],
              ),
            )
          );
        },

      ),
    );
  }





  Widget SearchBuilder(Product model,context)=>Padding(
    padding: const EdgeInsets.all(20.0),
    child: Container(
      height: 160,
      child: Row(
        children: [
          Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Image(image: NetworkImage('${model.image}'),
                height: 150,
                width: 150,
              ),
            ],
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(model.name!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Spacer(),
                Row(
                  children: [
                    Text('${model.price}',
                      style: TextStyle(
                          color: Colors.black
                      ),
                    ),
                    SizedBox(width: 6,),
                    Spacer(),
                    CircleAvatar(
                      backgroundColor:ShopCubit.get(context).favourite[model.id]!? Colors.red : Colors.blue,
                      radius: 15,
                      child: IconButton(
                          onPressed: (){
                            // print(product.id);
                            ShopCubit.get(context).ChangeFavourite(model.id!);
                          },
                          iconSize: 14,
                          color: Colors.white,
                          icon: Icon(Icons.favorite_border)
                      ),
                    )


                  ],
                ),
              ],
            ),
          )

        ],
      ),
    ),
  );






}
