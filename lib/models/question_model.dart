
class QuestionModel {

  QuestionModel({
    required this.questionId,
    required this.questionText,
    required this.questionImage,
    required this.options,
    required this.published,
    required this.explanationText,
    required this.tags,
  }){
    if (tags.length >= 1) {
      deckName = tags[0].name;
    }

    if (tags.length >= 2) {
      subject = tags[1].name;
    }

    if (tags.length >= 3) {
      topic = tags[2].name;
    }

  }

  factory QuestionModel.fromJson(Map<String, dynamic> jsonResponse) {
    List<Tag> tags = [];
    if (jsonResponse['Tags'] != null) {
      tags = List<Tag>.from(jsonResponse['Tags'].map((tagJson) => Tag.fromJson(tagJson)));
    }



    return QuestionModel(
      questionId: jsonResponse['_id'],
      questionText: jsonResponse['QuestionText'],
      explanationText: jsonResponse['ExplanationText'],
      questionImage: jsonResponse['QuestionImage'],
      options: jsonResponse['Options'],
      published: jsonResponse['Published'],
      tags: tags,
    );
  }
  final String questionId;
  final String questionText;
  final String? questionImage;
  final String explanationText;
  final List options;
  final bool published;
  final List<Tag> tags;
  late String subject;
  late String deckName;
  late String topic;


  Map<String, dynamic> toJson() {
    return {
      'questionId': questionId,
      'questionText': questionText,
      'questionImage': questionImage,
      'explanationText': explanationText,
      'options': options,
      'published': published,
      'tags': tags.map((tag) => tag.toJson()).toList(),
    };
  }
}

class Tag {
  Tag({required this.id, required this.name});

  factory Tag.fromJson(Map<String, dynamic> json) => Tag(
    id: json['id'] is int ? json['id'].toString() : json['id'],
    name: json['name'],
  );

  final String id;
  final String name;

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
  };
}
