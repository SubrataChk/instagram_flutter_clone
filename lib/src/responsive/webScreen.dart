import 'package:flutter/material.dart';

class WebScreenLayoutSection extends StatefulWidget {
  const WebScreenLayoutSection({Key? key}) : super(key: key);

  @override
  State<WebScreenLayoutSection> createState() => _WebScreenLayoutSectionState();
}

class _WebScreenLayoutSectionState extends State<WebScreenLayoutSection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("This is web"),
      ),
    );
  }
}
