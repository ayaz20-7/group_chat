import 'package:flutter/material.dart';
import 'package:group_chat/features/presentation/widgets/header_widget.dart';
import 'package:group_chat/features/presentation/widgets/theme/style.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 32),
          child: Column(
            children: [
              const HeaderWidget(title: "Registration"),
              const SizedBox(
                height: 10,
              ),
              _profileWidget(),
              const SizedBox(
                height: 10,
              ),

            ],
          ),
        ),
      ),
    );
  }
}

Widget _profileWidget() {
  return Column(
    children: [
      Container(
        height: 82,
        width: 82,
        decoration: const BoxDecoration(
          color: Colors.grey,
          shape: BoxShape.circle,
        ),
        child: Image.asset("assets/profile_pic.jpg",fit: BoxFit.cover,),
      ),
      const SizedBox(
        height: 22,
      ),
       Text(
        "Add Profile Photo",
        style: TextStyle(color: greenColor),
      )
    ],
  );
}
