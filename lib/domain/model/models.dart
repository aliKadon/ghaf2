import 'package:flutter/material.dart';

class SliderObject {
  String title;
  String image;

  SliderObject(this.title, this.image);
}

class SubscriptionObject {
  String name;
  String price;
  String image;
  List<String> listItem;

  SubscriptionObject(this.name,this.price, this.image,this.listItem);
}

class BnScreen {
  final Widget widget;
  final String title;

  const BnScreen({required this.widget, required this.title});
}


class Faq {
  final String question;
  final String answer;
  bool expanded;

  Faq({
    required this.question,
    required this.answer,
    this.expanded = false,
  });
}

