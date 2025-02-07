import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../providers/class_provider.dart';

class AddClasses extends StatefulWidget {
  static const routeName = "add-classes";
  const AddClasses({super.key});

  @override
  State<AddClasses> createState() => _AddClassesState();
}

class _AddClassesState extends State<AddClasses> {
  TextEditingController classesController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  // Function to show the Date Picker and set the selected date to the dateController
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (selectedDate != null) {
      // Format the selected date as a string (e.g., 'dd/MM/yyyy')
      final String formattedDate =
          DateFormat('dd/MM/yyyy').format(selectedDate);
      setState(() {
        dateController.text = formattedDate;
      });
    }
  }

  void saveClass() {
    if (classesController.text.isEmpty ||
        categoryController.text.isEmpty | dateController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please fill all fields"),
        ),
      );
      return;
    }

    Provider.of<ClassProvider>(context, listen: false).addClass(
      classesController.text,
      categoryController.text,
      dateController.text,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Class added successfully"),
      ),
    );

    classesController.clear();
    categoryController.clear();
    dateController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Class"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: classesController,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                labelText: 'Class',
                prefixIcon: Icon(Icons.class_),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: categoryController,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                labelText: 'Category',
                prefixIcon: Icon(Icons.category),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: dateController,
              textAlignVertical: TextAlignVertical.center,
              readOnly: true,
              onTap: () => _selectDate(context),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                labelText: 'Date',
                prefixIcon: Icon(Icons.calendar_month),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                // primary: Colors.white,
                // onPrimary: Colors.black,
              ),
              onPressed: saveClass,
              child: Center(
                child: Text('SAVE'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
