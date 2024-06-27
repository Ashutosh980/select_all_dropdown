import 'package:flutter/material.dart';
import 'package:select_all_dropdown/src/drop_down_multi_select.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Select All Dropdown Example'),
        ),
        body: Center(
          child: DropdownExample(),
        ),
      ),
    );
  }
}

class DropdownExample extends StatefulWidget {
  @override
  _DropdownExampleState createState() => _DropdownExampleState();
}

class _DropdownExampleState extends State<DropdownExample> {
  List<String> _selectedValues = [];
  final List<String> _options = ['Option 1', 'Option 2', 'Option 3', 'Option 4'];

  @override
  Widget build(BuildContext context) {
    return DropDownMultiSelect<String>(
      options: _options,
      selectedValues: _selectedValues,
      onChanged: (List<String> newValue) {
        setState(() {
          _selectedValues = newValue;
        });
      },
      whenEmpty: 'Select options',
      icon: Icon(Icons.arrow_drop_down),
      hint: Text('Choose options'),
    );
  }
}
