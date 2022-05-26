import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:tadeer_recycling_shop/layout/shop_layout/shop_layout.dart';
import 'package:tadeer_recycling_shop/modules/login/login_screen.dart';
import 'package:tadeer_recycling_shop/modules/on_boarding_screen.dart';
import 'package:tadeer_recycling_shop/shared/bloc_observer.dart';
import 'package:tadeer_recycling_shop/shared/constants.dart';
import 'package:tadeer_recycling_shop/shared/network/local/cache_helper.dart';
import 'package:tadeer_recycling_shop/shared/network/remote/dio_helper.dart';
import 'package:tadeer_recycling_shop/shared/styles/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = BlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  var isDark = await CacheHelper.getData(key: 'isDark');

  bool onBoarding = await CacheHelper.getData(key: 'onBoarding') ?? false;


  Widget widget;

  token = await CacheHelper.getData(key: 'token') ?? '';

  if(onBoarding)
    {
      if(token.isNotEmpty) widget = ShopLayout();
      else widget = LoginScreen();
    }
  else
    {
      widget = OnBoardingScreen();
    }
  runApp(MyApp(
    isDark: false,
    startWidget: widget,
    token: token,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.isDark, required this.token, required this.startWidget}) : super(key: key);

  final bool isDark;
  final Widget startWidget;
  final String token;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      home:startWidget,
    );
  }
}