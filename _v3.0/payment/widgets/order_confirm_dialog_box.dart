import 'package:flutter/material.dart';

import 'dart:ui';

import '../../../core/palette.dart';
import '../../trackOrder/screens/track_order_screen.dart';

class OrderConfirmDialog extends StatelessWidget {
  const OrderConfirmDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
      child: AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        insetPadding: const EdgeInsets.all(0),
        content: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SizedBox(
            height: 330,
            child: Center(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        color: primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(50)),
                    child: const Icon(
                      Icons.check_rounded,
                      weight: 25,
                      color: primaryColor,
                      size: 50,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    'Order Successfully',
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Your order id#5466 successfully placed',
                    style: TextStyle(fontSize: 15, color: blackColorShade1),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: primaryColor,
                        padding: const EdgeInsets.symmetric(
                          vertical: 15,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => TrackOrderScren(),
                            ));
                      },
                      child: const Text(
                        'Track My Order',
                        style: TextStyle(fontSize: 22),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextButton(
                    child: const Text(
                      "Go Back",
                      style: TextStyle(fontSize: 20, color: blackColor),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
