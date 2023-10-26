import 'package:flutter/material.dart';
import 'package:doctor_plus/Model/patient.dart';
import 'package:doctor_plus/View/Widgets/patient_card_title.dart';
import 'package:doctor_plus/Controller/firestore_crud.dart';

class SearchBlock extends StatefulWidget {
  // crud operation opject

  SearchBlock();
  @override
  _SearchBlockState createState() => _SearchBlockState();
}

class _SearchBlockState extends State<SearchBlock> {
  // This controller will store the value of the search bar
  final TextEditingController _searchController = TextEditingController();
  List<Patient> _AllpatientList = [];
  List<Patient> _filteredList = [];
  _SearchBlockState();

  // create intial state
  @override
  void initState() {
    firestroeCRUD db = firestroeCRUD();
    _AllpatientList = db.getPatients();
    setState(() {
      _AllpatientList.sort((a, b) => a.name!.compareTo(b.name!));
      _filteredList = _AllpatientList;
      super.initState();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void filterPatientsBySearchText(String searchText) {
    setState(() {
      _filteredList = _AllpatientList.where((_patient) =>
              _patient.name!.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('flutterassets.com'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              _searchBox(_searchController, filterPatientsBySearchText),
              const SizedBox(
                height: 8,
              ),
              Expanded(
                child: _buildList(_filteredList, context),
              )
            ],
          )),
    );
  }
}

// serach block
Widget _searchBox(
    TextEditingController _searchController, Function filterBySearchText) {
  return Container(
    // Add padding around the search bar
    padding: const EdgeInsets.symmetric(horizontal: 8.0),
    // Use a Material design search bar
    child: TextField(
      controller: _searchController,
      decoration: InputDecoration(
        hintText: 'Search...',
        // clear button to the search bar
        suffixIcon: IconButton(
          icon: Icon(Icons.clear),
          onPressed: () => _searchController.clear(),
        ),
        // search icon or button to the search bar
        prefixIcon: IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            // Perform the search here
          },
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      onChanged: (value) => filterBySearchText(value),
      onSubmitted: (value) => filterBySearchText(value),
    ),
  );
}

// patients list widget
Widget _buildList(List patientList, BuildContext context) {
  return ListView.builder(
      itemCount: patientList.length,
      itemBuilder: (BuildContext context, int index) {
        Patient data = patientList[index];
        return Card(
          elevation: 8.0,
          child: Container(
            child: cardTitle(data, context),
          ),
        );
      });
}
