import 'export.dart';

class components extends StatelessWidget {
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
            ),
            SizedBoxes.verticalLarge,
            Container(
              child: CustomTextField(
                labelText: 'E-mail*',
                hintText: 'john.doe@gmail.com*',
              ),
            ),
            SizedBoxes.verticalLarge,
            Container(
              child: CustomTextField(
                labelText: 'Enter password*',
                hintText: 'Password',
              ),
            ),
            SizedBoxes.verticalLarge,
            Container(
              color: PreMedColorTheme().standardblack,
              height: 200,
              width: 200,
              child: ListView(
                children: [
                  Container(
                    color: PreMedColorTheme().primaryColorRed,
                    child: Text('Primary Color Red'),
                  ),
                  Container(
                    color: PreMedColorTheme().primaryColorRed200,
                    child: Text('Primary Color Red 200'),
                  ),
                  Container(
                    color: PreMedColorTheme().primaryColorRed300,
                    child: Text('Primary Color Red 300'),
                  ),
                  Container(
                    color: PreMedColorTheme().primaryColorRed500,
                    child: Text('Primary Color Red 500'),
                  ),
                  Container(
                    color: PreMedColorTheme().primaryColorRed600,
                    child: Text('Primary Color Red 600'),
                  ),
                  Container(
                    color: PreMedColorTheme().primaryColorBlue,
                    child: Text('Primary Color Blue'),
                  ),
                  Container(
                    color: PreMedColorTheme().primaryColorBlue200,
                    child: Text('Primary Color Blue 200'),
                  ),
                  Container(
                    color: PreMedColorTheme().primaryColorBlue300,
                    child: Text('Primary Color Blue 300'),
                  ),
                  Container(
                    color: PreMedColorTheme().primaryColorBlue500,
                    child: Text('Primary Color Blue 500'),
                  ),
                  Container(
                    color: PreMedColorTheme().primaryColorBlue600,
                    child: Text('Primary Color Blue 600'),
                  ),
                  Container(
                    color: PreMedColorTheme().standardwhite,
                    child: Text('standard white'),
                  ),
                  Container(
                    color: PreMedColorTheme().neutral100,
                    child: Text('Primary Color neutral 100'),
                  ),
                  Container(
                    color: PreMedColorTheme().neutral200,
                    child: Text('Primary Color neutral 200'),
                  ),
                  Container(
                    color: PreMedColorTheme().neutral300,
                    child: Text('Primary Color neutral 300'),
                  ),
                  Container(
                    color: PreMedColorTheme().neutral400,
                    child: Text('Primary Color neutral 400'),
                  ),
                  Container(
                    color: PreMedColorTheme().neutral500,
                    child: Text('Primary Color neutral 500'),
                  ),
                  Container(
                    color: PreMedColorTheme().neutral600,
                    child: Text('Primary Color neutral 600'),
                  ),
                  Container(
                    color: PreMedColorTheme().neutral700,
                    child: Text('Primary Color neutral 700'),
                  ),
                  Container(
                    color: PreMedColorTheme().neutral800,
                    child: Text('Primary Color neutral 800'),
                  ),
                  Container(
                    color: PreMedColorTheme().neutral900,
                    child: Text('Primary Color neutral 900'),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
