import 'package:corona_tracker/homepage.dart';
import 'package:corona_tracker/networking.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

class StartScreen extends StatefulWidget {
  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  void getData() async {
    var data = await Networking.getDataLocal('Bangladesh');
    var globaldata = await Networking.getDataGlobal();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(
          data: data,
          globalData: globaldata,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 2,
      imageBackground: AssetImage('images/splash.jpg'),
      loaderColor: Colors.red,
    );
  }
}
