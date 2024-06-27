# select_all_dropdown

select_all_dropdown is a highly customizable and user-friendly Flutter package that provides a multi-select dropdown with a convenient "Select All" feature. It allows users to select multiple items from a list with ease and efficiency, making it an ideal choice for forms, filtering options, and settings screens.


## Features

- Multi-Select Functionality: Easily select multiple items from a list with checkboxes.
- "Select All" Option: Quickly select or deselect all items with a single click.
- Customizable Appearance: Modify the look and feel to match your app's theme.
- Dynamic Item Rendering: Build custom item widgets to display options and selected values.
- Scrollable Item List: Provides a scrollable list for managing a large number of options.
- Easy Integration: Simple API for seamless integration into your Flutter applications.

## Getting Started

To use this package, add `select_all_dropdown` as a dependency in your `pubspec.yaml` file.

dependencies:
  flutter:
    sdk: flutter
  select_all_dropdown: ^0.1.1 # Replace with the latest version

USAGE:

1. Import the package in your Dart file.

    import 'package:select_all_dropdown/select_all_dropdown.dart';

2. Use the DropDownMultiSelect widget.

    DropDownMultiSelect<String>(
   options: _options,
   selectedValues: _selectedValues,
   onChanged: (List<String> newValue) {
     setState(() {
       _selectedValues = newValue;
     });
   },
    whenEmpty: 'Select options',
    childBuilder: (List<String> selectedItems) {
    return Text(
      selectedItems.isEmpty ? 'No items selected' : selectedItems.join(', '),
      style: TextStyle(color: Colors.blue),
    );
   },
    menuItembuilder: (String option) {
    return ListTile(
      title: Text(option),
      trailing: Icon(Icons.check_box_outline_blank),
    );
   },
   icon: Icon(Icons.list),
     hintStyle: TextStyle(color: Colors.grey),
     selected_values_style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
    );

   
## Customization

You can customize the dropdown appearance and behavior using various parameters:

- options: List of options to display.
- selectedValues: List of currently selected values.
- onChanged: Callback when selection changes.
- isDense: Whether the dropdown is dense or not.
- enabled: Whether the dropdown is enabled or disabled.
- decoration: Input decoration for styling.
- whenEmpty: Text to show when no option is selected.
- childBuilder: Custom builder for selected values.
- menuItemBuilder: Custom builder for dropdown items.
- validator: Function to validate selected options.
- readOnly: Whether the dropdown is read-only.
- icon: Custom icon for the dropdown.
- hintStyle: Text style for the hint.
- selected_values_style: Text style for selected values.

##  Example Customization
Here's an example of how you can customize the dropdown:

       DropDownMultiSelect<String>(
       options: _options,
       selectedValues: _selectedValues,
       onChanged: (List<String> newValue) {
         setState(() {
      _selectedValues = newValue;
      });
     },
      whenEmpty: 'Select options',
        childBuilder: (List<String> selectedItems) {
          return Text(
            selectedItems.isEmpty ? 'No items selected' : selectedItems.join(', '),
            style: TextStyle(color: Colors.blue),
          );
        },
        menuItembuilder: (String option) {
          return ListTile(
            title: Text(option),
            trailing: Icon(Icons.check_box_outline_blank),
          );
        },
        icon: Icon(Icons.list),
        hintStyle: TextStyle(color: Colors.grey),
        selected_values_style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      );

