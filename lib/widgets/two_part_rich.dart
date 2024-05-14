
import 'package:ayna_machine_test/theme/text_theme_ext.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

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
        style: context.tm?.copyWith(color: Colors.grey),
        text: text1,
        children: [
          TextSpan(
            text: text2,
            style: context.tm
                ?.copyWith(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 17),
            recognizer: TapGestureRecognizer()..onTap = onTap,
          ),
        ],
      ),
    );
  }
}