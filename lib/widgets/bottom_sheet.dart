import 'package:chatapp/widgets/icon_cration.dart';
import 'package:flutter/material.dart';

import '../res/colors.dart';

Widget bottomSheet(BuildContext context) {
  return Container(
    height: 278,
    width: MediaQuery.of(context).size.width,
    child: Card(
      margin: const EdgeInsets.all(18.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                iconCreation(
                    Icons.insert_drive_file, Colors.indigo, "Document"),
                const SizedBox(
                  width: 40,
                ),
                iconCreation(Icons.camera_alt, Colors.pink, "Camera"),
                const SizedBox(
                  width: 40,
                ),
                iconCreation(Icons.insert_photo, Colors.purple, "Gallery"),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                iconCreation(
                  Icons.headset,
                  Colors.orange,
                  "Audio",
                ),
                const SizedBox(
                  width: 40,
                ),
                iconCreation(
                  Icons.location_pin,
                  AppColors.primaryAppColor,
                  "Location",
                ),
                const SizedBox(
                  width: 40,
                ),
                iconCreation(
                  Icons.person,
                  Colors.blue,
                  "Contact",
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
