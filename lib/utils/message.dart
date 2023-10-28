import 'package:flutter/material.dart';
import 'package:mobile_pos/utils/color.dart';
// import 'package:reminder_v1/widgets/common_input.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

Alert commonMessage(
  context, {
  required String errorTxt,
  bool showIcon = true,
  int btnType = 1,
  List<DialogButton>? buttons,
}) =>
    Alert(
      onWillPopActive: buttons != null,
      context: context,
      style: AlertStyle(backgroundColor: Colors.blue[50]),
      closeIcon: Container(),
      content: Column(
        children: [
          if (showIcon)
            Icon(
              btnType == 1
                  ? Icons.error_rounded
                  : btnType == 2
                      ? Icons.warning
                      : Icons.info_sharp,
              color: btnType == 1
                  ? kErrorColor
                  : btnType == 2
                      ? kWarningColor
                      : kSuccessColor,
              size: 35,
            ),
          if (showIcon)
            Text(
              btnType == 1
                  ? 'Error Message'
                  : btnType == 2
                      ? "Warning Message"
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
          Text(
            errorTxt,
            style: TextStyle(
                fontSize: 16, height: 1.5, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          )
        ],
      ),
      buttons: buttons ?? [],
    );
