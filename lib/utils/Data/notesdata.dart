import 'package:premedpk_mobile_app/models/notes_model.dart';

List<Note> notesData = [
  Note(
    id: "64df3a6ca3cd2104bce43779",
    isGuide: false,
    title: "Biology and its major fields of specialization",
    subject: "Biology",
    province: "Sindh",
    notesURL:
        "https://premedpk-cdn.sgp1.digitaloceanspaces.com/Notes/f16f2eff-0dbb-4ebc-bc66-b88f3a2dcfdf.pdf",
    coverImageURL:
        "https://premedpk-cdn.sgp1.digitaloceanspaces.com/Notes/baacf2f1-114f-4a3a-ba7b-76e90f424fcf.png",
    demarcations: [
      NoteDemarcation(
        id: "64df3a6ca3cd2104bce4377a",
        name: "Introduction to Biology and Some Major Fields of Specialization",
        page: 2,
      ),
      // Add more demarcations here...
    ],
    pages: 7,
    position: 283,
    createdAt: DateTime.parse("2023-08-18T09:31:24.385Z"),
    updatedAt: DateTime.parse("2023-08-18T09:31:24.385Z"),
  ),
  Note(
    id: "64df3a6ca3cd2104bce43779",
    isGuide: false,
    title: "Biological Molecules",
    subject: "Biology",
    province: "Punjab",
    notesURL:
        "https://premedpk-cdn.sgp1.digitaloceanspaces.com/Notes/f16f2eff-0dbb-4ebc-bc66-b88f3a2dcfdf.pdf",
    coverImageURL:
        "https://premedpk-cdn.sgp1.digitaloceanspaces.com/Notes/baacf2f1-114f-4a3a-ba7b-76e90f424fcf.png",
    demarcations: [
      NoteDemarcation(
        id: "64df3a6ca3cd2104bce4377a",
        name: "Introduction to Biological Molecules",
        page: 2,
      ),
      // Add more demarcations here...
    ],
    pages: 7,
    position: 283,
    createdAt: DateTime.parse("2023-08-18T09:31:24.385Z"),
    updatedAt: DateTime.parse("2023-08-18T09:31:24.385Z"),
  ),

  // Add more Note objects here...
];
