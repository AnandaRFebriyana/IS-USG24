import 'package:flutter/material.dart';
import 'package:mobileapp/models/assesment_models.dart';
import 'package:mobileapp/services/assesment_service.dart';

class AssessmentController extends ChangeNotifier {
  final AssessmentService _assessmentService = AssessmentService();
  List<Assessment> _assessments = [];
  bool _isLoading = false;

  List<Assessment> get assessments => _assessments;
  bool get isLoading => _isLoading;

  // Fetch all assessments
  Future<void> fetchAssessments() async {
    _isLoading = true;
    notifyListeners();
    try {
      _assessments = await _assessmentService.getAssessments();
    } catch (e) {
      print('Error fetching assessments: $e');
      _assessments = []; // Set default to empty if error occurs
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
