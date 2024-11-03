

import 'package:flutter/material.dart';
import 'package:group_chat/features/presentation/widgets/theme/style.dart';

class TextFieldContainer extends StatelessWidget {
  final TextEditingController? controller;
  final bool? isObscureText;
  final String? hintText;
  final IconData? prefixIcon;
  final TextInputType? keyboardType;
  const TextFieldContainer({super.key,this.keyboardType,this.prefixIcon,this.hintText,this.controller,this.isObscureText});

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 45,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: color747480.withOpacity(.2),
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: TextField(
        obscureText: isObscureText==true?true:false,
        keyboardType: keyboardType ?? TextInputType.text,
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: Icon(prefixIcon ?? Icons.circle),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
