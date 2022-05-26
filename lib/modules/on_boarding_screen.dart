
import 'package:flutter/material.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tadeer_recycling_shop/helpers/colors.dart';
import 'package:tadeer_recycling_shop/main.dart';
import 'package:tadeer_recycling_shop/modules/login/login_screen.dart';
import 'package:tadeer_recycling_shop/shared/components/boardingItem.dart';
import 'package:tadeer_recycling_shop/shared/network/local/cache_helper.dart';

import '../shared/Functions.dart';

class BoardingModel
{
  final String image;
  final String title;
  final String body;

  BoardingModel({
    required this.image,
    required this.title,
    required this .body,
    });
}

void submit(context)
{
  CacheHelper.saveData(
      key: 'onBoarding',
      value: true,
  ).then((value)
  {
    if(value!) navigateAndReplaceTo(LoginScreen(), context);
  },);

}



class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();

  List<BoardingModel> boarding = [
    BoardingModel(
        image: 'assets/images/recycling_1.png',
        title: 'On Board 1 title',
        body: 'On Board 1 body'
    ),
    BoardingModel(
        image: 'assets/images/recycling_1.png',
        title: 'On Board 2 title',
        body: 'On Board 2 body'
    ),
    BoardingModel(
        image: 'assets/images/recycling_1.png',
        title: 'On Board 3 title',
        body: 'On Board 3 body'
    ),
  ];

  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 5,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextButton(
              style: const ButtonStyle(
                enableFeedback: true,
                animationDuration: Duration(
                  milliseconds: 0,
                ),
              ),

                onPressed: () {
                submit(context);
                },
                child: const Text(
                    'SKIP',
                    style: TextStyle(
                     // color: Colors.black54,
                      fontWeight: FontWeight.w700,
                    ),
                )
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                itemBuilder: (context, index) => buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
                physics: const BouncingScrollPhysics(),
                controller: boardController,
                onPageChanged: (index) {
                  if(index == boarding.length - 1)
                    {
                      isLast = true;
                    }
                  else
                    {
                      isLast = false;
                    }
                },
              ),
            ),
            const SizedBox(
              height: 40.0,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                    controller: boardController,
                    effect: ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      activeDotColor: greenColor,
                      dotHeight: 10,
                      expansionFactor: 4,
                      dotWidth: 10,
                      spacing: 5.0,
                    ),
                    count: boarding.length),
                const Spacer(),
                FloatingActionButton(
                    onPressed: () {
                      if (isLast == false)
                        {
                          boardController.nextPage(
                            duration: const Duration(
                              milliseconds: 750,
                            ),
                            curve: Curves.fastLinearToSlowEaseIn,
                          );
                        }
                      else
                        {
                          submit(context);
                        }

                    },
                  child: const Icon(Icons.arrow_forward_ios),
                )
              ],
            )
          ],
        ),
      )
    );
  }

  Widget buildBoardingItem(BoardingModel model) => Column(
      crossAxisAlignment: CrossAxisAlignment.start, children: [
    Expanded(
        child: Image(image: AssetImage(model.image))
    ),
    const SizedBox(
      height: 30.0,
    ),
    Text(
      model.title,
      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    ),
    const SizedBox(
      height: 15.0,
    ),
    Text(
      model.body,
      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
    ),
  ]);
}
