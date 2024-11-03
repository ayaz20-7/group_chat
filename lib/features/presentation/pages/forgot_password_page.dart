import 'package:flutter/material.dart';
import 'package:group_chat/features/presentation/widgets/container_button_widget.dart';
import 'package:group_chat/features/presentation/widgets/header_widget.dart';
import 'package:group_chat/features/presentation/widgets/row_text_widget.dart';
import 'package:group_chat/features/presentation/widgets/textfield_container.dart';

import '../../../const.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 32),
          child: Column(
            children: [
              const HeaderWidget(title: "Forgot Password"),
              const SizedBox(
                height: 20,
              ),
              const Text(
                  "Don't worry! Just Fill in your email and ${AppConst.appName} will send your password"),
              const SizedBox(
                height: 20,
              ),
              TextFieldContainer(
                  controller: _emailController,
                  prefixIcon: Icons.email,
                  keyboardType: TextInputType.emailAddress),
              const SizedBox(
                height: 20,
              ),
              ContainerButtonWidget(title: "Send Password Reset Email", onTap:(){

              } ),
              const SizedBox(
                height: 20,
              ),
              RowTextWidget(title1: "Remember the account information?", title2: 'Login', onTap: () {
                Navigator.pushNamedAndRemoveUntil(context, PageConst.loginPage, (route)=>false);
              },),
            ],
          ),
        ),
      ),
    );
  }
}
