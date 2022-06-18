import 'package:flutter/material.dart';

Widget textForm(
    {TextEditingController? controller,
    required String text,
    required IconData icon}) {
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: TextFormField(
      controller: controller,
      decoration: InputDecoration(
          label: Text(text), icon: Icon(icon), border: OutlineInputBorder()),
    ),
  );
}
