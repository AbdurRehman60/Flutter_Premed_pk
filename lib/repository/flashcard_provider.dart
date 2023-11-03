import 'package:premedpk_mobile_app/export.dart';
import 'package:premedpk_mobile_app/models/flashcard_model.dart';
import 'package:premedpk_mobile_app/utils/Data/flashcard_data.dart';

class FlashcardDataProvider with ChangeNotifier {
  static final FlashcardDataProvider _instance =
      FlashcardDataProvider._internal();
  factory FlashcardDataProvider() => _instance;

  FlashcardDataProvider._internal();

  List<FlashcardModel> getFlashcardsBySubject(String subject) {
    return sampleFlashcards
        .where((flashcard) => flashcard.subject == subject)
        .toList();
  }
}
