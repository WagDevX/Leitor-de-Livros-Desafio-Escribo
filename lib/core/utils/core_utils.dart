import 'package:flutter/material.dart';

class CoreUtils {
  const CoreUtils._();

  static void showSnackBar(BuildContext context, String message, bool loader) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          duration: loader
              ? const Duration(milliseconds: 6000)
              : const Duration(milliseconds: 4000),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.blueAccent,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          margin: const EdgeInsets.all(10),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                message,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              loader
                  ? const SizedBox(
                      width: 5,
                    )
                  : const SizedBox(
                      width: 0,
                    ),
              loader
                  ? const Center(child: CircularProgressIndicator.adaptive())
                  : Container()
            ],
          ),
        ),
      );
  }
}
