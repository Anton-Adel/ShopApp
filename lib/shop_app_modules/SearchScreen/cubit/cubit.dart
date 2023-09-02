
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shop_app_modules/SearchScreen/cubit/states.dart';

import '../../../shared/components/constants.dart';
import '../../../shared/network/Endpoint.dart';
import '../../../shared/network/remote/shop_dio_helper.dart';
import '../../../shop_app_models/SearchModel.dart';

class SearchCubit extends Cubit<SearchStates>{
  SearchCubit():super(SearchInitialState());

  SearchModel? searchModel;

  static SearchCubit get(context)=>BlocProvider.of(context);

  void Search(String text){
    searchModel=null;
    emit(SearchLoadingState());
    ShopDioHelper.postData(url: SEARCH, Data:
    {
      'text':text
    },
    Token: token
    ).then((value) {
      print('anton');
      searchModel=SearchModel.fromJson(value.data);
      print('Adel');
      print(searchModel!.data!.data![0].name);
      emit(SearchSuccessState());

    }).catchError((error){
      emit(SearchErrorState());
    });

  }

}