import 'package:flutter/material.dart';

import '../controller/reportController.dart';

class CategorySelector extends StatelessWidget {
  const CategorySelector({
    Key? key,
    required this.reportController,
    required this.text,
    required this.onPress,
    required this.textColor,
    required this.containerColor,
  }) : super(key: key);

  final ReportController reportController;
  final String text;
  final Function() onPress;
  final Color textColor;
  final Color containerColor;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onPress,
        child: Container(
          padding: const EdgeInsets.all(15.0),
          decoration: BoxDecoration(
              color: containerColor,
              borderRadius: const BorderRadius.all(Radius.circular(15.0))),
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
