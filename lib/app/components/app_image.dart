import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:image_fade/image_fade.dart';

// Assuming RetryImage and AppLoadingIndicator are in these paths
import '../../constants/retry_image.dart';
import 'app_loading_indicator.dart';
// Ensure this import points to your actual AppSizes location
import '../../constants/app_sizes.dart'; 

class AppImage extends StatefulWidget {
  const AppImage({
    super.key,
    required this.image,
    this.fit = BoxFit.cover, // CHANGED: Default to cover for better UI filling
    this.alignment = Alignment.center,
    this.duration,
    this.syncDuration,
    this.distractor = false,
    this.progress = false,
    this.color,
    this.width,
    this.height,
    this.scale,
  });

  final ImageProvider? image;
  final BoxFit fit;
  final Alignment alignment;
  final Duration? duration;
  final Duration? syncDuration;
  final bool distractor;
  final bool progress;
  final Color? color;
  final double? width;
  final double? height;
  final double? scale;

  @override
  State<AppImage> createState() => _AppImageState();
}

class _AppImageState extends State<AppImage> {
  ImageProvider? _displayImage;
  ImageProvider? _sourceImage;

  @override
  void didChangeDependencies() {
    _updateImage();
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(AppImage oldWidget) {
    _updateImage();
    super.didUpdateWidget(oldWidget);
  }

  void _updateImage() {
    if (widget.image == _sourceImage) return;
    _sourceImage = widget.image;
    _displayImage = _capImageSize(_addRetry(_sourceImage));
  }

  @override
  Widget build(BuildContext context) {
    // FIX: Wrap in SizedBox to enforce layout constraints independent of image decoding
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: ImageFade(
        image: _displayImage,
        fit: widget.fit,
        alignment: widget.alignment,
        duration: widget.duration ?? $dimensions.times.fast,
        syncDuration: widget.syncDuration ?? 0.ms,
        loadingBuilder: (_, value, ___) {
          if (!widget.distractor && !widget.progress) return const SizedBox();
          return Center(
            child: AppLoadingIndicator(
              value: widget.progress ? value : null, 
              color: widget.color
            )
          );
        },
        errorBuilder: (_, __) => Container(
          padding: EdgeInsets.all($dimensions.insets.xs),
          alignment: Alignment.center,
          child: LayoutBuilder(builder: (_, constraints) {
            double size = min(constraints.biggest.width, constraints.biggest.height);
            if (size < 16) return const SizedBox();
            return Icon(
              Icons.image_not_supported_outlined,
              color: Colors.white.withAlpha((0.1 * 255).round()),
              size: min(size, $dimensions.insets.lg),
            );
          }),
        ),
      ),
    );
  }

  ImageProvider? _addRetry(ImageProvider? image) {
    return image == null ? image : RetryImage(image);
  }

  ImageProvider? _capImageSize(ImageProvider? image) {
    if (image == null) return null;
    
    final MediaQueryData mq = MediaQuery.of(context);
    final double dpr = mq.devicePixelRatio;
    
    // 1. Prefer explicit width
    if (widget.width != null) {
      final double targetW = widget.width!.isFinite ? widget.width! : mq.size.width;
      return ResizeImage(
        image, 
        width: (targetW * dpr).round(),
        policy: ResizeImagePolicy.fit,
      );
    }
    
    // 2. Prefer explicit height
    if (widget.height != null) {
      final double targetH = widget.height!.isFinite ? widget.height! : mq.size.height;
      return ResizeImage(
        image, 
        height: (targetH * dpr).round(),
        policy: ResizeImagePolicy.fit,
      );
    }

    // 3. Fallback to scale if provided
    if (widget.scale != null) {
      final double w = mq.size.width * widget.scale!;
      return ResizeImage(
        image,
        width: (w * dpr).round(),
        policy: ResizeImagePolicy.fit,
      );
    }

    // 4. Fallback to screen width (never unbounded)
    return ResizeImage(
      image, 
      width: (mq.size.width * dpr).round(),
      policy: ResizeImagePolicy.fit,
    );
  }
}