import 'package:flutter_svg/svg.dart';

import '../../../../constants/constants_export.dart';

class GetLogo extends StatelessWidget {
  const GetLogo({super.key, required this.url});
  final String url;

  @override
  Widget build(BuildContext context) {
    return url.endsWith('.svg')
        ? Stack(
            clipBehavior: Clip.hardEdge,
            alignment: Alignment.center,
            children: [
              const CircleAvatar(
                radius: 25,
              ),
              SvgPicture.network(
                  height: 34,
                  width: 34,
                  url,
                  semanticsLabel: 'A shark?!',
                  placeholderBuilder: (BuildContext context) =>
                      Image.asset(height: 50, 'assets/icons/premedIcon.png')),
            ],
          )
        : CircleAvatar(
            radius: 25,
            backgroundImage: url.isEmpty
                ? Image.asset('assets/icons/premedIcon.png') as ImageProvider
                : NetworkImage(url),
          );
  }
}
