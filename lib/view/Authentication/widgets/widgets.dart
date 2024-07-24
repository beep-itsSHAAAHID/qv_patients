import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:qv_patient/constants/colors.dart';
import 'package:qv_patient/helper/doc_helper_function.dart';

class LoginButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget icon;
  final String text;
  const LoginButton({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.white.withOpacity(.05),
        side: BorderSide(color: TColors.primary, width: 1),
        fixedSize: const Size.fromHeight(50),
        padding: const EdgeInsets.symmetric(horizontal: 15),
      ),
      child: Stack(
        children: [
          Align(
              alignment: Alignment.center,
              child: Text(
                text,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              )),
          Align(alignment: Alignment.centerLeft, child: icon),
        ],
      ),
    );
  }
}

class RichTwoPartsText extends StatelessWidget {
  final String text1;
  final String text2;
  final VoidCallback onTap;
  const RichTwoPartsText({
    super.key,
    required this.text1,
    required this.text2,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: text1,
        style: const TextStyle(color: TColors.black),
        children: [
          TextSpan(
            text: text2,
            style: const TextStyle(fontWeight: FontWeight.bold),
            recognizer: TapGestureRecognizer()..onTap = onTap,
          ),
        ],
      ),
    );
  }
}

class PasswordField extends StatefulWidget {
  final TextEditingController? controller;

  const PasswordField({
    this.controller,
    Key? key,
  }) : super(key: key);

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    final dark = DocHelperFunctions.isDarkMode(context);
    return TextField(
      style: TextStyle(color: TColors.black),
      controller: widget.controller,
      obscureText: _obscureText,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color.fromARGB(255, 252, 252, 246),
        hintText: "Enter password...",
        hintStyle: TextStyle(color: TColors.black.withOpacity(0.4)),
        prefixIcon: const Icon(IconlyLight.lock, size: 20),
        suffixIcon: IconButton(
          icon: Icon(
            _obscureText ? IconlyLight.hide : IconlyLight.show,
            size: 20,
          ),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ),
        prefixIconColor: Colors.black87,
        suffixIconColor: Colors.black87,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: TColors.black),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: TColors.black),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: TColors.black),
        ),
      ),
    );
  }
}

class EmailField extends StatelessWidget {
  final TextInputType? keyboardType;
  final String? hinttext;
  final IconData? icon;
  final TextEditingController? controller;

  const EmailField({
    this.controller,
    this.keyboardType,
    this.hinttext,
    this.icon,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dark = DocHelperFunctions.isDarkMode(
        context); // Ensure this function exists and works as expected
    return TextField(
      style: TextStyle(color: TColors.black),
      controller: controller, // Use the controller
      keyboardType: keyboardType,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color.fromARGB(255, 252, 252, 246),
        hintText: hinttext ?? "Enter your email...",
        prefixIcon: icon != null ? Icon(icon) : null,
        prefixIconColor: Colors.black87,
        hintStyle: TextStyle(color: TColors.black.withOpacity(0.4)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: TColors.black),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: TColors.black),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: TColors.black),
        ),
      ),
    );
  }
}
