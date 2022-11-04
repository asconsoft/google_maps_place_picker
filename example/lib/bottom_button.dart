import 'package:flutter/material.dart';

class BottomButton extends StatelessWidget {
  final buttonName;
  final onPressed;

  const BottomButton({Key? key, this.buttonName, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 8,
          foregroundColor: const Color(0XFF8BC63E),
        ),
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            buttonName,
            style: const TextStyle(
                color: Color(0xFFFFFFFF),
                fontSize: 14,
                fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
