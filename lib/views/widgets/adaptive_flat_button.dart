import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

// Blueprint for adaptive flat button widget.
class AdaptiveFlatButton extends StatelessWidget {
  // Text inside button.
  final String text;
  // Handles action when user presses button.
  final Function handler;

  AdaptiveFlatButton(this.text, this.handler);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            onPressed: handler,
            child: Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        : FlatButton(
            textColor: Theme.of(context).primaryColor,
            onPressed: handler,
            child: Text(
              'Choose Date',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          );
  }
}
