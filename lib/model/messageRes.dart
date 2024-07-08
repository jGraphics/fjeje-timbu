import 'package:flutter/material.dart';

void success({String? message, required BuildContext context}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Card(
      child: Container(
        padding: const EdgeInsets.all(8),
        height: 80,
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 29, 226, 19),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.check,
              color: Colors.white,
              size: 40,
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'success',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                const Spacer(),
                Text(message!,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ))
              ],
            ))
          ],
        ),
      ),
    ),
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    elevation: 0,
    duration: const Duration(seconds: 2),
    actionOverflowThreshold: 0.5,
  ));
}
