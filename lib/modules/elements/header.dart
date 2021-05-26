import 'package:flutter/material.dart';

import '../../constants.dart';
enum HeaderSize {
  Medium,
  Large
}

class Header extends StatelessWidget {
  final String text;
  final HeaderSize size;

  Header({@required this.text, this.size = HeaderSize.Large});

  @override
  Widget build(BuildContext context) {
    var textStyle = size == HeaderSize.Large ?
    Constants().header :
    Constants().subheader;

    return Column(
      children: [
        SizedBox(height: 4,),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                text,
                style: textStyle,
              ),
            ),
          ),
        ),
        CustomDivider(),
      ],
    );
  }
}

class CustomDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20,
      ),
      child: Divider(
        color: Color.fromRGBO(211, 225, 231, 1),
        thickness: 1,
        //height: 10,
      ),
    );
  }
}