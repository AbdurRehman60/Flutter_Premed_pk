import 'package:flutter/material.dart';
import 'package:premedpk_mobile_app/UI/Widgets/custom_button.dart';
import 'package:premedpk_mobile_app/export.dart';

class ComponentScreen extends StatelessWidget {
  const ComponentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                CustomButton(
                  buttonText: "Filled Button",
                  onPressed: onPressed,
                ),
                SizedBoxes.verticalBig,
                CustomButton(
                    buttonText: "Outlined Button",
                    onPressed: onPressed,
                    isOutlined: true),
                SizedBoxes.verticalBig,
                CustomButton(
                  buttonText: "Icon Button",
                  onPressed: onPressed,
                  isIconButton: true,
                  icon: Icons.abc,
                  iconSize: 40,
                ),
                SizedBoxes.verticalBig,
                Container(
                  height: 45,
                  width: MediaQuery.sizeOf(context).width,
                  decoration:
                      BoxDecoration(color: PreMedColorTheme().primaryColorRed),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'PreMedColorTheme().primaryColorRed',
                        style: PreMedTextTheme()
                            .heading6
                            .copyWith(color: PreMedColorTheme().white),
                      ),
                    ],
                  ),
                ),
                SizedBoxes.verticalMicro,
                Container(
                  height: 45,
                  width: MediaQuery.sizeOf(context).width,
                  decoration:
                      BoxDecoration(color: PreMedColorTheme().primaryColorBlue),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'PreMedColorTheme().primaryColorBlue',
                        style: PreMedTextTheme()
                            .heading6
                            .copyWith(color: PreMedColorTheme().white),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 45,
                  width: MediaQuery.sizeOf(context).width,
                  decoration: BoxDecoration(
                      gradient: PreMedColorTheme().primaryRedGradient),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'primaryRedGradient',
                        style: PreMedTextTheme()
                            .heading6
                            .copyWith(color: PreMedColorTheme().white),
                      ),
                    ],
                  ),
                ),
                SizedBoxes.verticalBig,
                const CustomTextField(
                  labelText: 'E-mail*',
                  hintText: 'john.doe@gmail.com*',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  onPressed() {
    print('object');
  }
}
