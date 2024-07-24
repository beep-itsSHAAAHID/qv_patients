import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:qv_patient/animations/fade_in_slide.dart';
import 'package:qv_patient/constants/colors.dart';
import 'package:qv_patient/constants/loading_overlay.dart';
import 'package:qv_patient/helper/responsive.dart';
import 'package:qv_patient/view/Authentication/login_view.dart';
import 'package:qv_patient/view/Authentication/widgets/widgets.dart';
import 'package:qv_patient/view/homepage/home.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  ValueNotifier<bool> termsCheck = ValueNotifier(false);
  int? _selectedGender;

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneNumberController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _ageController.dispose();
    // Dispose other controllers...
    super.dispose();
  }

  Future<void> submitUserData() async {
    final String fullName = _fullNameController.text;
    final String phoneNumber = _phoneNumberController.text;
    final String email = _emailController.text;
    final String password = _passwordController.text;
    final String age = _ageController.text;

    // Map the selected gender to a string
    String gender = 'Not Specified'; // Default or fallback value
    if (_selectedGender == 1) {
      gender = 'Male';
    } else if (_selectedGender == 2) {
      gender = 'Female';
    } else if (_selectedGender == 3) {
      gender = 'Others';
    }

    try {
      LoadingScreen.instance().show(context: context, text: "Sign Up...");
      await Future.delayed(const Duration(seconds: 1));
      print('adding data');

      // Use FirebaseAuth to create a new user
      final UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Hide the password storage comment as we won't store the password in Firestore
      // Add additional user data to Firestore with email as the document ID
      final CollectionReference users =
          FirebaseFirestore.instance.collection('users');
      await users.doc(email).set({
        'fullName': fullName,
        'phoneNumber': phoneNumber,
        'email':
            email, // Storing the email in the document as well, for easy access
        'age': age,
        'gender': gender, // Add the gender here
        // Add other fields as needed...
      });
      // Add additional user data to Firestore

      // Hide loading and navigate to Home
      LoadingScreen.instance().hide();
      Navigator.pushReplacement(context,
          CupertinoPageRoute(builder: (context) => const SignInView()));
      Get.snackbar(
        "Signup Successful",
        "Welcome to DocBook! Please login to continue.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        borderRadius: 20,
        margin: EdgeInsets.all(15),
        duration: Duration(seconds: 4),
      );
      print('data added succesfully');
    } catch (e) {
      print('Firebase error: $e');
      LoadingScreen.instance().hide();
      // Display an error message using Get.snackbar
      Get.snackbar(
        "Signup Failed",
        "An error occurred during signup: $e", // You might want to customize the error message
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        borderRadius: 20,
        margin: EdgeInsets.all(15),
        duration: Duration(seconds: 4),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 252, 252, 246),
      appBar: AppBar(),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          FadeInSlide(
            duration: .3,
            child: Text(
              "Join DocBook Today ",
              style: TextStyle(
                  color: TColors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: Responsive.fontSize(context, 0.06)),
            ),
          ),
          const SizedBox(height: 15),
          FadeInSlide(
            duration: .4,
            child: Text("Join DocBook, Your Gateway to Smart Living.",
                style: TextStyle(
                    color: TColors.black,
                    fontSize: Responsive.fontSize(context, 0.04))),
          ),
          const SizedBox(height: 25),
          const FadeInSlide(
            duration: .5,
            child: Text(
              "Full Name",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: TColors.black),
            ),
          ),
          const SizedBox(height: 10),
          FadeInSlide(
            duration: .5,
            child: EmailField(
              controller: _fullNameController,
              keyboardType: TextInputType.name,
              icon: Iconsax.personalcard_bold,
              hinttext: "Enter Your name...",
            ),
          ),
          const SizedBox(height: 20),
          const FadeInSlide(
            duration: .5,
            child: Text(
              "Phone number",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: TColors.black),
            ),
          ),
          const SizedBox(height: 10),
          FadeInSlide(
            duration: .5,
            child: EmailField(
              controller: _phoneNumberController,
              keyboardType: TextInputType.number,
              icon: Iconsax.mobile_outline,
              hinttext: "Enter phone number...",
            ),
          ),
          const SizedBox(height: 20),
          const FadeInSlide(
            duration: .5,
            child: Text(
              "Email",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: TColors.black),
            ),
          ),
          const SizedBox(height: 10),
          FadeInSlide(
            duration: .5,
            child: EmailField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              icon: Iconsax.direct_inbox_bold,
              hinttext: "Enter e-mail",
            ),
          ),
          const SizedBox(height: 20),
          const FadeInSlide(
            duration: .6,
            child: Text(
              "Password",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: TColors.black),
            ),
          ),
          const SizedBox(height: 10),
          FadeInSlide(
            duration: .6,
            child: PasswordField(
              controller: _passwordController,
            ),
          ),
          const SizedBox(height: 20),
          const FadeInSlide(
            duration: .5,
            child: Text(
              "Age",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: TColors.black),
            ),
          ),
          const SizedBox(height: 10),
          FadeInSlide(
            duration: .5,
            child: EmailField(
              controller: _ageController,
              keyboardType: TextInputType.number,
              icon: Icons.numbers,
              hinttext: "Enter age...",
            ),
          ),
          const SizedBox(height: 20),
          const FadeInSlide(
            duration: .6,
            child: Text(
              "Select Gender",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: TColors.black),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: ListTile(
                  title: const Text(
                    "Male",
                    style: TextStyle(color: TColors.black),
                  ),
                  leading: Radio<int>(
                    fillColor: WidgetStatePropertyAll(TColors.primary),
                    value: 1,
                    groupValue: _selectedGender,
                    onChanged: (value) {
                      setState(() {
                        _selectedGender = value;
                      });
                    },
                  ),
                ),
              ),
              Expanded(
                child: ListTile(
                  title: const Text(
                    "Female",
                    style: TextStyle(color: TColors.black),
                  ),
                  leading: Radio<int>(
                    fillColor: WidgetStatePropertyAll(TColors.primary),
                    value: 2,
                    groupValue: _selectedGender,
                    onChanged: (value) {
                      setState(() {
                        _selectedGender = value;
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: ListTile(
                  title: Text(
                    "Others",
                    style: TextStyle(color: TColors.black),
                  ),
                  leading: Radio<int>(
                    fillColor: WidgetStatePropertyAll(TColors.primary),
                    value: 3,
                    groupValue: _selectedGender,
                    onChanged: (value) {
                      setState(() {
                        _selectedGender = value;
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
          FadeInSlide(
            duration: .7,
            child: Row(
              children: [
                ValueListenableBuilder(
                  valueListenable: termsCheck,
                  builder: (context, value, child) {
                    return CupertinoCheckbox(
                      inactiveColor: isDark ? Colors.white : Colors.black87,
                      value: value,
                      onChanged: (_) {
                        termsCheck.value = !termsCheck.value;
                      },
                    );
                  },
                ),
                RichTwoPartsText(
                  text1: "I agree to DocBook ",
                  text2: "Terms and Conditions.",
                  onTap: () {},
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          FadeInSlide(
            duration: .8,
            child: RichTwoPartsText(
              text1: "Already have an account? ",
              text2: "Sign In",
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => const SignInView(),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 30),
          const FadeInSlide(
            duration: .9,
            child: Row(
              children: [
                Expanded(
                    child: Divider(
                  thickness: .3,
                )),
                Text(
                  "   or   ",
                ),
                Expanded(
                    child: Divider(
                  thickness: .3,
                )),
              ],
            ),
          ),
          const SizedBox(height: 20),
          FadeInSlide(
            duration: 1.0,
            child: LoginButton(
              icon: Brand(Brands.google, size: 25),
              text: "Continue with Google",
              onPressed: () {},
            ),
          ),
          SizedBox(height: height * 0.02),
          FadeInSlide(
            duration: 1.1,
            child: LoginButton(
              icon: Icon(
                Icons.apple,
                color: isDark ? Colors.white : Colors.black,
              ),
              text: "Continue with Apple",
              onPressed: () {},
            ),
          ),
          SizedBox(height: height * 0.02),
        ],
      ),
      // persistentFooterAlignment: AlignmentDirectional.center,
      bottomNavigationBar: FadeInSlide(
        duration: 1,
        direction: FadeSlideDirection.btt,
        child: Container(
          padding:
              const EdgeInsets.only(bottom: 40, left: 20, right: 20, top: 30),
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(width: .2, color: Colors.white),
            ),
          ),
          child: FilledButton(
            onPressed: () async {
              submitUserData();
            },
            style: FilledButton.styleFrom(
              backgroundColor: TColors.primary,
              fixedSize: const Size(double.infinity, 50),
            ),
            child: const Text(
              "Sign Up",
              style:
                  TextStyle(fontWeight: FontWeight.w900, color: TColors.white),
            ),
          ),
        ),
      ),
    );
  }
}
