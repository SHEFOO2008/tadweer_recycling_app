import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tadeer_recycling_shop/layout/shop_layout/cubit/states.dart';
import 'package:tadeer_recycling_shop/layout/shop_layout/shop_layout.dart';
import 'package:tadeer_recycling_shop/models/home_model.dart';
import 'package:tadeer_recycling_shop/modules/categories/categories_screen.dart';
import 'package:tadeer_recycling_shop/modules/favourites/favourites_screen.dart';
import 'package:tadeer_recycling_shop/modules/products/products_screen.dart';
import 'package:tadeer_recycling_shop/modules/settings/settings_screen.dart';
import 'package:tadeer_recycling_shop/shared/Functions.dart';
import 'package:tadeer_recycling_shop/shared/constants.dart';
import 'package:tadeer_recycling_shop/shared/network/end_points.dart';
import 'package:tadeer_recycling_shop/shared/network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates>
{
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> screens = const [
    ProductsScreen(),
    CategoriesScreen(),
    FavouritesScreen(),
  ];

  void changeBottom(int index){
    currentIndex = index;
    emit(ShopChangeBottomNavBarState());
  }

  HomeModel? homeModel;


  void getHomeData()
  async {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(
        url: HOME,
      token: token,
    ).then((value) async {
       homeModel = HomeModel.fromJson(value.data);

       print(homeModel?.data?.banners[0].image);
       //print(homeModel?.status);
      emit(ShopSuccessHomeDataState());
    });
  }
}