import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserController extends GetxController {
  var userName = Rxn<String>(); // Rxn can hold a null value, which is useful before the user's name is loaded.

  @override
  void onInit() {
    super.onInit();
    updateUserName(); // Fetch the user's name when the controller is initialized.
  }

  void updateUserName() async {
    final email = FirebaseAuth.instance.currentUser?.email;
    if (email != null) {
      try {
        final userDoc = await FirebaseFirestore.instance.collection('users').doc(email).get();
        final fullName = userDoc.data()?['fullName'] as String?;
        print("Fetched name: $fullName"); // Debugging print
        if (fullName != null) {
          userName.value = fullName;
        } else {
          print("FullName is null");
        }
      } catch (e) {
        print("Error fetching user name: $e");
      }
    } else {
      print("User email is null");
    }
  }


}
