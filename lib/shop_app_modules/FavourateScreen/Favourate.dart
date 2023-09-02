
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../ShopApp/cubit/cubit.dart';
import '../../ShopApp/cubit/states.dart';
import '../../shared/components/component.dart';
import '../../shop_app_models/GetFavouriteModel.dart';

class FavourateScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return
    BlocConsumer<ShopCubit,ShopStates>(
        listener: (context,state){},
        builder: (context,state){
          return  ShopCubit.get(context).favouriteModel!=null ?
          ListView.separated(itemBuilder:(context,index)=> FavouriteBuilder(ShopCubit.get(context).favouriteModel!.data!.data![index],context) ,
              separatorBuilder: (context,index)=>seperator(),
              itemCount:ShopCubit.get(context).favouriteModel!.data!.data!.length ):Center(child: CircularProgressIndicator());
        }

    );

  }
  Widget FavouriteBuilder(DataModel model,context)=>Padding(
    padding: const EdgeInsets.all(20.0),
    child: Container(
      height: 160,
      child: Row(
        children: [
          Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Image(image: NetworkImage('${model.product!.image}'),
                height: 150,
                width: 150,
                fit: BoxFit.cover,
              ),
              if(model.product!.discount!=0)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Container(
                    color: Colors.red,
                    child: Text("OFFER",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                )
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
                  child: Text(model.product!.name!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Spacer(),
                Row(
                  children: [
                    Text('${model.product!.price}',
                      style: TextStyle(
                          color: Colors.black
                      ),
                    ),
                    SizedBox(width: 6,),
                    if(model.product!.discount!=0)
                      Text('${model.product!.oldPrice}',
                        style: TextStyle(
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,

                        ),
                      ),
                    Spacer(),
                    CircleAvatar(
                      backgroundColor:ShopCubit.get(context).favourite[model.product!.id]!? Colors.red : Colors.blue,
                      radius: 15,
                      child: IconButton(
                          onPressed: (){
                            // print(product.id);
                            ShopCubit.get(context).ChangeFavourite(model.product!.id!);
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
