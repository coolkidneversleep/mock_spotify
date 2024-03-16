import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton({
    super.key,
    required this.iconData,
    required this.onPressed,
  });
  IconData iconData;
  void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onPressed,
      child: Container(
        width: 35,
        height: 35,
        padding: const EdgeInsets.fromLTRB(6, 6, 6, 6),
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 26, 25, 25),
          shape: BoxShape.circle,
        ),
        child: Icon(
          iconData,
          color: Colors.white,
          size: 20,
        ),
      ),
    );
  }
}
