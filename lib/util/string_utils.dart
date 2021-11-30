import 'package:flutter/widgets.dart';
import 'package:wanAndroid/constant/app_colors.dart';

class StringUtils {

  static TextSpan getTextSpan(String? text, String? key) {
    if (text == null || key == null) {
      return TextSpan(text: "",children: []);
    }


    String splitString1 = "<em class='highlight'>";
    String splitString2 = "</em>";

    String textOrigin =
        text.replaceAll(splitString1, '').replaceAll(splitString2, '');

    TextSpan textSpan = new TextSpan(
        text: key, style: new TextStyle(color: AppColors.colorPrimary));

    List<String> split = textOrigin.split(key);

    List<TextSpan> list = [];

    for (int i = 0; i < split.length; i++) {
      list.add(new TextSpan(text: split[i]));
      list.add(textSpan);
    }

    list.removeAt(list.length - 1);

    return new TextSpan(children: list);
  }
}
