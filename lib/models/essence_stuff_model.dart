import 'package:flutter/foundation.dart';

class EssenceStuffModel {
  EssenceStuffModel({
    required this.id,
    required this.category,
    required this.topicName,
    required this.thumbnailImageUrl,
    required this.pdfUrl,
    required this.isPublished,
    this.pagination,
    required this.province,
    required this.board,
  });

  factory EssenceStuffModel.fromJson(Map<String, dynamic> json) {
    List<NotePagination> paginations = [];

    if (json['paginations'] != null) {
      paginations = (json['paginations'] as List).map((demarcationJson) {
        if (kDebugMode) {
          print('province : ${json['province']}');
        }
        return NotePagination.fromJson(demarcationJson);
      }).toList();
    }

    return EssenceStuffModel(
        category: json['category'],
        id: json['_id'],
        topicName: json['resourceName'],
        thumbnailImageUrl: json['imageUrl'],
        pdfUrl: json['pdfUrl'],
        pagination: paginations,
        province: json['province'],
        board: json['board'],
        isPublished: json['isPublished']);
  }
  final String category;
  final String id;
  final String topicName;
  final String? thumbnailImageUrl;
  final String pdfUrl;
  final bool isPublished;
  final List<NotePagination>? pagination;
  final String province;
  final String board;
}

class NotePagination {
  NotePagination(
      {required this.id,
      required this.name,
      required this.startPageNo,
      required this.endPageNo});

  factory NotePagination.fromJson(Map<String, dynamic> json) {
    return NotePagination(
        id: json['_id'],
        name: json['subTopic'],
        startPageNo: json['startPageNo'] ?? 0,
        endPageNo: json['endPageNo'] ?? 0);
  }
  final String id;
  final String name;
  final int startPageNo;
  final int endPageNo;
}
