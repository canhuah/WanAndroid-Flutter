import 'package:flutter/material.dart';
import 'package:wanAndroid/constant/app_colors.dart';
import 'package:wanAndroid/http/api_manager.dart';
import 'package:wanAndroid/pages/home_page.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  void initState() {
    super.initState();

    init();
  }

  init() async {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      await ApiManager.instance.initClient();

      Future.delayed(Duration(milliseconds: 1000), () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
          return HomePage();
        }));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        color: AppColors.colorPrimary,
        child: Image.asset(
          "images/ic_logo.png",
          fit: BoxFit.fill,
          width: MediaQuery.of(context).size.width,
        ));
  }
}
