import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class _TheState {}

var _theState = RM.inject(() => _TheState());

class _SelectRow extends StatelessWidget {
  final Function(bool) onChange;
  final bool selected;
  final String text;

  const _SelectRow({
    Key? key,
    required this.onChange,
    required this.selected,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChange(!selected);
        _theState.notify();
      },
      child: Container(
        height: kMinInteractiveDimension,
        child: Row(
          children: [
            Checkbox(
              value: selected,
              onChanged: (x) {
                onChange(x!);
                _theState.notify();
              },
            ),
            Text(text)
          ],
        ),
      ),
    );
  }
}

class DropDownMultiSelect<T> extends StatefulWidget {
  final List<T> options;
  final List<T> selectedValues;
  final Function(List<T>) onChanged;
  final bool isDense;
  final bool enabled;
  final InputDecoration? decoration;
  final String? whenEmpty;
  final Widget Function(List<T> selectedValues)? childBuilder;
  final Widget Function(T option)? menuItembuilder;
  final String Function(T? selectedOptions)? validator;
  final bool readOnly;
  final Widget? icon;
  final TextStyle? hintStyle;
  final Widget? hint;
  final TextStyle? selected_values_style;

  const DropDownMultiSelect({
    Key? key,
    required this.options,
    required this.selectedValues,
    required this.onChanged,
    this.whenEmpty,
    this.icon,
    this.hint,
    this.hintStyle,
    this.childBuilder,
    this.selected_values_style,
    this.menuItembuilder,
    this.isDense = true,
    this.enabled = true,
    this.decoration,
    this.validator,
    this.readOnly = false,
  }) : super(key: key);

  @override
  _DropDownMultiSelectState createState() => _DropDownMultiSelectState<T>();
}

class _DropDownMultiSelectState<T> extends State<DropDownMultiSelect<T>> {
  bool _allSelected = false;

  void _updateSelectAllState() {
    setState(() {
      _allSelected = widget.selectedValues.length == widget.options.length;
    });
  }

  @override
  void initState() {
    super.initState();
    _updateSelectAllState();
  }

  void _toggleSelectAll() {
    setState(() {
      if (_allSelected) {
        widget.selectedValues.clear();
      } else {
        widget.selectedValues.clear();
        widget.selectedValues.addAll(widget.options);
      }
      widget.onChanged(widget.selectedValues);
      _updateSelectAllState();
    });
  }

  void _showCustomMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 0.6,
          child: Column(
            children: [
              ListTile(
                title: _theState.rebuild(() {
                  return _SelectRow(
                    selected: _allSelected,
                    text: _allSelected ? "Unselect All" : "Select All",
                    onChange: (isSelected) {
                      _toggleSelectAll();
                    },
                  );
                }),
              ),
              Expanded(
                child: ListView(
                  children: widget.options.map(
                    (x) => ListTile(
                      title: _theState.rebuild(() {
                        return widget.menuItembuilder != null
                            ? widget.menuItembuilder!(x)
                            : _SelectRow(
                                selected: widget.selectedValues.contains(x),
                                text: x.toString(),
                                onChange: (isSelected) {
                                  setState(() {
                                    if (isSelected) {
                                      widget.selectedValues.add(x);
                                    } else {
                                      widget.selectedValues.remove(x);
                                    }
                                    widget.onChanged(widget.selectedValues);
                                    _updateSelectAllState();
                                  });
                                },
                              );
                      }),
                    ),
                  ).toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _removeSelectedItem(T item) {
    setState(() {
      widget.selectedValues.remove(item);
      widget.onChanged(widget.selectedValues);
      _updateSelectAllState();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          GestureDetector(
            onTap: () => _showCustomMenu(context),
            child: InputDecorator(
              decoration: widget.decoration ?? InputDecoration(
                border: OutlineInputBorder(),
                isDense: true,
                contentPadding: EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 10,
                ),
              ),
              isEmpty: widget.selectedValues.isEmpty,
              child: Row(
                children: [
                  Expanded(
                    child: _theState.rebuild(() {
                      return widget.childBuilder != null
                          ? widget.childBuilder!(widget.selectedValues)
                          : widget.selectedValues.isNotEmpty
                              ? SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: widget.selectedValues.map((value) {
                                      return Container(
                                        margin: EdgeInsets.symmetric(horizontal: 4),
                                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          color: Colors.grey.shade300,
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              value.toString(),
                                              style: widget.selected_values_style,
                                            ),
                                            SizedBox(width: 4),
                                            GestureDetector(
                                              onTap: () => _removeSelectedItem(value),
                                              child: Icon(
                                                Icons.close,
                                                size: 18,
                                                color: Colors.red,
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                )
                              : Text(
                                  widget.whenEmpty ?? '',
                                  style: widget.selected_values_style,
                                );
                    }),
                  ),
                  widget.icon ?? Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}