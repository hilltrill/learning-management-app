import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ClassProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addClass(String className, String category, String date) async {
    try {
      await _firestore.collection('classes').add({
        'className': className,
        'category': category,
        'date': date,
        'createdAt': Timestamp.now(),
      });
      notifyListeners();
    } catch (e) {
      print("Error adding class: $e");
    }
  }
}
          