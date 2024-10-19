class Tag {

  Tag({
    required this.featureName,
    required this.description,
    required this.tags,
    required this.iconLink,
    required this.isPublished,
  });

  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(
      featureName: json['featureName'],
      description: json['description'],
      tags: List<String>.from(json['tags']),
      iconLink: json['iconLink'],
      isPublished: json['isPublished'],
    );
  }
  final String featureName;
  final String description;
  final List<String> tags;
  final String iconLink;
  final bool isPublished;

  
  Map<String, dynamic> toJson() {
    return {
      'featureName': featureName,
      'description': description,
      'tags': tags,
      'iconLink': iconLink,
      'isPublished': isPublished,
    };
  }
}

class Board {

  Board({
    required this.id,
    required this.boardName,
    required this.isPublished,
    required this.hiddenOnFeatures,
    required this.position,
    required this.tags,
  });

  factory Board.fromJson(Map<String, dynamic> json) {
    return Board(
      id: json['_id'],
      boardName: json['boardName'],
      isPublished: json['isPublished'],
      hiddenOnFeatures: json['hiddenOnFeatures'],
      position: json['position'],
      tags: (json['tags'] as List).map((tag) => Tag.fromJson(tag)).toList(),
    );
  }
  final String id;
  final String boardName;
  final bool isPublished;
  final bool hiddenOnFeatures;
  final int position;
  final List<Tag> tags;

  
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'boardName': boardName,
      'isPublished': isPublished,
      'hiddenOnFeatures': hiddenOnFeatures,
      'position': position,
      'tags': tags.map((tag) => tag.toJson()).toList(),
    };
  }
}


class BoardsResponse {

  BoardsResponse({
    required this.success,
    required this.message,
    required this.boards,
  });

  factory BoardsResponse.fromJson(Map<String, dynamic> json) {
    return BoardsResponse(
      success: json['success'],
      message: json['message'],
      boards: (json['boards'] as List).map((board) => Board.fromJson(board)).toList(),
    );
  }
  final bool success;
  final String message;
  final List<Board> boards;
}
