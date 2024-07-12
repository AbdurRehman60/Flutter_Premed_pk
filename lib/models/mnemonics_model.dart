class MnemonicsModel {
  MnemonicsModel(
      {required this.id,
      required this.topicName,
      required this.subTopicName,
      required this.cateogry,
      this.imageUrl,
      this.videoUrl,
      required this.thumbnailUrl,
      this.description,
      required this.isPublished,
      required this.board,
      required this.province,
      required this.access,
      required this.subject});

  factory MnemonicsModel.fromJson(Map<String, dynamic> json) {
    return MnemonicsModel(
      id: json['_id'],
      topicName: json['topicName'],
      subTopicName: json['subTopicName'],
      cateogry: json['category'],
      thumbnailUrl: json['thumbnailUrl'],
      isPublished: json['isPublished'],
      board: json['board'],
      province: json['province'],
      access: json['access'],
      subject: json['subject'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      videoUrl: json['videoUrl'],
    );
  }

  final String id;
  final String topicName;
  final String subTopicName;
  final String cateogry;
  final String? imageUrl;
  final String? videoUrl;
  final String thumbnailUrl;
  final String? description;
  final bool isPublished;
  final String board;
  final String access;
  final String subject;
  final String province;
}
