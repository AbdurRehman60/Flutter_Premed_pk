import 'package:premedpk_mobile_app/export.dart';

List<FlashcardModel> sampleFlashcards = [
  FlashcardModel(
    id: "64da6db437d0eb48ed31845d",
    userName: "ddd@gmail.com",
    questionID: "61042c5fc24fddf89ac6b806",
    subject: 'Biology',
    questionText:
        "<p>In the following question, a statement is given followed by four inferences. You have to decide which of the given Inferences can definitely be drawn from the given statement. Indicate your answer.</p>\n<p>Statement:</p>\n<p>Most dresses in that shop are expensive.</p>\n<p>Inferences:</p>\n<p>I. Some dresses in that shop are expensive.</p>\n<p>II. There are cheap dresses also in that shop.</p>\n<p>III. Handloom dresses in that shop are cheap.</p>\n<p>IV. There are no cheap dresses available in that shop.</p>\n",
    correctOption: "B",
    correctOptionText: "<p>Only II follows</p>\n",
    explanationText:
        "<p>According to the given statement, most dresses are expensive so there are some cheap dresses also in that shop.</p>\n",
    tags: ["NUMS 2015", "Logical Reasoning", "Logical Deduction"],
    createdAt: DateTime.parse("2023-08-14T18:08:52.575Z"),
    updatedAt: DateTime.parse("2023-08-14T18:08:52.575Z"),
  ),
  // Add more flashcards here
  FlashcardModel(
    id: "64da6dbe37d0eb48ed3189f2",
    userName: "ddd@gmail.com",
    questionID: "6119009b6943bb9424ee8ede",
    subject: 'Chemistry',
    questionText:
        "<p>Children are in pursuit of a dog whose leash has broken. James is directly behind the dog. Ruby is behind James. Rachel is behind Ruby. Max is ahead of the dog walking down the street in the opposite direction. As the children and dog pass, Max turns around and joins the pursuit. He runs in behind Ruby. James runs faster and is alongside the dog on the left. Ruby runs faster and is alongside the dog on the right. Which child is directly behind the dog?</p>\n",
    correctOption: "D",
    correctOptionText: "<p>Max</p>\n",
    explanationText:
        "<p>After all the switches were made, Max is directly behind the dog, James is alongside the dog on the left, Ruby is alongside the dog on the right, and Rachel is behind Max.</p>\n",
    tags: ["PMC Practice 2", "Logical Reasoning", "Logical Problems"],
    createdAt: DateTime.parse("2023-08-14T18:09:02.646Z"),
    updatedAt: DateTime.parse("2023-08-14T18:09:02.646Z"),
  ),
  FlashcardModel(
    id: "64da6dd937d0eb48ed31a3fd",
    userName: "ddd@gmail.com",
    questionID: "621fc8381f15d9034f57d0ff",
    subject: 'Chemistry',
    questionText:
        "<p>Fact Checking</p>\n<p>Fact 1: All drink mixes are beverages</p>\n<p>Fact 2: All beverages are drinkable</p>\n<p>Fact 3: All beverages are red</p>\n<p>If the above three statements are facts then which of the following statement will also be a fact?</p>\n<p>I. Some drink mixes are red</p>\n<p>II. All beverages are drink mixes.</p>\n<p>Ill. All red drink mixes are drinkable</p>\n",
    correctOption: "C",
    correctOptionText: "<p>III only</p>\n",
    explanationText:
        "<p ><span >Drink mixes may or may not be red, so option I is not a fact. </span></p>\n<p><span >All drink mixes are beverages but beverages can also be other than drink mixes, option II is also not a fact. </span></p>\n<p><span >Because all drink mixes are beverages and all beverages are drinkable, therefore all red drink mixes will be drinkable. Option III is a fact. </span></p>\n",
    tags: ["Logical Reasoning", "Logical Problems"],
    createdAt: DateTime.parse("2023-08-14T18:09:29.149Z"),
    updatedAt: DateTime.parse("2023-08-14T18:09:29.149Z"),
  ),
  FlashcardModel(
    id: "64da6ddc37d0eb48ed31ac34",
    userName: "ddd@gmail.com",
    questionID: "6220793f1f15d9034f57d27d",
    subject: 'Mathematics Reasoning',
    questionText:
        "<p>Fact 1: Ayesha said Hamza and I both have cats</p>\n<p>Fact 2: Hamza said I don't have a cat</p>\n<p>Fact 3: Ayesha always tells the truth but hamza sometimes lies.</p>\n<p>If the above three statements are facts then which of the following statement will also be a fact&nbsp;</p>\n<p>I.Ayesha has a cat&nbsp;</p>\n<p>II. Hamza has a cat&nbsp;</p>\n<p>Ill. Hamza is lying&nbsp;</p>\n<p>IV. All the statements are the facts&nbsp;</p>\n",
    correctOption: "D",
    correctOptionText: "<p>Statement IV</p>\n",
    explanationText:
        "<p><span >From Fact 1, Ayesha said both she and Hamza have cats. This implies that Ayesha has a cat.</span><br></p>\n<p><span >From Fact 2, Hamza said he doesn't have a cat. Since Hamza sometimes lies (Fact 3), we cannot conclude whether Hamza actually has a cat or not. So, we cannot determine if statement II is a fact.</span><br></p>\n<p><span >From Fact 3, Ayesha always tells the truth. Therefore, when Ayesha said that both she and Hamza have cats (Fact 1), it must be true. This means Hamza does have a cat, contradicting his statement in Fact 2. Therefore, statement III is true.</span><br></p>\n<p><span >Combining all the facts, we can conclude that Ayesha has a cat (statement I is true), Hamza has a cat (statement II is true), and Hamza is lying (statement III is true). Hence, statement IV, which states that all the statements are facts, is also true.</span><br></p>\n<p><span >Therefore, the correct answer is D) Statement IV.</span><br>&nbsp;</p>\n",
    tags: ["Logical Reasoning", "Logical Problems"],
    createdAt: DateTime.parse("2023-08-14T18:09:32.399Z"),
    updatedAt: DateTime.parse("2023-08-14T18:09:32.399Z"),
  ),
  FlashcardModel(
    id: "64da6df137d0eb48ed31c3c6",
    userName: "example@gmail.com",
    questionID: "623f53744e349164500da0be",
    subject: 'Science Reasoning',
    questionText:
        "<p>Animal Kingdom</p>\n<p>Fact 1: All cats are mammals.</p>\n<p>Fact 2: Some mammals are herbivores.</p>\n<p>Fact 3: Tigers are cats.</p>\n<p>If the above three statements are facts, which of the following statement is a fact?</p>\n<p>I. All tigers are herbivores.</p>\n<p>II. All cats are herbivores.</p>\n<p>III. Some cats are herbivores.</p>\n",
    correctOption: "C",
    correctOptionText: "<p>III only</p>\n",
    explanationText:
        "<p>Fact 1 states that all cats are mammals, but it doesn't imply that all mammals are cats, so option II is not a fact. Fact 3 mentions that tigers are cats, but we cannot directly conclude their diet, making option I not a fact. Since Fact 2 states that some mammals are herbivores, we can infer that some cats are herbivores, making option III a fact.</p>\n",
    tags: ["Sample Flashcards", "Biology", "Animal Kingdom"],
    createdAt: DateTime.parse("2023-08-14T18:09:45.822Z"),
    updatedAt: DateTime.parse("2023-08-14T18:09:45.822Z"),
  ),
  FlashcardModel(
    id: "64da6dfb37d0eb48ed31d7ea",
    userName: "example@gmail.com",
    questionID: "62419c3d3dd137da7bf6b64",
    subject: 'Biology',
    questionText:
        "<p>History Facts</p>\n<p>Fact 1: The French Revolution began in 1789.</p>\n<p>Fact 2: The American Revolution ended in 1783.</p>\n<p>Fact 3: The Russian Revolution began in 1917.</p>\n<p>Which of the following statement is a fact?</p>\n<p>I. The American Revolution began in 1789.</p>\n<p>II. The French Revolution ended in 1783.</p>\n<p>III. The Russian Revolution ended in 1917.</p>\n",
    correctOption: "C",
    correctOptionText: "<p>III only</p>\n",
    explanationText:
        "<p>Fact 1 and Fact 3 provide historical dates that are factual. However, Fact 2 is incorrect as the American Revolution ended in 1783. Therefore, option I and option II are not facts. The Russian Revolution did begin in 1917, so option III is a fact.</p>\n",
    tags: ["Sample Flashcards", "History", "Historical Facts"],
    createdAt: DateTime.parse("2023-08-14T18:10:15.046Z"),
    updatedAt: DateTime.parse("2023-08-14T18:10:15.046Z"),
  ),
  FlashcardModel(
    id: "64da6dfe37d0eb48ed31e0d8",
    userName: "example@gmail.com",
    questionID: "6241a18b3dd137da7bf6c23",
    subject: 'Biology',
    questionText:
        "<p>Geography Quiz</p>\n<p>What is the capital of Australia?</p>\n",
    correctOption: "C",
    correctOptionText: "<p>Canberra</p>\n",
    explanationText: "<p>The capital of Australia is Canberra.</p>\n",
    tags: ["Sample Flashcards", "Geography", "Capitals"],
    createdAt: DateTime.parse("2023-08-14T18:10:35.218Z"),
    updatedAt: DateTime.parse("2023-08-14T18:10:35.218Z"),
  ),
  FlashcardModel(
    id: "64da6e0137d0eb48ed31e65b",
    userName: "example@gmail.com",
    questionID: "6241a4763dd137da7bf6cf02",
    subject: 'Chemistry',
    questionText:
        "<p>Literature Trivia</p>\n<p>Who wrote the play 'Romeo and Juliet'?</p>\n",
    correctOption: "B",
    correctOptionText: "<p>William Shakespeare</p>\n",
    explanationText:
        "<p>'Romeo and Juliet' is a famous play written by William Shakespeare.</p>\n",
    tags: ["Sample Flashcards", "Literature", "Playwrights"],
    createdAt: DateTime.parse("2023-08-14T18:10:53.397Z"),
    updatedAt: DateTime.parse("2023-08-14T18:10:53.397Z"),
  ),
  FlashcardModel(
    id: "64da6e0237d0eb48ed31eb0d",
    userName: "example@gmail.com",
    questionID: "6241a5c03dd137da7bf6d2e2",
    subject: 'Chemistry',
    questionText:
        "<p>Science Facts</p>\n<p>Fact 1: Water boils at 100°C (212°F) at sea level.</p>\n<p>Fact 2: Oxygen is necessary for combustion.</p>\n<p>Fact 3: Gold is a good conductor of electricity.</p>\n<p>Which of the following statement is a fact?</p>\n<p>I. Water boils at 50°C (122°F) at sea level.</p>\n<p>II. Combustion does not require oxygen.</p>\n<p>III. Gold is a poor conductor of electricity.</p>\n",
    correctOption: "A",
    correctOptionText: "<p>None of the above</p>\n",
    explanationText:
        "<p>All three facts are scientifically accurate. Therefore, none of the given statements are facts.</p>\n",
    tags: ["Sample Flashcards", "Science", "Scientific Facts"],
    createdAt: DateTime.parse("2023-08-14T18:11:12.624Z"),
    updatedAt: DateTime.parse("2023-08-14T18:11:12.624Z"),
  ),
  FlashcardModel(
    id: "64da6e0337d0eb48ed31f000",
    userName: "example@gmail.com",
    questionID: "6241a6f53dd137da7bf6d61b",
    subject: 'Mathematics Reasoning',
    questionText:
        "<p>Movie Trivia</p>\n<p>Which actor played the character 'Harry Potter' in the movie series?</p>\n",
    correctOption: "B",
    correctOptionText: "<p>Daniel Radcliffe</p>\n",
    explanationText:
        "<p>The character 'Harry Potter' in the movie series was portrayed by actor Daniel Radcliffe.</p>\n",
    tags: ["Sample Flashcards", "Movies", "Actors"],
    createdAt: DateTime.parse("2023-08-14T18:11:30.816Z"),
    updatedAt: DateTime.parse("2023-08-14T18:11:30.816Z"),
  ),
  FlashcardModel(
    id: "64da6e0437d0eb48ed31f4f6",
    userName: "example@gmail.com",
    questionID: "6241a8543dd137da7bf6dbd2",
    subject: 'Science Reasoning',
    questionText:
        "<p>Space Exploration</p>\n<p>Which planet is known as the 'Red Planet'?</p>\n",
    correctOption: "C",
    correctOptionText: "<p>Mars</p>\n",
    explanationText:
        "<p>Mars is often referred to as the 'Red Planet' due to its reddish appearance caused by iron oxide (rust) on its surface.</p>\n",
    tags: ["Sample Flashcards", "Astronomy", "Planets"],
    createdAt: DateTime.parse("2023-08-14T18:11:49.978Z"),
    updatedAt: DateTime.parse("2023-08-14T18:11:49.978Z"),
  ),
  FlashcardModel(
    id: "64da6e0537d0eb48ed31f9d1",
    userName: "example@gmail.com",
    questionID: "6241a9803dd137da7bf6e175",
    subject: 'Biology',
    questionText:
        "<p>General Knowledge</p>\n<p>What is the largest mammal in the world?</p>\n",
    correctOption: "B",
    correctOptionText: "<p>Blue Whale</p>\n",
    explanationText:
        "<p>The blue whale is the largest mammal in the world, and it is also the largest animal to have ever existed on Earth.</p>\n",
    tags: ["Sample Flashcards", "Animals", "Mammals"],
    createdAt: DateTime.parse("2023-08-14T18:12:08.150Z"),
    updatedAt: DateTime.parse("2023-08-14T18:12:08.150Z"),
  ),
];
