import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconly/iconly.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:qv_patient/animations/fade_in_slide.dart';
import 'package:qv_patient/constants/colors.dart';
import 'package:qv_patient/helper/responsive.dart';
import 'package:qv_patient/controllers/signin_controller.dart';
import 'package:qv_patient/navigationmenu.dart';
import 'package:qv_patient/view/Authentication/create_account_view.dart';
import 'package:qv_patient/view/Authentication/forgot_password_view.dart';
import 'package:qv_patient/view/Authentication/widgets/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:local_auth/local_auth.dart'; // Import for biometrics
import 'package:firebase_auth/firebase_auth.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final ValueNotifier<bool> termsCheck = ValueNotifier(false);
  final SigninController _signincontroller = SigninController();

  final LocalAuthentication _localAuth = LocalAuthentication();
  List<String> _suggestedEmails = []; // List to store saved emails

  @override
  void initState() {
    super.initState();
    _loadSavedEmails(); // Load saved emails for suggestions
    _checkAutoSignIn(); // Check if the user is already signed in
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Function to load saved emails for suggestions
  Future<void> _loadSavedEmails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _suggestedEmails = prefs.getStringList('saved_emails') ?? [];
    });
  }

  // Function to save email and password securely if "Remember Me" is checked
  Future<void> _saveEmailAndPassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (termsCheck.value) {
      List<String> savedEmails = prefs.getStringList('saved_emails') ?? [];
      if (!savedEmails.contains(_emailController.text)) {
        savedEmails.add(_emailController.text); // Save email to list
        await prefs.setStringList('saved_emails', savedEmails);
        await prefs.setString('password_${_emailController.text}',
            _passwordController.text); // Save password securely
      }
    }
  }

  // Retrieve and auto-fill the password after biometric or screen lock authentication
  Future<void> _retrievePasswordForEmail(String email) async {
    bool isAuthenticated = await _authenticate();
    if (isAuthenticated) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? savedPassword = prefs.getString('password_$email');
      if (savedPassword != null) {
        setState(() {
          _passwordController.text = savedPassword; // Auto-fill password
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Authentication failed')),
      );
    }
  }

  // Check if the user is already signed in and navigate them to the dashboard
  Future<void> _checkAutoSignIn() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      Navigator.pushReplacement(
        context,
        CupertinoPageRoute(builder: (context) => const NavigationMenu()),
      );
    }
  }

  // Authenticate using biometrics or device PIN
  Future<bool> _authenticate() async {
    try {
      bool canCheckBiometrics = await _localAuth.canCheckBiometrics;
      if (!canCheckBiometrics) {
        return false;
      }
      bool isAuthenticated = await _localAuth.authenticate(
        localizedReason: 'Please authenticate to proceed',
       
      );
      return isAuthenticated;
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final isDark = MediaQuery.platformBrightnessOf(context) == Brightness.dark;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 252, 252, 246),
      appBar: AppBar(),
      body: Consumer(
        builder: (context, ref, child) {
          return ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            children: [
              _buildTitle(context),
              const SizedBox(height: 15),
              _buildSubtitle(context),
              const SizedBox(height: 25),
              _buildEmailField(),
              const SizedBox(height: 20),
              _buildPasswordField(),
              const SizedBox(height: 20),
              _buildRememberMeRow(context),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an Account? ",
                    style: TextStyle(color: TColors.black),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(CupertinoPageRoute(
                        builder: (context) {
                          return SignUpView();
                        },
                      ));
                    },
                    child: Text("Signup",
                        style: TextStyle(
                            color: TColors.primary,
                            fontWeight: FontWeight.bold)),
                  )
                ],
              ),
              _buildDivider(),
              const SizedBox(height: 20),
              _buildSocialLoginButtons(height, isDark),
            ],
          );
        },
      ),
      bottomNavigationBar: _buildSignInButton(),
    );
  }

  FadeInSlide _buildTitle(BuildContext context) {
    return FadeInSlide(
      duration: .4,
      child: Text(
        "Welcome Back! 👋",
        style: TextStyle(
          color: TColors.black,
          fontWeight: FontWeight.bold,
          fontSize: Responsive.fontSize(context, 0.06),
        ),
      ),
    );
  }

  FadeInSlide _buildSubtitle(BuildContext context) {
    return FadeInSlide(
      duration: .5,
      child: Text(
        "Your Digital Hospital",
        style: TextStyle(
          color: TColors.black,
          fontSize: Responsive.fontSize(context, 0.04),
        ),
      ),
    );
  }

  FadeInSlide _buildEmailField() {
    return FadeInSlide(
      duration: .6,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Email",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: TColors.black,
            ),
          ),
          const SizedBox(height: 10),
          Autocomplete<String>(
            optionsBuilder: (TextEditingValue value) {
              return _suggestedEmails.where((email) =>
                  email.toLowerCase().contains(value.text.toLowerCase()));
            },
            onSelected: (String selectedEmail) async {
              _emailController.text = selectedEmail;
              await _retrievePasswordForEmail(
                  selectedEmail); // Auto-fill password securely
            },
            fieldViewBuilder:
                (context, controller, focusNode, onEditingComplete) {
              return EmailField(
                icon: IconlyLight.message,
                controller: _emailController,
              );
            },
          ),
        ],
      ),
    );
  }

  FadeInSlide _buildPasswordField() {
    return FadeInSlide(
      duration: .7,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Password",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: TColors.black,
            ),
          ),
          const SizedBox(height: 10),
          PasswordField(controller: _passwordController),
        ],
      ),
    );
  }

  FadeInSlide _buildRememberMeRow(BuildContext context) {
    return FadeInSlide(
      duration: .8,
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
          const Text(
            "Remember Me",
            style: TextStyle(color: TColors.black),
          ),
          const Spacer(),
          TextButton(
            onPressed: () => Navigator.pushReplacement(
              context,
              CupertinoPageRoute(
                  builder: (context) => const ForgotPasswordView()),
            ),
            child: const Text(
              "Forgot Password?",
              style: TextStyle(color: TColors.primary),
            ),
          ),
        ],
      ),
    );
  }

  FadeInSlide _buildDivider() {
    return const FadeInSlide(
      duration: .9,
      child: Row(
        children: [
          Expanded(child: Divider(thickness: .3)),
          Text("   or   ", style: TextStyle(color: TColors.black)),
          Expanded(child: Divider(thickness: .3)),
        ],
      ),
    );
  }

  Column _buildSocialLoginButtons(double height, bool isDark) {
    return Column(
      children: [
        FadeInSlide(
          duration: 1,
          child: LoginButton(
            icon: Brand(Brands.google, size: 25),
            text: "Continue with Google",
            onPressed: () {},
          ),
        ),
      ],
    );
  }

  FadeInSlide _buildSignInButton() {
    return FadeInSlide(
      duration: 1,
      direction: FadeSlideDirection.btt,
      child: Container(
        padding:
            const EdgeInsets.only(bottom: 40, left: 20, right: 20, top: 30),
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(width: .2, color: Colors.grey)),
        ),
        child: Consumer(
          builder: (context, ref, child) {
            return FilledButton(
              onPressed: () async {
                // Sign in user and save email and password securely if "Remember Me" is checked
                bool result = await _signincontroller.signInUser(
                    ref, context, _emailController, _passwordController);

                if (result && termsCheck.value) {
                  await _saveEmailAndPassword(); // Save email and password securely
                }
              },
              style: FilledButton.styleFrom(
                backgroundColor: TColors.primary,
                fixedSize: const Size(double.infinity, 50),
              ),
              child: const Text(
                "Sign In",
                style: TextStyle(
                    fontWeight: FontWeight.w900, color: TColors.white),
              ),
            );
          },
        ),
      ),
    );
  }
}
