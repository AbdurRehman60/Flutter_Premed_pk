// ignore_for_file: constant_identifier_names, unnecessary_getters_setters, deprecated_member_use

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:premedpk_mobile_app/api_manager/dio%20client/dio_client.dart';
import 'package:premedpk_mobile_app/api_manager/dio%20client/endpoints.dart';
import 'package:premedpk_mobile_app/models/notes_model.dart';

enum Status {
  Init,
  Fetching,
  Success,
}

class NotesProvider extends ChangeNotifier {
  final DioClient _client = DioClient();

  Status _notesLoadingStatus = Status.Init;
  Status get notesLoadingStatus => _notesLoadingStatus;
  set notesLoadingStatus(Status value) {
    _notesLoadingStatus = value;
  }

  Status _guidesloadingStatus = Status.Init;
  Status get guidesloadingStatus => _guidesloadingStatus;
  set guidesloadingStatus(Status value) {
    _guidesloadingStatus = value;
  }

  List<NoteModel> _guidesList = [];
  List<NoteModel> get guidesList => _guidesList;
  set guidesList(List<NoteModel> value) {
    _guidesList = value;
  }

  List<NoteModel> _notesList = [];
  List<NoteModel> get notesList => _notesList;
  set notesList(List<NoteModel> value) {
    _notesList = value;
  }

  notify() {
    notifyListeners();
  }

  Future<Map<String, dynamic>> fetchGuides() async {
    Map<String, Object?> result;
    _guidesloadingStatus = Status.Fetching;

    try {
      final response = await _client.get(
        Endpoints.Guides,
      );
      List<NoteModel> list = [];
      if (response["message"] == "Guide fetched successfully") {
        for (final data in response['data']) {
          NoteModel fetchedData = NoteModel.fromJson(data);
          list.add(fetchedData);
        }

        guidesList = list;
        _guidesloadingStatus = Status.Success;
        result = {
          'status': true,
          'message': 'Data fetched successfully',
        };
      } else {
        result = {
          'status': false,
          'message': 'Failed to fetch data',
        };
      }
    } on DioError catch (e) {
      result = {
        'status': false,
        'message': e.message,
      };
    }
    _guidesloadingStatus = Status.Init;
    notify();
    return result;
  }

  Future<Map<String, dynamic>> fetchNotes() async {
    Map<String, Object?> result;
    _notesLoadingStatus = Status.Fetching;

    notesList = [];

    try {
      final response = await _client.get(
        Endpoints.RevisionNotes,
      );

      if (response["message"] == "Notes fetched successfully") {
        List<NoteModel> list = [];

        for (final data in response['data']) {
          NoteModel fetchedData = NoteModel.fromJson(data);
          list.add(fetchedData);
        }

        notesList = list;

        _notesLoadingStatus = Status.Success;
        notify();
        result = {
          'status': true,
          'message': 'Data fetched successfully',
        };
      } else {
        result = {
          'status': false,
          'message': 'Failed to fetch data',
        };
      }
    } on DioError catch (e) {
      result = {
        'status': false,
        'message': e.message,
      };
    }
    _notesLoadingStatus = Status.Init;
    notify();
    return result;
  }
}
