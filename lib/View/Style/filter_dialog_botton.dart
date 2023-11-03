import 'package:doctor_plus/View/Style/color_manager.dart';
import 'package:doctor_plus/View/Widgets/filter_dialog.dart';
import 'package:flutter/material.dart';

class FilterDialogBotton extends StatelessWidget {
  const FilterDialogBotton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(context: context, builder: (context) => FilterDialog());
      },
      child: const CircleAvatar(
        backgroundColor: Colors.black,
        child: Icon(Icons.filter_list, color: Colors.white),
      ),
    );
  }
}
