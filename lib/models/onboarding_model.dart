// class Feature {
//   final String id;
//   final String featureName;
//   final String description;
//   final List<String> tags;
//   final String iconLink;
//   final String? videoUrl;
//   final bool isPublished;
//
//   Feature({
//     required this.id,
//     required this.featureName,
//     required this.description,
//     required this.tags,
//     required this.iconLink,
//     this.videoUrl,
//     required this.isPublished,
//   });
//
//   factory Feature.fromJson(Map<String, dynamic> json) {
//     return Feature(
//       id: json['_id'],
//       featureName: json['featureName'],
//       description: json['description'],
//       tags: List<String>.from(json['tags']),
//       iconLink: json['iconLink'],
//       videoUrl: json['videoUrl'],
//       isPublished: json['isPublished'],
//     );
//   }
// }
//
// class Board {
//   final String id;
//   final String boardName;
//   final int position;
//   final List<Feature> tags;
//
//   Board({
//     required this.id,
//     required this.boardName,
//     required this.position,
//     required this.tags,
//   });
//
//   factory Board.fromJson(Map<String, dynamic> json) {
//     return Board(
//       id: json['_id'],
//       boardName: json['board'],
//       position: json['position'],
//       tags: (json['tags'] as List).map((tag) => Feature.fromJson(tag)).toList(),
//     );
//   }
// }
