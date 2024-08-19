import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../models/onboarding_model.dart';

class BoardProvider with ChangeNotifier {
  List<Board> _boards = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Board> get boards => _boards;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  final Dio _dio = Dio();

  Future<void> fetchBoards(String category) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _dio.get('https://prodapi.premed.pk/api/plans/get-boards-and-features/$category');

      if (response.statusCode == 200) {
        final List boardsData = response.data['boards'];
        _boards = boardsData.map((json) => Board.fromJson(json)).toList();
      } else {
        _errorMessage = 'Failed to load boards';
      }
    } catch (error) {
      _errorMessage = error.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
