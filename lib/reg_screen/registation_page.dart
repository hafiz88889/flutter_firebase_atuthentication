import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../auth_controller/auth_controller.dart';
import '../utils/my_color.dart';
import '../utils/my_images.dart';
import '../utils/my_text.dart';
import '../utils/my_text_style.dart';

class RegistationPage extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final AuthController controller = Get.put(AuthController());

  RegistationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: MyColor.primaryColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //   const SizedBox(height: 20),
              GestureDetector(
                onTap: Get.back,
                child: CircleAvatar(
                  backgroundColor: MyColor.normalWhiteColor.withAlpha(100),
                  child: SvgPicture.asset(
                    MyImage.backIcon,
                    colorFilter: ColorFilter.mode(
                      MyColor.whiteColor,
                      BlendMode.srcIn,
                    ),
                    height: 30,
                    width: 30,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                MyText.signUp,
                style: regularTextStyle24.copyWith(fontSize: 30),
              ),
              const SizedBox(height: 30),
              Text(
                MyText.name,
                style: regularTextStyle16.copyWith(
                  fontWeight: FontWeight.w100,
                  color: MyColor.normalWhiteColor,
                ),
              ),
              TextField(
                controller: nameController,
                style: regularTextStyle18,
                decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SvgPicture.asset(
                      MyImage.userIcon,
                      colorFilter: ColorFilter.mode(
                        MyColor.whiteColor,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 25),
              Text(
                MyText.EmailAddress,
                style: regularTextStyle16.copyWith(
                  fontWeight: FontWeight.w100,
                  color: MyColor.normalWhiteColor,
                ),
              ),
              TextField(
                controller: emailController,
                style: regularTextStyle18,
                decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SvgPicture.asset(
                      MyImage.emailIcon,
                      colorFilter: ColorFilter.mode(
                        MyColor.whiteColor,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                MyText.password,
                style: regularTextStyle16.copyWith(
                  fontWeight: FontWeight.w100,
                  color: MyColor.normalWhiteColor,
                ),
              ),
              Obx(() => TextField(
                controller: passwordController,
                obscureText: controller.isHidden.value,
                style: regularTextStyle18,
                decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SvgPicture.asset(
                      MyImage.lockIcon,
                      colorFilter: ColorFilter.mode(
                        MyColor.whiteColor,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      controller.isHidden.value
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.white54,
                    ),
                    onPressed: controller.togglePassword,
                  ),
                ),
              ),
              ),
              const SizedBox(height: 30,),
              // const Spacer(),
              SizedBox(
                height: 55,
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyColor.blueColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: () {
                    String name=nameController.text.trim();
                    String email=emailController.text.trim();
                    String password=passwordController.text.trim();

                    if(name.isNotEmpty && email.isNotEmpty && password.length>=6){
                      controller.registerUser(name,email, password,);
                    }else{
                      Get.snackbar("Invalid Input", "Please Input 6+ char password");
                    }
                  },
                  child: Text(
                    MyText.signUp,
                    style: regularTextStyle24.copyWith(fontSize: 20),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Center(
                child: GestureDetector(
                  onTap: ()=>Get.back(),
                  child: RichText(
                    text: TextSpan(
                        text: MyText.alreadyHaveAccount,
                        style: regularTextStyle16.copyWith(
                          color: MyColor.normalWhiteColor,
                        ),
                        children: [
                          TextSpan(
                              text: MyText.signIn,style: regularTextStyle16.copyWith(color: MyColor.blueColor)
                          )
                        ]
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
