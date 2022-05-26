import 'package:flutter/material.dart';

import '../../modules/on_boarding_screen.dart';

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