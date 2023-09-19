import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../core/palette.dart';

void logOutConfirmationDialog({
  required BuildContext context,
  required VoidCallback onConfirm,
}) {
  EdgeInsets? insetPadding =
      const EdgeInsets.symmetric(horizontal: 32.0, vertical: 24.0);
  final height = MediaQuery.of(context).size.height * .18;
  final width = MediaQuery.of(context).size.width * .35;
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
        child: AlertDialog(
          elevation: 0,
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
          ),
          insetPadding: const EdgeInsets.all(0),
          content: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SizedBox(
              height: height,
              width: width,
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        'Are You sure want to LogOut',
                        style: TextStyle(fontSize: 20),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            onPressed: () => Navigator.pop(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: grayColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: const Text("NO"),
                          ),
                          ElevatedButton(
                              onPressed: onConfirm,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: const Text("YES")),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}
