import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategorySelector extends StatefulWidget {
  final String label;
  List<String> selectedCategories;
  CategorySelector({
    Key? key,
    required this.label,
    required this.selectedCategories,
  }) : super(key: key);

  @override
  State<CategorySelector> createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: ChoiceChip(
        label: Text(
          widget.label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
        selectedColor: Colors.green,
        selected: isSelected,
        onSelected: (value) {
          setState(() {
            isSelected = value;
          });
          if (value) {
            widget.selectedCategories.add(widget.label);
          } else {
            widget.selectedCategories.remove(widget.label);
          }
          print(widget.selectedCategories);
        },
        pressElevation: 5,
      ),
    );
  }
}
