import 'package:Ekonomie/constants/constants.dart';
import 'package:Ekonomie/screen/new_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil_init.dart';
import 'package:prefs/prefs.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Prefs.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: () => MaterialApp(
        title: 'Ekonomie',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: kScaffoldBGColor,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: NewDashboardPage(),
      ),
    );
  }
}
