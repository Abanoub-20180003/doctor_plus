import 'package:doctor_plus/View/Style/color_manager.dart';
import 'package:flutter/material.dart';

// class kFilterDialog extends StatelessWidget {
//   final List<String> drugs = ['d1', 'd2', 'd3'];
//   List<String>? selectedDrugs;

//   //const FilterDialog({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       backgroundColor: Colors.grey,
//       child: Padding(
//         padding: const EdgeInsets.all(10.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             _buildTextWidget("Gender"),
//             _buildTextWidget("Age Rnage"),
//             _buildTextWidget("Patients With Certain Drugs"),
//             DropdownButtonFormField(
//           isExpanded: true,
//           hint: Text('Select options'),
//           items: drugs.map((String drug) {
//             return DropdownMenuItem(
//               value: drug,
//               child: CheckboxListTile(
//                 title: Text(drug),
//                 value: selectedDrugs.contains(drug),
//                 onChanged: (bool !value) {
//                   setState(() {
//                     if (value) {
//                       selectedDrugs!.add(drug);
//                     } else {
//                       selectedDrugs!.remove(drug);
//                     }
//                   });
//                 },
//               ),
//             );
//           }).toList(),
//           onChanged: (String selectedValue) {
//             // Handle dropdown value change
//             // Not used in this example, but you can use it for other purposes
//           },
//         ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildTextWidget(String text) {
//     return Text(
//       text,
//       style: TextStyle(
//         fontSize: 18,
//         color: Colors.white,
//         fontWeight: FontWeight.bold,
//       ),
//     );
//   }
// }

class FilterDialog extends StatefulWidget {
  @override
  _FilterDialogState createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  List<String> options = ['Option 1', 'Option 2', 'Option 3', 'Option 4'];
  List<String> selectedOptions = [];

  List<String> options2 = ['Option 1', 'Option 2', 'Option 3', 'Option 4'];
  List<String> selectedOptions2 = [];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.grey,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _buildTextWidget("Chosse Medial Test"),
            _customDropdown(options, selectedOptions),
            SizedBox(height: 10),
            Text('Selected Options: ${selectedOptions.join(', ')}'),
            SizedBox(
              height: 20,
            ),
            _buildTextWidget("Chosse Drugs"),
            _customDropdown(options2, selectedOptions2),
            SizedBox(height: 10),
            Text('Selected Options: ${selectedOptions.join(', ')}'),
            SizedBox(height: 10),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: Text("Reset"),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red, // Set the background color to red
                  ),
                ),
                Spacer(),
                ElevatedButton(
                  onPressed: () {},
                  child: Text("Apply"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  DropdownButtonFormField<String> _customDropdown(
      List<String> allOptions, List<String> selectedOptions) {
    return DropdownButtonFormField(
      isExpanded: true,
      hint: Text('Select options'),
      items: allOptions.map((String option) {
        return DropdownMenuItem(
          value: option,
          child: CheckboxListTile(
            title: Text(option),
            value: selectedOptions.contains(option),
            onChanged: (value) {
              setState(() {
                if (value == true) {
                  selectedOptions.add(option);
                } else {
                  selectedOptions.remove(option);
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
  }

  Widget _buildTextWidget(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 18,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
