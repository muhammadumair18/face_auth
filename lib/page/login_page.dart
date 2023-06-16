import 'package:face_auth_flutter/helpers/constants.dart';
import 'package:face_auth_flutter/page/face_recognition/camera_page.dart';
import 'package:face_auth_flutter/utils/local_db.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../utils/utils.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    printIfDebug(LocalDB.getUser().name);
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text("Face Authentication"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(32),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildButton(
                  text: 'Register',
                  icon: Icons.app_registration_rounded,
                  onClicked: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const FaceScanScreen()));
                  },
                ),
                const SizedBox(height: 20),
                buildButton(
                  text: 'Login',
                  icon: Icons.login,
                  onClicked: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FaceScanScreen(
                                  user: LocalDB.getUser(),
                                )));
                  },
                ),
                SizedBox(height: 20,),
                buildButton(
                  text: 'Clear Database',
                  icon: Icons.cleaning_services_sharp,
                  onClicked: () async {
                    await Hive.box("user_details").clear().then((value){
                      customBottomSnackbar(context, "Database Cleared");

                    }).catchError((onError){
                      customBottomSnackbar(context, "Error during database deletion");
                    });

                  },
                )
              ],
            ),
          ),
        ),
      );

  Widget buildButton({
    required String text,
    required IconData icon,
    required VoidCallback onClicked,
  }) =>
      ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(50),
        ),
        icon: Icon(icon, size: 26),
        label: Text(
          text,
          style: const TextStyle(fontSize: 20),
        ),
        onPressed: onClicked,
      );
}
