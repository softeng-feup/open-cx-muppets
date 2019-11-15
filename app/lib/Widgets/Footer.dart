import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  final Color color;

  Footer({
    @required this.color
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: color,
      ),
      child: Center(
        child: Text("©OpenCX-Muppets 2019",
            style: TextStyle(fontSize: 14, color: Colors.white)),
      ),
    );
  }
}
