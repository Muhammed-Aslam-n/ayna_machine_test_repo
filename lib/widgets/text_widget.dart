import 'package:flutter/material.dart';

class SendMessageTextWidget extends StatelessWidget {
  const SendMessageTextWidget({
    super.key, required this.controller
  });

  final TextEditingController controller;


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTapOutside: (event) =>
          FocusManager.instance.primaryFocus!.unfocus(),
      controller: controller,
      // cursorColor: isDark ? Colors.grey : Colors.black54,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.blueGrey.withOpacity(.1),
        hintText: "Enter your message",

        // prefixIconColor: isDark ? Colors.white : Colors.black87,
        // suffixIconColor: isDark ? Colors.white : Colors.black87,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
      ),
      validator: (String? message) {
        if (message == null || message.isEmpty) {
          return 'Field is Empty';
        }
        return null;
      },
    );
  }
}
