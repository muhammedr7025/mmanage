import 'dart:io';
import 'package:flutter/material.dart';

import '../constFiles/colors.dart';

class UserProfileCard extends StatelessWidget {
  static File? imageFile;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 50.0,
          width: 50.0,
          decoration: const BoxDecoration(
              color: profileContainer,
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          child: imageFile == null
              ? const Icon(Icons.person, size: 35, color: profileBG)
              : Image.file(imageFile!, fit: BoxFit.contain),
        ),
        const SizedBox(width: 15.0),
        Expanded(
          child: SizedBox(
            height: 50,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Welcome Back,",
                  style:
                      TextStyle(color: greyText, fontWeight: FontWeight.bold),
                ),
                Text(
                  "USER",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
