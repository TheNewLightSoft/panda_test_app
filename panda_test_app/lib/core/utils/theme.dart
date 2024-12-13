import 'package:flutter/material.dart';

abstract class PandaColors {
  static const Color richBlack = Color.fromARGB(255, 30, 29, 29);
  static const Color brown = Color.fromARGB(255, 71, 33, 9);
  static const Color browAccent = Color.fromARGB(255, 81, 68, 59);
  static const Color amber = Color.fromARGB(255, 230, 175, 62);
  static const Color amberDark = Color.fromARGB(255, 235, 191, 105);
  static const Color grey = Color.fromARGB(255, 239, 239, 239);
  static const Color greyLess = Color.fromARGB(255, 241, 241, 241);
  static const Color greyDark = Color.fromARGB(255, 216, 215, 216);
  static const Color pink = Color.fromARGB(255, 248, 245, 253);
  static const Color pinkAccent = Color.fromARGB(255, 253, 238, 239);
}

abstract class PandaBorders {
  static const OutlineInputBorder focusedBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(45),
    ),
    borderSide: BorderSide(
      color: PandaColors.brown,
      width: 2,
    ),
  );
  static const OutlineInputBorder unfocusedBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(45),
    ),
    borderSide: BorderSide(
      color: PandaColors.amber,
      width: 2,
    ),
  );
}
