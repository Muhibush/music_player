import 'package:flutter/material.dart';

class TextFieldAtom extends StatelessWidget {
  final String hintText;
  final Function(String str) onChanged;

  const TextFieldAtom(
      {Key? key, required this.onChanged, required this.hintText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hintText,
        border: InputBorder.none,
      ),
      onChanged: onChanged,
    );
  }
}
