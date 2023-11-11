import 'package:flutter/material.dart';

class DropdownListWithCheckbox extends StatefulWidget {
  //const DropdownListWithCheckbox({super.key});
  final List<String> allOptions;
  final List<String> selectedOptions;

  DropdownListWithCheckbox(
      {required this.allOptions, required this.selectedOptions});
  @override
  State<DropdownListWithCheckbox> createState() =>
      _DropdownListWithCheckboxState();
}

class _DropdownListWithCheckboxState extends State<DropdownListWithCheckbox> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      isExpanded: true,
      hint: Text('Select options'),
      items: widget.allOptions.map((String option) {
        return DropdownMenuItem(
          value: option,
          child: CheckboxListTile(
            title: Text(option),
            value: widget.selectedOptions.contains(option),
            onChanged: (value) {
              setState(() {
                if (value == true) {
                  widget.selectedOptions.add(option);
                } else {
                  widget.selectedOptions.remove(option);
                }
              });
            },
          ),
        );
      }).toList(),
      onChanged: (selectedValue) {
        // Handle dropdown value change
        // Not used in this example, but you can use it for other purposes
      },
    );
    ;
  }
}
