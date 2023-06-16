
import 'package:face_auth_flutter/helpers/constants.dart';
import 'package:face_auth_flutter/models/user.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveBoxes {
  static const userDetails = "user_details";

  static Box userDetailsBox() => Hive.box(userDetails);

  static initialize() async {
    var data=await Hive.openBox(userDetails);
    print("the data is =   ${data}");
  }

  static clearAllBox() async {
    await HiveBoxes.userDetailsBox().clear();
  }
  Future clearbox() async{
    await Hive.box(userDetails).clear().then((value){
      Get.snackbar("Database", "Deleted");
    }).catchError((onError){
      Get.snackbar("Error", onError.toString());
    });
  }
}

class LocalDB {
  static User getUser() { return User.fromJson(HiveBoxes.userDetailsBox().toMap());}

  static String getUserName() =>
      HiveBoxes.userDetailsBox().toMap()[User.nameKey];

  static String getUserArray() =>
      HiveBoxes.userDetailsBox().toMap()[User.arrayKey];

  static setUserDetails(User user) =>
      HiveBoxes.userDetailsBox().putAll(user.toJson());


}
