import 'package:ekonomie/constants/constants.dart';
import 'package:ekonomie/screen/new_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:flutter_screenutil/screenutil_init.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prefs/prefs.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Prefs.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return ScreenUtilInit(
      builder: () => NeumorphicApp(
        debugShowCheckedModeBanner: false,
        title: 'Ekonomie',
        themeMode: ThemeMode.dark,
        materialDarkTheme: ThemeData.dark().copyWith(
            scaffoldBackgroundColor: kScaffoldBGColor,
            accentColor: kSecondaryColor),
        home: SplashScreen(),
      ),
    );
  }
}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
          systemNavigationBarColor: kPrimaryColor,
          statusBarColor: kPrimaryColor),
      child: SplashScreenView(
          backgroundColor: kPrimaryColor,
          imageSrc: "assets/launcher_icon/new_icon.png",
          home: NewDashboardPage(),
          duration: 2000,
          imageSize: ScreenUtil().setSp(250).round(),
          text: "Ekonomie",
          textStyle: GoogleFonts.hammersmithOne(
              fontSize: ScreenUtil().setSp(35.0),
              fontWeight: FontWeight.bold,
              color: Colors.white)),
    );
  }
}
