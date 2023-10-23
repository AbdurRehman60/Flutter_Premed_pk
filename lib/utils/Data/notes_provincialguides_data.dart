import 'dart:convert'; // for JSON decoding
import 'dart:io'; // for file operations

class NotesData {
  final String id;
  final bool isGuide;
  final String title;
  final String subject;
  final String notesURL;
  final String coverImageURL;
  final List<NotesDemarcation> demarcations;
  final int pages;

  NotesData({
    required this.id,
    required this.isGuide,
    required this.title,
    required this.subject,
    required this.notesURL,
    required this.coverImageURL,
    required this.demarcations,
    required this.pages,
  });

  factory NotesData.fromJson(Map<String, dynamic> json) {
    List<NotesDemarcation> demarcations = (json['demarcations'] as List)
        .map((item) => NotesDemarcation.fromJson(item))
        .toList();

    return NotesData(
      id: json['_id'],
      isGuide: json['isGuide'],
      title: json['title'],
      subject: json['subject'],
      notesURL: json['notesURL'],
      coverImageURL: json['coverImageURL'],
      demarcations: demarcations,
      pages: json['pages'],
    );
  }
}

class NotesDemarcation {
  final String name;
  final int page;

  NotesDemarcation({required this.name, required this.page});

  factory NotesDemarcation.fromJson(Map<String, dynamic> json) {
    return NotesDemarcation(name: json['name'], page: json['page']);
  }
}

class NotesDataService {
  Future<List<NotesData>> fetchNotesData() async {
    final jsonFile = File('notesData.json');
    try {
      final jsonString = await jsonFile.readAsString();
      final jsonData = json.decode(jsonString);

      if (jsonData.containsKey('data')) {
        final List<dynamic> data = jsonData['data'];
        return data.map((item) => NotesData.fromJson(item)).toList();
      } else {
        throw Exception('Invalid JSON data format');
      }
    } catch (e) {
      throw Exception('Failed to read or parse JSON: $e');
    }
  }
}

void printNotesData(List<NotesData> notesData) {
  for (final data in notesData) {
    print('Title: ${data.title}');
    print('Subject: ${data.subject}');
    print('Notes URL: ${data.notesURL}');
    print('Cover Image URL: ${data.coverImageURL}');
    for (final demarcation in data.demarcations) {
      print('Demarcation Name: ${demarcation.name}');
      print('Demarcation Page: ${demarcation.page}');
    }
    print('Number of Pages: ${data.pages}');
    print('------------------------');
  }
}

Future<void> main() async {
  final notesDataService = NotesDataService();
  try {
    final notesData = await notesDataService.fetchNotesData();
    printNotesData(notesData);
  } catch (e) {
    print('Error: $e');
  }
}
