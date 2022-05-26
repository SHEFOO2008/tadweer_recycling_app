
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tadeer_recycling_shop/shared/cubit/states.dart';
import 'package:tadeer_recycling_shop/shared/network/local/cache_helper.dart';
import 'package:tadeer_recycling_shop/shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates>
{
  NewsCubit() : super(NewsIntialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomItems =  [
   const BottomNavigationBarItem(
        icon: Icon(Icons.business_center),
     label: 'Business'
    ),
   const BottomNavigationBarItem(
        icon: Icon(Icons.science),
     label: 'Science'
    ),
   const BottomNavigationBarItem(
        icon: Icon(Icons.sports),
     label: 'Sports'
    ),
  ];

  List<Widget> screens = const [
  //  BusinessScreen(),
  //  ScienceScreen(),
   // SportsScreen(),
  ];

  void changeIndex(int index)
  {
    currentIndex = index;
    emit(NewsBottomNavState());
  }

  List<dynamic> business = [];

  void getBusiness()
  {
    emit(NewsGetBusinessLoadingState());
    if(business.isEmpty)
    {
      DioHelper.getData(
          url: 'v2/top-headlines',
          query: {
            'country':'eg',
            'category':'business',
            'apiKey':'be0bca96cffb4e70932bfc6e0d69ea66'
          }
      ).then((value){
        print(value.data['articles'][0]['title']);
        business = value.data['articles'];
        print(business[0]['title']);

        emit(NewsGetBusinessSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(NewsGetBusinessErrorState(error.toString()));
      });
    }
    else
    {
      emit(NewsGetBusinessSuccessState());
    }


  }

  List<dynamic> science = [];

  void getScience()
  {
    emit(NewsGetScienceLoadingState());
        DioHelper.getData(
            url: 'v2/top-headlines',
            query: {
              'country':'eg',
              'category':'science',
              'apiKey':'be0bca96cffb4e70932bfc6e0d69ea66'
            }
        ).then((value){
          print(value.data['articles'][9]['title']);
          science = value.data['articles'];
          print(science[0]['title']);

          emit(NewsGetScienceSuccessState());
        }).catchError((error){
          print(error.toString());
          emit(NewsGetScienceErrorState(error.toString()));
        });
      }

  List<dynamic> sports = [];

  void getSports()
  {
    emit(NewsGetSportsLoadingState());
      DioHelper.getData(
          url: 'v2/top-headlines',
          query: {
            'country':'eg',
            'category':'sports',
            'apiKey':'be0bca96cffb4e70932bfc6e0d69ea66'
          }
      ).then((value){
        print(value.data['articles'][9]['title']);
        sports = value.data['articles'];
        print(sports[0]['title']);

        emit(NewsGetSportsSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(NewsGetSportsErrorState(error.toString()));
      });
    }

  //https://newsapi.org/
// v2/everything?
// q=tesla&apiKey=be0bca96cffb4e70932bfc6e0d69ea66

  List<dynamic> search = [];

  void getSearch(String value)
  {
    emit(NewsGetSearchLoadingState());
    DioHelper.getData(
        url: 'v2/everything',
        query: {
          'q':'$value',
          'apiKey':'be0bca96cffb4e70932bfc6e0d69ea66'
        }
    ).then((value){
      search = value.data['articles'];
      print(sports[0]['title']);

      emit(NewsGetSearchSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsGetSearchErrorState(error.toString()));
    });
  }

    bool isDark = false;
    ThemeMode appMode = ThemeMode.dark;

  void changeAppMode({bool? fromShared})
  {
    if(fromShared != null) {
      isDark = fromShared;
    }
    else {
      isDark = !isDark;
    }
    CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) => emit(NewsChangeModeState()));

  }
  }