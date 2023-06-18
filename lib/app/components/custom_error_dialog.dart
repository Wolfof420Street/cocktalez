
import 'package:flutter/material.dart';

void showErrorDialog(BuildContext context, String errorMessage) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        title: Text(
          'Error',
          style: Theme.of(context).textTheme.displayLarge,
        ),
        content: Text(
          errorMessage,
          style: Theme.of(context).textTheme.displayMedium,
        ),
        actions: <Widget>[
           ElevatedButton(
           onPressed: () {  Navigator.of(context).pop(); },
           child: const Text("Ok"),

          )
        ],
      );
    },
  );
}