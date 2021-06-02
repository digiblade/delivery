import 'package:delivery/Components/Color.dart';
import 'package:flutter/material.dart';

class CustomDropdown extends StatefulWidget {
  final Map<String, int> items;
  final Function(dynamic) onChange;
  CustomDropdown({
    Key key,
    this.items,
    this.onChange,
  }) : super(key: key);

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  int value = 1;
  List<DropdownMenuItem<int>> dropdown = [];
  @override
  void initState() {
    super.initState();
    dropdown = widget.items.entries.map((e) {
      return DropdownMenuItem<int>(
        child: Center(
          child: Text(e.key),
        ),
        value: e.value,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: light.withOpacity(0.6),
      ),
      child: DropdownButton<int>(
        items: dropdown,
        isExpanded: true,
        value: value,
        hint: Center(
          child: Text(
            "Select Type",
            style: TextStyle(
              color: light,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        dropdownColor: secondary.withOpacity(0.5),
        focusColor: light.withOpacity(0.7),
        style: TextStyle(
          color: light,
          fontWeight: FontWeight.bold,
        ),
        onChanged: (int val) {
          setState(() {
            value = val;
          });
          widget.onChange(val);
        },
      ),
    );
  }
}
