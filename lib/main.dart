import 'export.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  //     gradient: LinearGradient(colors: [
                  //   PreMedColorTheme().primaryColorBlue,
                  //   PreMedColorTheme().primaryColorRed200
                  // ])),

                  gradient: PreMedColorTheme().primaryGradient),
            ),
            Container(
              child: CustomButton(
                  buttonText: "Click me",
                  onPressed: () {
                    print('Button Clicked');
                  }),
            )
          ],
        ),
      );
}
