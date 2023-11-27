import 'package:flutter/material.dart';

class SignUpUtils {
  final TextEditingController emailTextEditingCOntroller = TextEditingController();
  final TextEditingController passwordTextEditingController = TextEditingController();
  final TextEditingController confirmPasswordTextEditingController = TextEditingController();
  final GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();
}