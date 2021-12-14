import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:compseviceuber/models/user_model.dart';
import 'package:compseviceuber/utility/my_constant.dart';
import 'package:compseviceuber/utility/my_dialog.dart';
import 'package:compseviceuber/widgets/show_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  String? typeUser;
  double? lat, lng;
  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Container newName() {
    return Container(
      decoration: Myconstant().whiteBox(),
      margin: const EdgeInsets.only(top: 16),
      width: 250,
      child: TextFormField(
        controller: nameController,
        validator: (value) {
          if (value!.isEmpty) {
            return 'กรุณากรอก ชื่อด้วยค่ะ';
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.fingerprint,
            color: Myconstant.dark,
          ),
          label: const ShowText(data: 'Name :'),
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  Container newEmail() {
    return Container(
      decoration: Myconstant().whiteBox(),
      margin: const EdgeInsets.only(top: 16),
      width: 250,
      child: TextFormField(
        controller: emailController,
        validator: (value) {
          if (value!.isEmpty) {
            return 'กรุณากรอก Emailด้วยค่ะ';
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.email_outlined,
            color: Myconstant.dark,
          ),
          label: const ShowText(data: 'Email :'),
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  Container newPassword() {
    return Container(
      decoration: Myconstant().whiteBox(),
      margin: const EdgeInsets.only(top: 16),
      width: 250,
      child: TextFormField(
        controller: passwordController,
        validator: (value) {
          if (value!.isEmpty) {
            return 'กรุณากรอก Password ด้วยค่ะ';
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.password_outlined,
            color: Myconstant.dark,
          ),
          label: const ShowText(data: 'Password :'),
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    findLocation();
  }

  Future<void> findLocation() async {
    Position? position = await findPosition();
    setState(() {
      lat = position!.latitude;
      lng = position.longitude;
      print('lat = $lat, lng =$lng');
    });
  }

  Future<Position?> findPosition() async {
    Position? position;

    try {
      position = await Geolocator.getCurrentPosition();
    } catch (e) {}

    return position;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () => processRegiter(),
              icon: const Icon(Icons.cloud_download_outlined))
        ],
        backgroundColor: Myconstant.primary,
        title: const Text('Create New Account'),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(
          FocusNode(),
        ),
        behavior: HitTestBehavior.opaque,
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  newName(),
                  newTitle('Type User'),
                  radioUser(),
                  radioDriver(),
                  newEmail(),
                  newPassword(),
                  newTitle('Your location :'),
                  newMap(),
                  buttonCreateAccount(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget newMap() {
    return Container(
      width: 300,
      height: 200,
      child: lat == null
          ? Center(child: CircularProgressIndicator())
          : GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(lat!, lng!),
                zoom: 30,
              ),
              onMapCreated: (controller) {},
              markers: <Marker>{
                Marker(
                  markerId: MarkerId('id'),
                  position: LatLng(lat!, lng!),
                  infoWindow: InfoWindow(
                      title: 'คุณอยู่ที่นี่', snippet: 'lat $lat,lng =$lng'),
                ),
              },
            ),
    );
  }

  Container buttonCreateAccount() {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          processRegiter();
        },
        child: Text('Create New Account'),
      ),
    );
  }

  Future<void> processRegiter() async {
    if (formKey.currentState!.validate()) {
      if (typeUser == null) {
        Mydialog()
            .normalDialog(context, 'type User Non?', 'Please Choose Type User');
      } else {
        await Firebase.initializeApp().then((value) async {
          print('Initial Success');
          await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
                  email: emailController.text,
                  password: passwordController.text)
              .then((value) async {
            String uid = value.user!.uid;

            print('Register Sucess uid ==> $uid ');

            UserModel model = UserModel(
                email: emailController.text,
                lat: lat!,
                lng: lng!,
                name: nameController.text,
                password: passwordController.text,
                typeuser: typeUser!);

            await FirebaseFirestore.instance
                .collection('user')
                .doc(uid)
                .set(model.toMap())
                .then((value) => Navigator.pop(context));
          }).catchError((value) {
            String title = value.code;
            String message = value.message;
            Mydialog().normalDialog(context, title, message);
          });
        });
      }
    }
  }

  Widget radioUser() {
    return Container(
      width: 250,
      child: RadioListTile(
        subtitle: const ShowText(data: 'คนชรา'),
        title: const ShowText(data: 'User'),
        value: 'user',
        groupValue: typeUser,
        onChanged: (value) {
          setState(() {
            typeUser = value.toString();
          });
        },
      ),
    );
  }

  Widget radioDriver() {
    return Container(
      width: 250,
      child: RadioListTile(
        subtitle: const ShowText(data: 'คนขับ'),
        title: const ShowText(data: 'Driver'),
        value: 'driver',
        groupValue: typeUser,
        onChanged: (value) {
          setState(() {
            typeUser = value.toString();
          });
        },
      ),
    );
  }

  Row newTitle(String title) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ShowText(
            data: title,
            textStyle: Myconstant().h2Style(),
          ),
        ),
      ],
    );
  }
}
