import 'package:tadeer_recycling_shop/models/home_model.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ShopChangeBottomNavBarState extends ShopStates {}

class ShopLoadingHomeDataState extends ShopStates {}

class ShopSuccessHomeDataState extends ShopStates {}

class ShopErrorHomeDataState extends ShopStates {}