import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wanAndroid/pages/welcome_page.dart';

import 'constant/app_colors.dart';

void main() async {

  final navigatorKey = GlobalKey<NavigatorState>();

  runApp(MaterialApp(
    navigatorKey: navigatorKey,
    theme: ThemeData(
        primaryColor: AppColors.colorPrimary,
        accentColor: AppColors.colorPrimary),
    home: WelcomePage(),
  ));
}
