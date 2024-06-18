class QuestionModel {
  QuestionModel({
    required this.questionId,
    required this.questionText,
    required this.questionImage,
    required this.options,
    required this.published,
    required this.explanationText,
    required this.explanationImage,
    required this.tags,
    required this.timedTestMinutes,
  }) {
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
      tags = List<Tag>.from(
          jsonResponse['Tags'].map((tagJson) => Tag.fromJson(tagJson)));
    }

    List<Option> options = [];
    if (jsonResponse['Options'] != null) {
      options = List<Option>.from(jsonResponse['Options']
          .map((optionJson) => Option.fromJson(optionJson)));
    }

    return QuestionModel(
      questionId: jsonResponse['_id'],
      questionText: jsonResponse['QuestionText'],
      explanationImage: jsonResponse['ExplanationImage'],
      explanationText: jsonResponse['ExplanationText'],
      questionImage: jsonResponse['QuestionImage'],
      options: options,
      published: jsonResponse['Published'],
      tags: tags,
      timedTestMinutes: jsonResponse['TimedTestMinutes'] ?? 0,
    );
  }
  final String questionId;
  final String questionText;
  final String? questionImage;
  final String? explanationText;
  final String? explanationImage;
  final List<Option> options;
  final bool published;
  final List<Tag> tags;
  late String subject;
  late String deckName;
  late String topic;
  final int timedTestMinutes;

  Map<String, dynamic> toJson() {
    return {
      'questionId': questionId,
      'questionText': questionText,
      'questionImage': questionImage,
      'explanationImage':explanationImage,
      'explanationText': explanationText,
      'options': options.map((option) => option.toJson()).toList(),
      'published': published,
      'tags': tags.map((tag) => tag.toJson()).toList(),
    };
  }
}

class Option {
  Option({
    required this.optionLetter,
    required this.optionText,
    required this.isCorrect,
    required this.explanationText,
    required this.id,
  });

  factory Option.fromJson(Map<String, dynamic> json) {
    return Option(
      optionLetter: json['OptionLetter'],
      optionText: json['OptionText'],
      isCorrect: json['IsCorrect'],
      explanationText: json['ExplanationText'],
      id: json['_id'],
    );
  }
  final String optionLetter;
  final String optionText;
  final bool isCorrect;
  final String? explanationText;
  final String id;


  Map<String, dynamic> toJson() {
    return {
      'OptionLetter': optionLetter,
      'OptionText': optionText,
      'IsCorrect': isCorrect,
      'ExplanationText': explanationText,
      '_id': id,
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
