import 'package:flutter/material.dart';
import 'package:group_chat/features/presentation/widgets/theme/style.dart';

class RowTextWidget extends StatelessWidget {
  final String title1;
  final String title2;
  final VoidCallback onTap;
  const RowTextWidget({super.key, required this.title1, required this.title2, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title1),
        const SizedBox(
          width: 10,
        ),
        InkWell(
          onTap: onTap,
          child:  Text(
            title2,
            style:  TextStyle(color: greenColor),
          ),
        ),
      ],
    );
  }
}
