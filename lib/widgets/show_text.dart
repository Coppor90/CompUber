import 'package:compseviceuber/utility/my_constant.dart';
import 'package:flutter/material.dart';

class ShowText extends StatelessWidget {
  final String data;
  final TextStyle? textStyle;
  const ShowText({ Key? key,required this.data, this.textStyle }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(data, style: textStyle ?? Myconstant().h3Style(),);
  }
}