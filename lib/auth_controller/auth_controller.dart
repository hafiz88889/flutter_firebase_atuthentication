import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_authentication/auth_controller/user_controller.dart';
import 'package:firebase_authentication/home_screen/home_page.dart';
import 'package:firebase_authentication/login_page/login_screen.dart';
import 'package:get/get.dart';

class AuthController extends GetxController{

  var isHidden = true.obs;

  void togglePassword() {
    isHidden.value = !isHidden.value;
  }
  FirebaseAuth auth=FirebaseAuth.instance;


  Future<void> registerUser(String name,String email,String password)async{
    try{
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,

      );
      await FirebaseFirestore.instance
          .collection("user")
          .doc(userCredential.user!.uid)

          .set({
        "name":name,
        "email":email,
        "password":password,
        'createdAt': FieldValue.serverTimestamp(),
      });

      Get.snackbar("Success", "Account created successfully");
     Get.to(HomePage());

    }catch(e){
      Get.snackbar("Error", e.toString());
    }
  }

  Future<void> loginUser(String email,String password)async{
    try{
      UserCredential userCredential=
      await auth.signInWithEmailAndPassword(email: email, password: password);
      Get.put(AllUserController());
      Get.find<AllUserController>();

      String uid = userCredential.user!.uid;

      DocumentSnapshot userDco=await FirebaseFirestore.instance
          .collection("user")
          .doc(uid)
          .get();

      if(userDco.exists){
        print("User Email: ${userDco['email']}");
        Get.to(HomePage());
      }else
      {
        Get.snackbar("Access Denali", "You are not allowed for Login");
      }
    }
    catch(e){
      Get.snackbar("Login Error", e.toString());
    }
  }

  Future<void> resetPassword(String email)async{
    try{
      await auth.sendPasswordResetEmail(email: email);
      Get.snackbar("Success", "Password reset sent to $email",
        snackPosition: SnackPosition.BOTTOM,
      );
    }catch(e){
      Get.snackbar("Error", e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
  void logOut() async {
    await auth.signOut();
   Get.to(LoginScreen());
  }


}