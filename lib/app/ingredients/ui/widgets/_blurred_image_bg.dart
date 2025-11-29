part of '../pages/ingredients_page.dart';

/// Blurry image background for the Cocktail Highlights view. Contains horizontal and vertical gradients that stack overtop the blended image.
class _BlurredImageBg extends ConsumerWidget {
  const _BlurredImageBg({this.url});
  final String? url;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint('url new: $url');
    final introLogic = ref.read(introLogicProvider);
    final img = AppImage(
      image: url == null ? null : NetworkImage(url!),
      syncDuration: $dimensions.times.fast,
      fit: BoxFit.cover,
      scale: 0.5,
    );
    return Transform.scale(
      scale: 1.25,
      alignment: const Alignment(0, 0.8),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
        ),
        child: introLogic.useBlurs
            ? ImageFiltered(
                imageFilter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                child: img,
              )
            : img,
      ),
    );
  }
}
