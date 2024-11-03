

import 'package:flutter/material.dart';

class CustomDeafTextFieldWidget extends StatefulWidget {
  final TextEditingController? textEditingController;
  const CustomDeafTextFieldWidget({super.key,this.textEditingController});

  @override
  CustomDeafTextFieldWidgetState createState() => CustomDeafTextFieldWidgetState();
}

class CustomDeafTextFieldWidgetState extends State<CustomDeafTextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return   Expanded(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(80)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.2),
                offset: const Offset(0.0, 0.50),
                spreadRadius: 1,
                blurRadius: 1,
              )
            ]),
        child: Row(
          children: [
            const SizedBox(width: 10,),
            Expanded(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 60),
                child: Scrollbar(
                  child: TextField(
                    autofocus: true,
                    style: const TextStyle(fontSize: 14),
                    controller: widget.textEditingController,
                    maxLines: null,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Type a message"),
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Icon(
                  Icons.link,
                  color: Colors.grey[500],
                ),
                const SizedBox(
                  width: 10,
                ),
                widget.textEditingController!.text.isEmpty
                    ? Icon(
                  Icons.camera_alt,
                  color: Colors.grey[500],
                )
                    : const Text(""),
              ],
            ),
            const SizedBox(
              width: 15,
            ),
          ],
        ),
      ),
    );
  }



}
