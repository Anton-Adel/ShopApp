

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../ShopApp/cubit/cubit.dart';
import '../../ShopApp/cubit/states.dart';
import '../../shop_app_models/CategoriyModel.dart';
import '../../shop_app_models/home_model.dart';

class ProductsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        return ShopCubit.get(context).home_model!=null&&(ShopCubit.get(context).categoryModel!=null)? SilderBuilder(ShopCubit.get(context).home_model!,ShopCubit.get(context).categoryModel!,context):
        Center(child: CircularProgressIndicator());
      },
    );
  }
  Widget SilderBuilder(HomeModel model,CategoryModel category,context)=>SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      CarouselSlider(
          items: model.data!.banners.map((e) => Image(
            image: NetworkImage('${e.image}'),
            width: double.infinity,
            fit: BoxFit.cover,
          ) ).toList() ,
          options: CarouselOptions(
            height: 250,
            autoPlay: true,
            initialPage: 0,
            enableInfiniteScroll: true,
            viewportFraction: 1,
            reverse: false,
           autoPlayInterval: Duration(seconds: 3),
           autoPlayAnimationDuration: Duration(seconds: 1),
           autoPlayCurve: Curves.fastOutSlowIn,
            scrollDirection: Axis.horizontal,

          )),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Categories",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),

              ),
              SizedBox(
                height: 10,
              ),
       Container(
               height: 100,
               child: ListView.separated(
                 physics: BouncingScrollPhysics(),
                     scrollDirection: Axis.horizontal,
                   itemBuilder:(context,index)=>CategoryBuilder(category.data!.data[index]) ,
                   separatorBuilder:(context,index)=>SizedBox(
                     width: 10,
                   ) ,
                   itemCount: category.data!.data.length),
       ),
              SizedBox(
                height: 10,
              ),
              Text("Products",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),

              ),
            ],
          ),
        ),

        SizedBox(
          height: 10,
        ),

        GridView.count(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        crossAxisSpacing: 0,
        mainAxisSpacing: 0,
        childAspectRatio: 1/1.68,
        children: List.generate(model.data!.products.length, (index) =>productBuilder(model.data!.products[index],context) ),
        )
      ],

    ),
  );

  Widget productBuilder(ProductModel product,context)=>
      Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Image(
            image: NetworkImage('${product.image}',

          ),
            width: double.infinity,
            height: 200,

          ),
          if(product.discount!=0)
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
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${product.name}',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Row(
              children: [
                Text('${product.price}',
                  style: TextStyle(
                      color: Colors.black
                  ),
                ),
                SizedBox(width: 6,),
                if(product.discount!=0)
                  Text('${product.old_price}',
                    style: TextStyle(
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough,

                    ),
                  ),
                Spacer(),
                CircleAvatar(
                  backgroundColor:ShopCubit.get(context).favourite[product.id]! ? Colors.red : Colors.blue,
                  radius: 15,
                  child: IconButton(
                      onPressed: (){
                        print(product.id);
                        ShopCubit.get(context).ChangeFavourite(product.id!);
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
  );

  Widget CategoryBuilder(Data_Model model)=> Container(
    width: 100,
    child: Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Image(image: NetworkImage(model.image!),
          width: 100,
          height: 100,
          fit: BoxFit.cover,
        ),
        Container(
          width: double.infinity,
          color: Colors.black.withOpacity(.8),
          child: Text(model.name!,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color: Colors.white,


            ),
          ),
        )
      ],
    ),
  );
}
