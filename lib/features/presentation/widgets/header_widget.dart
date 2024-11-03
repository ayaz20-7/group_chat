import 'package:flutter/material.dart';
import 'package:group_chat/features/presentation/widgets/theme/style.dart';

class HeaderWidget extends StatelessWidget {
  final String title;
  const HeaderWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Container(
          alignment: Alignment.topLeft,
          child:  Text(
            title,
            style:  TextStyle(
                fontSize: 35,
                color: greenColor,
                fontWeight: FontWeight.w700),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Divider(
          thickness: 1,
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
