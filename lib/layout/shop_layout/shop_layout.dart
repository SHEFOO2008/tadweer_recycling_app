import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tadeer_recycling_shop/layout/shop_layout/cubit/cubit.dart';
import 'package:tadeer_recycling_shop/modules/search/search_screen.dart';
import 'package:tadeer_recycling_shop/modules/settings/settings_screen.dart';
import 'package:tadeer_recycling_shop/shared/Functions.dart';
import 'package:tadeer_recycling_shop/shared/network/local/cache_helper.dart';
import 'cubit/states.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopCubit()..getHomeData(),
      child: BlocConsumer<ShopCubit,ShopStates>(
        listener: (context, builder) {},
        builder: (context, builder) {
          ShopCubit cubit = ShopCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title:const Text('Tadweer'),
              actions: [
                IconButton(
                    onPressed: (){
                      navigateTo(
                          const SettingsScreen(),
                          context);
                    },
                    icon: const Icon(
                      Icons.settings,
                    )),
                IconButton(
                    onPressed: (){
                      navigateTo(
                          const SearchScreen(),
                          context);
                    },
                    icon: const Icon(
                      Icons.search,
                    )),
              ],
            ),
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              items: const [
                BottomNavigationBarItem(
                icon: Icon(Icons.home),
                  label: 'Home'
                ),
                BottomNavigationBarItem(
                icon: Icon(Icons.grid_view),
                  label: 'Categories'
                ),
                BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                  label: 'Favourites'
                ),
              ],
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeBottom(index);
              },
            ),
          );
        },
      ),
    );
  }
}
