import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';

class Utils {
  static fieldFocusChange(
      BuildContext context, FocusNode current, FocusNode nextFocus) {
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  List<String?> extractNameReg(String? string) {
    String? input = string;

    RegExp regex = RegExp(r"^(.*?)\s(\w+)$");
    Match? match = regex.firstMatch(input!);

    String? formattedName = "";
    String? regNo = "";
    List<String> data = [formattedName, regNo];
    if (match != null) {
      formattedName = match.group(1)!;
      regNo = match.group(2)!;
      return data;
    } else {
      throw const FormatException("Cannot extract name and reg no");
    }
  }

  static flushBarErrorMessage(String message, BuildContext context) {
    showFlushbar(
      context: context,
      flushbar: Flushbar(
        message: message,
        forwardAnimationCurve: Curves.decelerate,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: const EdgeInsets.all(15),
        duration: const Duration(seconds: 3),
        borderRadius: BorderRadius.circular(2),
        flushbarPosition: FlushbarPosition.BOTTOM,
        backgroundColor: Colors.red,
        reverseAnimationCurve: Curves.easeInOut,
        positionOffset: 20,
        icon: const Icon(
          Icons.error,
          size: 28,
          color: Colors.white,
        ),
      )..show(context),
    );
  }

  static snackBar(String message, BuildContext context) {
    return ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
