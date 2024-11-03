import 'package:flutter/material.dart';
import 'package:group_chat/features/presentation/widgets/theme/style.dart';

class ContainerButtonWidget extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const ContainerButtonWidget({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          alignment: Alignment.center,
          height: 50,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: greenColor, borderRadius: BorderRadius.circular(10)),
          child:  Text(title,
              style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w500))),
    );
  }
}
