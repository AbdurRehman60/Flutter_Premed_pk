// ignore_for_file: avoid_print

import 'package:fijkplayer/fijkplayer.dart';
import 'package:premedpk_mobile_app/constants/constants_export.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({
    super.key,
    required this.url,
    this.aspectRatio = 16 / 9,
  });
  final String url;
  final double aspectRatio;

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  _VideoScreenState();
  final FijkPlayer player = FijkPlayer();
  bool isPlay = false;

  @override
  void initState() {
    super.initState();
    player.setOption(FijkOption.hostCategory, "enable-snapshot", 1);
    player.setOption(FijkOption.playerCategory, "mediacodec-all-videos", 1);
  }

  void startPlay() async {
    await player.setOption(FijkOption.hostCategory, "request-screen-on", 1);
    await player.setOption(FijkOption.hostCategory, "request-audio-focus", 1);

    await player
        .setDataSource(widget.url, autoPlay: true, showCover: true)
        .catchError((e) {
      print("setDataSource error: $e");
    });
    setState(() {
      isPlay = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
        aspectRatio: 16 / 9,
        child: isPlay
            ? FijkView(
                fit: FijkFit.cover,
                player: player,
                panelBuilder: fijkPanel2Builder(
                  snapShot: true,
                  fill: true,
                ),
                fsFit: FijkFit.fitHeight,
                // panelBuilder: simplestUI,
                // panelBuilder: (FijkPlayer player, FijkData data, BuildContext context,
                //     Size viewSize, Rect texturePos) {
                //   return CustomFijkPanel(
                //       player: player,
                //       data: data,
                //       buildContext: context,
                //       viewSize: viewSize,
                //       texturePos: texturePos);
                // },
                color: PreMedColorTheme().primaryColorBlue100,
              )
            : InkWell(
                onTap: startPlay,
                child: Container(
                  decoration: BoxDecoration(
                    color: PreMedColorTheme().primaryColorRed100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.play_circle_fill_sharp,
                        size: 36,
                        color: PreMedColorTheme().primaryColorRed,
                      ),
                      SizedBoxes.horizontalTiny,
                      Text(
                        'Play',
                        style: PreMedTextTheme().heading4.copyWith(
                            color: PreMedColorTheme().primaryColorRed),
                      ),
                    ],
                  ),
                ),
              ));
  }

  @override
  void deactivate() {
    player.release();
    super.deactivate();
  }
}
