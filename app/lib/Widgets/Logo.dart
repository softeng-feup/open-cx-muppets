import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  static final Image _image = Image.asset('assets/images/NameLogoWhite.png');
  final double width;
  final EdgeInsetsGeometry padding;

  Logo({
    @required this.width,
    this.padding = const EdgeInsets.all(0.0)
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      width: width,
      child: _image,
    );
  }
}


class BlackLogo extends StatelessWidget {
  static final Image _image = Image.asset('assets/images/NameLogo.png');
  final double width;
  final EdgeInsetsGeometry padding;

  BlackLogo({
    @required this.width,
    this.padding = const EdgeInsets.all(0.0)
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      width: width,
      child: _image,
    );
  }
}