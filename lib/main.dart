import 'package:compseviceuber/states/authen.dart';
import 'package:compseviceuber/states/create_account.dart';
import 'package:compseviceuber/states/service_driver.dart';
import 'package:compseviceuber/states/service_user.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> map = {
  '/authen': (BuildContext context) => const Authen(),
  '/createAccount': (BuildContext context) => const CreateAccount(),
  '/serviceUser': (BuildContext context) => const ServiceUser(),
  '/surviceDriver': (BuildContext context) => const ServiceDriver(),
};

String firstPace = '/authen';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: map,
      initialRoute: firstPace,
    );
  }
}