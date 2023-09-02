
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../ShopApp/cubit/cubit.dart';
import '../../ShopApp/cubit/states.dart';
import '../../shared/components/component.dart';
import '../../shop_app_models/CategoriyModel.dart';

class CategoriesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        return  ShopCubit.get(context).categoryModel!=null?
            ListView.separated(itemBuilder:(context,index)=> CategoryBuilder( ShopCubit.get(context).categoryModel!.data!.data[index]) ,
                separatorBuilder: (context,index)=>seperator(),
                itemCount:ShopCubit.get(context).categoryModel!.data!.data.length ):Center(child: CircularProgressIndicator());
      }

    );
  }

  Widget CategoryBuilder(Data_Model model)=> Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Image(image: NetworkImage(model.image!),
          width: 100,
          height: 100,
          fit: BoxFit.cover,
        ),
        SizedBox(
          width: 20,
        ),
        Expanded(
          child: Text(model.name!,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 20,


            ),
          ),
        ),
        Spacer(),
        IconButton(onPressed: (){}, icon:
        Icon(Icons.arrow_forward_ios)
        )
      ],
    ),
  );
}
