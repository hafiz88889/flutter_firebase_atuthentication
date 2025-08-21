// all_user_controller.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_authentication/auth_controller/userModelClass.dart';
import 'package:get/get.dart';

class AllUserController extends GetxController {

  var users = <UserModel>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchAllUsers();
    super.onInit();
  }

  void fetchAllUsers() async {
    try {
      isLoading(true);
      QuerySnapshot snapshot =
      await FirebaseFirestore.instance.collection('user').get();

      users.value = snapshot.docs.map((doc) {
        return UserModel.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading(false);
    }
  }


}
