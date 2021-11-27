
import 'package:compseviceuber/utility/my_constant.dart';
import 'package:compseviceuber/widgets/show_image.dart';
import 'package:compseviceuber/widgets/show_text.dart';
import 'package:flutter/material.dart';

class Mydialog {
  Future<void> normalDialog(
      BuildContext context, String title, String massage) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: ListTile(
          leading: ShowImage(),
          title: ShowText(
            data: title,
            textStyle: Myconstant().h2Style(),
          ),
          subtitle: ShowText(data: massage),
        ),actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK'))],
      ),
    );
  }
}
