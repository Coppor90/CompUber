import 'package:compseviceuber/utility/my_constant.dart';
import 'package:compseviceuber/widgets/show_image.dart';
import 'package:compseviceuber/widgets/show_text.dart';
import 'package:flutter/material.dart';

class Authen extends StatefulWidget {
  const Authen({Key? key}) : super(key: key);

  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusScopeNode()),
        behavior: HitTestBehavior.opaque,
        child: Container(
          decoration: Myconstant().gradienBox(),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  newImage(),
                  newAppName(),
                  newUser(),
                  newPassword(),
                  newLogin(),
                  newCreateAccount()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Row newCreateAccount() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ShowText(data: 'Non Account ? '),
        TextButton(
          onPressed: ()=> Navigator.pushNamed(context, '/createAccount'),
          child: const Text('Create Account'),
        )
      ],
    );
  }

  Container newLogin() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16),
      width: 300,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(primary: Myconstant.dark),
        onPressed: () {},
        child: Text('Login'),
      ),
    );
  }

  Container newUser() {
    return Container(
      decoration: Myconstant().whiteBox(),
      margin: EdgeInsets.only(top: 16),
      width: 300,
      child: TextFormField(
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.perm_identity,
            color: Myconstant.dark,
          ),
          label: ShowText(data: 'User :'),
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Container newPassword() {
    return Container(
      decoration: Myconstant().whiteBox(),
      margin: EdgeInsets.only(top: 16),
      width: 300,
      child: TextFormField(
        obscureText: true,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.local_activity,
            color: Myconstant.dark,
          ),
          label: ShowText(data: 'Password :'),
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  ShowText newAppName() => ShowText(
        data: Myconstant.appName,
        textStyle: Myconstant().h1Style(),
      );

  Container newImage() {
    return Container(
      width: 300,
      child: ShowImage(),
    );
  }
}
