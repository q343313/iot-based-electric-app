


import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:iot/config/components/customintroscreenwidget.dart';

class IntroProviders extends ChangeNotifier{

  var index = 0;

List<Widget>screens = [
  Customintroscreenwidget(image: "", title1: "", title2: "", title3: ""),
  Customintroscreenwidget(image: "", title1: "", title2: "", title3: ""),
  Customintroscreenwidget(image: "", title1: "", title2: "", title3: ""),
];

}