import 'package:doctor_plus/View/Style/color_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FilterDialogButton extends StatelessWidget {
  const FilterDialogButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 18,
      backgroundColor: ColorManager.white,
      child: Icon(
        Icons.filter_list,
        color: ColorManager.black,
      ),
    );
  }
}
