
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../ShopApp/cubit/cubit.dart';
import '../../ShopApp/shop_layout.dart';
import '../../shared/components/component.dart';
import '../../shared/components/constants.dart';
import '../../shared/network/local/cashHelper.dart';
import 'cubit/RegisterCubit.dart';
import 'cubit/RegisterState.dart';

class RegisterScreen extends StatelessWidget {

  var formKey = GlobalKey<FormState>();
  var mailcontroller= TextEditingController();
  var passwordcontroller= TextEditingController();
  var namecontroller= TextEditingController();
  var phonecontroller= TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit,ShopRegisterStates>(
        listener: (context,state){
          if(state is ShopRegisterSuccessState)
          {
            if(state.UserModel!.status==true)
            {
              print(state.UserModel!.message);
              print(state.UserModel!.uermodel!.token);
              CashHelper.SetData(key: 'token', value: state.UserModel!.uermodel!.token).then((value) {



                token=ShopRegisterCubit.get(context).UserModel!.uermodel!.token;

                ShopCubit.get(context).GetUserModel();
                navigate_replace(context, ShopLayout());
                showTost(state.UserModel!.message.toString(), TostStatus.SUCCESS);
              });

            }
            else
            {
              showTost(state.UserModel!.message.toString(), TostStatus.ERROR);
            }
          }


        },
        builder: (context,state){
          return Scaffold(
              appBar: AppBar(

              ),
              body:    Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('REGISTER',
                            style: Theme.of(context).textTheme.headline3!.copyWith(
                                color: Colors.black
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text('Register to our shop app',
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                color: Colors.grey
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          DefaultTextFeild(
                              controller: namecontroller,
                              type: TextInputType.text,
                              label: 'UserName',
                              prefix: Icons.person,
                              validate: (value){
                                if(value!.isEmpty) {
                                  return 'Empty User Name';
                                }
                                else
                                  return null;
                              }),
                          SizedBox(
                            height: 15,
                          ),
                          DefaultTextFeild(
                              controller: mailcontroller,
                              type: TextInputType.emailAddress,
                              label: 'e-mail',
                              prefix: Icons.email_outlined,
                              validate: (value){
                                if(value!.isEmpty) {
                                  return 'Empty e-mail';
                                }
                                else
                                  return null;
                              }),
                          SizedBox(
                            height: 15,
                          ),
                          DefaultTextFeild(
                              controller: passwordcontroller,
                              type: TextInputType.visiblePassword,
                              label: 'password',
                              password: ShopRegisterCubit.get(context).password,
                              prefix: Icons.lock_outline,
                              suffix: IconButton(
                                onPressed: () {
                                  ShopRegisterCubit.get(context).visible();
                                },
                                icon: Icon(
                                    ShopRegisterCubit.get(context).password? Icons.visibility:Icons.visibility_off
                                ),
                              ),
                              validate: (value){
                                if(value!.isEmpty) {
                                  return 'Empty password';
                                }
                                else
                                  return null;
                              }),
                          SizedBox(
                            height: 15,
                          ),
                          DefaultTextFeild(
                              controller: phonecontroller,
                              type: TextInputType.phone,
                              label: 'Phonr',
                              prefix: Icons.phone,
                              validate: (value){
                                if(value!.isEmpty) {
                                  return 'Empty Phone Number';
                                }
                                else
                                  return null;
                              }),
                          SizedBox(
                            height: 15,
                          ),
                          state is! ShopRegisterCubit?defaultButton(
                            function: (){
                              if(formKey.currentState!.validate())
                              {
                                ShopRegisterCubit.get(context).UserRegister(
                                    name: namecontroller.text,
                                    email: mailcontroller.text,
                                    password: passwordcontroller.text,
                                    phone: phonecontroller.text);

                              }
                            },
                            text: 'register',
                            upper: true,):Center(child: CircularProgressIndicator()),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
          );
        },

      ),
    );
  }
}
