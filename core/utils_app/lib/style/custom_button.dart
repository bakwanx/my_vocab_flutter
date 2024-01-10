import 'package:flutter/material.dart'
;

import 'custom_style.dart';
class CustomButton extends StatelessWidget {
  final double? width, height;
  final Function() onPressed;
  final String? textButton;
  final Color? buttonColor;
  final Color? textColor;
  final String? iconButton;
  final EdgeInsets? margin;
  final Color? borderColor;

  const CustomButton({
    super.key,
    this.width,
    this.height,
    required this.onPressed,
    this.textButton,
    this.buttonColor,
    this.textColor,
    this.iconButton,
    this.margin,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: SizedBox(
        height: height,
        width: width,
        child: TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            backgroundColor: buttonColor ?? primaryColor,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: borderColor ?? primaryColor ,
              ),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          child: iconButton != null
              ? Image.asset(
            iconButton!,
            width: 20,
          )
              : Text(
            textButton ?? "",
            style: Typo.h4.copyWith(
                color: textColor ?? Colors.white,
                fontSize: 14
            ),
          ),
        ),
      ),
    );
  }
}
