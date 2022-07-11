import 'package:flutter/material.dart';

import '../constFiles/strings.dart';
import '../controller/transDetailController.dart';

class DropBtn extends StatefulWidget {
  const DropBtn({Key? key}) : super(key: key);

  @override
  State<DropBtn> createState() => _DropBtnState();
}

class _DropBtnState extends State<DropBtn> {
  String dropdownvalue = others;
  static TransDetailController? transDetailController;
  // List of items in our dropdown menu
  var items = [
    health,
    family,
    shopping,
    food,
    vehicle,
    salon,
    devices,
    office,
    others
  ];
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      // Initial Value
      value: dropdownvalue,

      // Down Arrow Icon
      icon: const Icon(Icons.keyboard_arrow_down),

      // Array list of items
      items: items.map((String items) {
        return DropdownMenuItem(
          value: items,
          child: Text(items),
        );
      }).toList(),
      // After selecting the desired option,it will
      // change button value to selected value
      onChanged: (String? newValue) {
        setState(() {
          dropdownvalue = newValue!;

          transDetailController?.changeDepartment(newValue);
          transDetailController?.selectedDepartment = newValue;
          print(newValue);
        });
      },
    );
  }
}
