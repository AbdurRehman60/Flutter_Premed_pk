import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:premedpk_mobile_app/models/mnemonics_model.dart';
import 'package:provider/provider.dart';
import '../../../../../constants/constants_export.dart';
import '../../../../../providers/user_provider.dart';

class MnemonicsBuilderCard extends StatelessWidget {
  const MnemonicsBuilderCard({
    super.key,
    required this.mnemonicsModel,
    required this.onTap,
  });

  final MnemonicsModel mnemonicsModel;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: !Provider.of<UserProvider>(context).userAccess ? null : onTap,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white.withOpacity(0.85),
              border: Border.all(color: Colors.white.withOpacity(0.50)),
            ),
            height: 119,
            width: 175,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 10),
              child: Row(
                children: [
                  Container(
                    height: 79,
                    width: 46,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.5),
                        width: 2.5,
                      ),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: mnemonicsModel.thumbnailUrl,
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.15),
                              offset: const Offset(0, 20),
                              blurRadius: 20,
                            ),
                          ],
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(3.0)),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: 66,
                            height: 21,
                            child: SvgPicture.asset(
                                'assets/images/vault/mnemonics logo.svg'),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            mnemonicsModel.topicName,
                            textAlign: TextAlign.start,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: PreMedTextTheme().heading1.copyWith(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                ),
                            maxLines: 2,
                          ),
                          const SizedBox(height: 6),
                          Flexible(
                            child: Text(
                              mnemonicsModel.subTopicName,
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              style: PreMedTextTheme().heading1.copyWith(
                                    fontSize: 8,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black.withOpacity(0.7),
                                  ),
                              maxLines: 2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          if (!Provider.of<UserProvider>(context).userAccess)
            Positioned.fill(
              child: GlassContainer(
                shadowStrength: 0,
                  child: Center(
                    child: GlassContainer(
                      height: 32,
                      width: 80,
                      border: Border.all(color: Colors.white, width: 2),
                      child: Center(
                        child: Text(
                          'Unlock',
                          style: PreMedTextTheme().heading1.copyWith(
                              fontWeight: FontWeight.w500, fontSize: 15),
                        ),
                      ),
                    ),
                  )),
            ),
        ],
      ),
    );
  }
}
