import 'package:flutter/material.dart';

/// A reusable, generic grid widget used to render lists of cocktails (or any
/// item type). It encapsulates grid layout, scrolling, optional pull-to-refresh
/// and an "end reached" callback to drive pagination.
///
/// Usage:
/// ```dart
/// CocktailGridWidget<MyModel>(
///   items: items,
///   itemBuilder: (context, model) => MyTile(model),
///   onRefresh: () async => reload(),
///   onEndReached: () => loadMore(),
/// )
/// ```
class CocktailGridWidget<T> extends StatefulWidget {
  final List<T> items;
  final Widget Function(BuildContext, T) itemBuilder;
  final int crossAxisCount;
  final double childAspectRatio;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final EdgeInsetsGeometry padding;
  final Future<void> Function()? onRefresh;
  final VoidCallback? onEndReached;
  final bool isLoadingMore;
  final ScrollController? controller;
  final bool shrinkWrap;

  const CocktailGridWidget({
    super.key,
    required this.items,
    required this.itemBuilder,
    this.crossAxisCount = 2,
    this.childAspectRatio = 0.75,
    this.mainAxisSpacing = 12.0,
    this.crossAxisSpacing = 12.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    this.onRefresh,
    this.onEndReached,
    this.isLoadingMore = false,
    this.controller,
    this.shrinkWrap = false,
  });

  @override
  State<CocktailGridWidget<T>> createState() => _CocktailGridWidgetState<T>();
}

class _CocktailGridWidgetState<T> extends State<CocktailGridWidget<T>> {
  late final ScrollController _controller;
  bool _hasListener = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? ScrollController();
    _maybeAddListener();
  }

  @override
  void didUpdateWidget(covariant CocktailGridWidget<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      if (!_isExternalController(oldWidget.controller)) {
        // if we created the old controller, dispose it
        oldWidget.controller?.dispose();
      }
      // attach listener to new controller
      if (!_isExternalController(widget.controller)) {
        // we keep our own controller; listener already exists
      }
      _maybeAddListener();
    }
  }

  bool _isExternalController(ScrollController? c) => c != null && c != _controller;

  void _maybeAddListener() {
    if (widget.onEndReached == null) return;
    if (!_hasListener) {
      _controller.addListener(_onScroll);
      _hasListener = true;
    }
  }

  void _onScroll() {
    if (widget.onEndReached == null) return;
    // trigger when we are near the end (200 px remaining)
    if (_controller.position.maxScrollExtent - _controller.position.pixels < 200) {
      widget.onEndReached?.call();
    }
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      // we created the controller, dispose it
      _controller.dispose();
    } else {
      // external controller - remove our listener if attached
      if (_hasListener) _controller.removeListener(_onScroll);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget grid = GridView.builder(
      controller: _controller,
      shrinkWrap: widget.shrinkWrap,
      padding: widget.padding,
      physics: const AlwaysScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: widget.crossAxisCount,
        crossAxisSpacing: widget.crossAxisSpacing,
        mainAxisSpacing: widget.mainAxisSpacing,
        childAspectRatio: widget.childAspectRatio,
      ),
      itemCount: widget.items.length + (widget.isLoadingMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index < widget.items.length) {
          final item = widget.items[index];
          return widget.itemBuilder(context, item);
        }

        // loading indicator tile at the end
        return const Center(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: SizedBox(width: 24, height: 24, child: CircularProgressIndicator(strokeWidth: 2)),
          ),
        );
      },
    );

    if (widget.onRefresh != null) {
      return RefreshIndicator(
        onRefresh: widget.onRefresh!,
        child: grid,
      );
    }

    return grid;
  }
}
