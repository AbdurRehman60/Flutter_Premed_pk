class Question {
  final String questionId;
  final String questionText;
  final List<Tag> tags;
  late String subject;
  late String deckName;
  late String topic;

  Question({required this.questionId,required this.questionText, required this.tags}) {
    if (tags.length >= 2) {
      subject = tags[1].name;
    } else {
      subject = '';
    }

    if (tags.length >=3){
      topic = tags[2].name;
    }
    else{
      topic='';
    }

    if (tags.length >=1) {
      deckName = tags[0].name;
    } else {
      deckName = '';
    }
  }

  factory Question.fromJson(Map<String, dynamic> json) {
    final questionId = json['_id'];
    List<Tag> tags = [];
    if (json['Tags'] != null) {
      tags = List<Tag>.from(json['Tags'].map((tagJson) => Tag.fromJson(tagJson)));
    }

    return Question(
      questionId: questionId,
      questionText: json['QuestionText'],
      tags: tags,
    );
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
}
