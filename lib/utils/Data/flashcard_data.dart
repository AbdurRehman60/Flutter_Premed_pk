import 'package:premedpk_mobile_app/export.dart';

List<FlashcardModel> sampleFlashcards = [
  FlashcardModel(
    id: "64da6db437d0eb48ed31845d",
    userName: "ddd@gmail.com",
    questionID: "61042c5fc24fddf89ac6b806",
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
];
