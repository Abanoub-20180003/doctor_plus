import 'package:flutter/material.dart';

class DrugTable extends StatefulWidget {
  @override
  _DrugTableState createState() => _DrugTableState();
}

class _DrugTableState extends State<DrugTable> {
  // List to store the drug names
  List<String> drugNames = ['Drug A', 'Drug B', 'Drug C'];
  List<TableRow> tableRows = [];

  // Initialize the table with one empty row
  @override
  void initState() {
    super.initState();
    tableRows.add(createTableRow());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Table(
          border: TableBorder.all(),
          children: tableRows,
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              // Add a new empty row when the plus button is pressed
              tableRows.add(createTableRow());
            });
          },
          child: Icon(Icons.add),
        ),
      ],
    );
  }

  // Create a new row with dropdown and input fields
  TableRow createTableRow() {
    return TableRow(
      children: [
        DropdownButtonFormField<String>(
          items: drugNames.map((drugName) {
            return DropdownMenuItem<String>(
              value: drugName,
              child: Text(drugName),
            );
          }).toList(),
          onChanged: (String? selectedDrug) {
            // Handle selected drug
          },
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Quantity'),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Start Date'),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Notes'),
        ),
      ],
    );
  }
}
