import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:qv_patient/animations/fade_in_slide.dart';
import 'package:qv_patient/constants/colors.dart';
import 'package:qv_patient/constants/loading_overlay.dart';
import 'package:qv_patient/helper/responsive.dart';
import 'package:qv_patient/controllers/sign_up_controller.dart';
import 'package:qv_patient/view/Authentication/login_view.dart';
import 'package:qv_patient/models/patient_model.dart';
import 'package:qv_patient/view/Authentication/widgets/build_divider.dart';
import 'package:qv_patient/view/Authentication/widgets/build_sign_in_text.dart';
import 'package:qv_patient/view/Authentication/widgets/buildsignupbutton.dart';
import 'package:qv_patient/view/Authentication/widgets/buildsocialbutton.dart';
import 'package:qv_patient/view/Authentication/widgets/widgets.dart';

class SignUpView extends ConsumerStatefulWidget {
  const SignUpView({super.key});

  @override
  ConsumerState<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends ConsumerState<SignUpView> {
  ValueNotifier<bool> termsCheck = ValueNotifier(false);
  int? _selectedGender;
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? _verificationId;
  bool _isOtpSent = false;
  bool _isVerifying = false;

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneNumberController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _ageController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  Future<String> generateNewPatientId() async {
    DocumentReference idCounterRef = FirebaseFirestore.instance
        .collection('id_counters')
        .doc('patientcounter');

    DocumentSnapshot snapshot = await idCounterRef.get();
    String lastPatientId = snapshot.get('lastPatientId') as String;

    int currentIdNumber = int.parse(lastPatientId.substring(2));
    int newIdNumber = currentIdNumber + 1;

    String newPatientId = 'PI${newIdNumber.toString().padLeft(3, '0')}';

    await idCounterRef.update({'lastPatientId': newPatientId});

    return newPatientId;
  }

  Future<void> submitUserData(BuildContext context, WidgetRef ref) async {
    final String fullName = _fullNameController.text;
    final String phoneNumber = _phoneNumberController.text;
    final String email = _emailController.text;
    final String password = _passwordController.text;
    final String age = _ageController.text;

    String gender = 'Not Specified';
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

      final UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final String patientId = await generateNewPatientId();

      final PatientModel patient = PatientModel(
        patientId: patientId,
        fullName: fullName,
        phoneNumber: phoneNumber,
        email: email,
        age: age,
        gender: gender,
        profilePicUrl: 'https://example.com/default-profile-pic.png',
        reference:
            FirebaseFirestore.instance.collection('patients').doc(patientId),
      );

      await ref.read(patientControllerProvider).addPatient(context, patient);

      LoadingScreen.instance().hide();
      Navigator.pushReplacement(context,
          CupertinoPageRoute(builder: (context) => const SignInView()));

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Signup Successful! Please login to continue."),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      LoadingScreen.instance().hide();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Signup Failed: $e"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _sendOtp() async {
    final phoneNumber = _phoneNumberController.text.trim();
    setState(() {
      _isVerifying = true;
    });
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
          setState(() {
            _isVerifying = false;
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Verification failed: ${e.message}')),
          );
          setState(() {
            _isVerifying = false;
          });
        },
        codeSent: (String verificationId, int? resendToken) {
          setState(() {
            _verificationId = verificationId;
            _isOtpSent = true;
            _isVerifying = false;
          });
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          setState(() {
            _verificationId = verificationId;
            _isVerifying = false;
          });
        },
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
      setState(() {
        _isVerifying = false;
      });
    }
  }

  Future<void> _verifyOtp() async {
    final otp = _otpController.text.trim();
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: otp,
      );
      await _auth.signInWithCredential(credential);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Phone number verified!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  FadeInSlide buildTextFieldWithButton({
    required String labelText,
    required TextEditingController controller,
    required TextInputType keyboardType,
    required IconData icon,
    Widget? suffixIcon,
  }) {
    return FadeInSlide(
      duration: .5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            labelText,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: TColors.black,
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            style: const TextStyle(color: TColors.black),
            controller: controller,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color.fromARGB(255, 252, 252, 246),
              hintText: "Enter your $labelText...",
              prefixIcon: Icon(icon),
              suffixIcon: suffixIcon,
              prefixIconColor: Colors.black87,
              hintStyle: TextStyle(color: TColors.black.withOpacity(0.4)),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: TColors.black),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: TColors.black),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: TColors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Column buildPhoneNumberField() {
    return Column(
      children: [
        buildTextFieldWithButton(
          labelText: "Phone Number",
          controller: _phoneNumberController,
          keyboardType: TextInputType.number,
          icon: Icons.phone,
          suffixIcon: IconButton(
            onPressed: () async {
              if (!_isOtpSent && !_isVerifying) {
                await _sendOtp();
              }
            },
            icon: Icon(Icons.check, color: TColors.black),
          ),
        ),
        const SizedBox(height: 16.0),
        if (_isOtpSent)
          Column(
            children: [
              buildTextFieldWithButton(
                labelText: "OTP",
                controller: _otpController,
                keyboardType: TextInputType.number,
                icon: Icons.lock,
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _verifyOtp,
                child: const Text('Verify OTP'),
              ),
            ],
          ),
      ],
    );
  }

  Row buildGenderSelection() {
    return Row(
      children: [
        Expanded(
          child: ListTile(
            title: const Text(
              "Male",
              style: TextStyle(color: TColors.black),
            ),
            leading: Radio<int>(
              fillColor: const MaterialStatePropertyAll(TColors.primary),
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
              fillColor: const MaterialStatePropertyAll(TColors.primary),
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
    );
  }

  FadeInSlide buildTermsCheckBox() {
    return FadeInSlide(
      duration: .7,
      child: Row(
        children: [
          ValueListenableBuilder(
            valueListenable: termsCheck,
            builder: (context, value, child) {
              return CupertinoCheckbox(
                inactiveColor: Colors.black87,
                value: value,
                onChanged: (_) {
                  termsCheck.value = !termsCheck.value;
                },
              );
            },
          ),
          RichTwoPartsText(
            onTap: () {},
            text1: "I agree to DocBook ",
            text2: "Terms and Conditions.",
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 252, 252, 246),
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
                fontSize: Responsive.fontSize(context, 0.06),
              ),
            ),
          ),
          const SizedBox(height: 15),
          FadeInSlide(
            duration: .4,
            child: Text(
              "Join DocBook, Your Gateway to Smart Living.",
              style: TextStyle(
                color: TColors.black,
                fontSize: Responsive.fontSize(context, 0.04),
              ),
            ),
          ),
          const SizedBox(height: 25),
          buildTextFieldWithButton(
            labelText: "Full Name",
            controller: _fullNameController,
            keyboardType: TextInputType.name,
            icon: Iconsax.personalcard_bold,
          ),
          const SizedBox(height: 20),
          buildPhoneNumberField(),
          const SizedBox(height: 20),
          buildTextFieldWithButton(
            labelText: "Email",
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            icon: Iconsax.direct_inbox_bold,
          ),
          const SizedBox(height: 20),
          const FadeInSlide(
            duration: .6,
            child: Text(
              "Password",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: TColors.black,
              ),
            ),
          ),
          const SizedBox(height: 10),
          FadeInSlide(
            duration: .6,
            child: PasswordField(controller: _passwordController),
          ),
          const SizedBox(height: 20),
          buildTextFieldWithButton(
            labelText: "Age",
            controller: _ageController,
            keyboardType: TextInputType.number,
            icon: Icons.numbers,
          ),
          const SizedBox(height: 20),
          buildGenderSelection(),
          buildTermsCheckBox(),
          const SizedBox(height: 20),
          buildSignInText(context),
          const SizedBox(height: 30),
          buildOrDivider(),
          const SizedBox(height: 20),
          buildSocialButtons(isDark),
          SizedBox(height: height * 0.02),
        ],
      ),
      bottomNavigationBar: buildSignUpButton(
        () async {
          await submitUserData(context, ref);
        },
      ),
    );
  }
}
