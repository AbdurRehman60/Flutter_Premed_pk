import 'package:premedpk_mobile_app/constants/constants_export.dart';
import 'package:shimmer/shimmer.dart';

class FlashcardShimmer extends StatelessWidget {
  const FlashcardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GridView.builder(
          itemCount: 7,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            mainAxisExtent: 130,
          ),
          itemBuilder: (context, index) {
            return Shimmer.fromColors(
              baseColor: PreMedColorTheme().neutral200,
              highlightColor: PreMedColorTheme().neutral50,
              child: const FlashcardItemSkeleton(),
            );
          },
        ),
      ),
    );
  }
}

class FlashcardItemSkeleton extends StatelessWidget {
  const FlashcardItemSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: PreMedColorTheme().white),
      ),
    );
  }
}
