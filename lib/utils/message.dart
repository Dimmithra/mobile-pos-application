import 'package:flutter/material.dart';
// import 'package:reminder_v1/widgets/common_input.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

Alert errorMessage(
  context, {
  required String errorTxt,
  bool showIcon = true,
  int btnType = 1,
  List<DialogButton>? buttons,
}) =>
    Alert(
      onWillPopActive: buttons != null,
      context: context,
      style: const AlertStyle(
        backgroundColor: Colors.grey,
      ),
      closeIcon: Container(),
      content: Column(
        children: [
          if (showIcon)
            Icon(
              btnType == 1
                  ? Icons.error_outline_outlined
                  : btnType == 2
                      ? Icons.warning
                      : Icons.info_sharp,
              color: btnType == 1
                  ? Colors.red
                  : btnType == 2
                      ? Colors.amber
                      : Colors.blue,
              size: 35,
            ),
          if (showIcon)
            Text(
              btnType == 1
                  ? 'Error'
                  : btnType == 2
                      ? "Warning"
                      : "Information",
              style: TextStyle(
                color: btnType == 1
                    ? Colors.red
                    : btnType == 2
                        ? Colors.amber
                        : Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          // if (showIcon) Size.fromHeight(height),
          Text(
            errorTxt,
            style: TextStyle(
              fontSize: 17,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          )
        ],
      ),
      buttons: buttons ?? [],
    );
