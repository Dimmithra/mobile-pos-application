import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

// class CommonLoader extends StatelessWidget {
//   const CommonLoader({
//     super.key,
//     this.color,
//     this.secondRingColor,
//     this.thirdRingColor,
//   });

//   final Color? color;
//   final Color? secondRingColor;
//   final Color? thirdRingColor;
//   @override
//   Widget build(BuildContext context) {
//     return LoadingAnimationWidget.discreteCircle(
//       color: color ?? Colors.blue,
//       size: 40,
//       secondRingColor: secondRingColor ?? Colors.orange,
//       thirdRingColor: thirdRingColor ?? Colors.green,
//     );
//   }
// }

import 'package:flutter/widgets.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mobile_pos/utils/color.dart';

class CommonLoader extends StatelessWidget {
  const CommonLoader({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.prograssiveDots(
        color: kLoaderColor,
        size: 75,
      ),
    );
  }
}
