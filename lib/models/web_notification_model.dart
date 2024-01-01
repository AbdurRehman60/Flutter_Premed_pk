class WebNotificationModel {
  WebNotificationModel({
    required this.id,
    required this.userName,
    required this.group,
    required this.type,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory WebNotificationModel.fromJson(Map<String, dynamic> json) {
    return WebNotificationModel(
      id: json['_id'],
      userName: json['UserName'],
      group: json['Group'],
      type: json['Type'],
      content: Content.fromJson(json['Content']),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      v: json['__v'],
    );
  }

  final String id;
  final String userName;
  final String group;
  final String type;
  final Content content;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'UserName': userName,
      'Group': group,
      'Type': type,
      'Content': content.toJson(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      '__v': v,
    };
  }
}

class Content {
  Content({
    required this.iconSrc,
    required this.text,
    required this.actionButton1Text,
    required this.actionButton1URL,
  });

  factory Content.fromJson(Map<String, dynamic> json) {
    return Content(
      iconSrc: json['IconSrc'],
      text: json['Text'],
      actionButton1Text: json['ActionButton1Text'],
      actionButton1URL: json['ActionButton1URL'],
    );
  }

  final String iconSrc;
  final String text;
  final String actionButton1Text;
  final String actionButton1URL;

  Map<String, dynamic> toJson() {
    return {
      'IconSrc': iconSrc,
      'Text': text,
      'ActionButton1Text': actionButton1Text,
      'ActionButton1URL': actionButton1URL,
    };
  }
}
