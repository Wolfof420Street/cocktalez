import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'error_widget.dart';
import 'loading_indicator.dart';

class AsyncDataWidget<T> extends ConsumerWidget {
  // STRICT FIX: Use dynamic to accept ANY provider type
  final Refreshable<dynamic> provider; 
  final Widget Function(T data) data;
  final Widget Function()? loading;
  final Widget Function(Object error, VoidCallback retry)? error;
  final bool Function(T data)? isEmpty;
  final Widget Function()? onEmpty;
  final bool wrapLoadingInScaffold;
  final bool wrapErrorInScaffold;
  final Future<void> Function()? onRetry;

  const AsyncDataWidget({
    super.key,
    required this.provider,
    required this.data,
    this.loading,
    this.error,
    this.isEmpty,
    this.onEmpty,
    this.wrapLoadingInScaffold = false,
    this.wrapErrorInScaffold = false,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // RUNTIME CAST: Safe because we know the provider returns AsyncValue<T>
    final asyncValue = ref.watch(provider) as AsyncValue<T>;

    return asyncValue.when(
      data: (value) {
        if (isEmpty != null && isEmpty!(value)) {
          return onEmpty?.call() ?? const SizedBox.shrink();
        }
        return data(value);
      },
      loading: () {
        final widget = loading?.call() ?? const AppLoadingIndicator();
        return wrapLoadingInScaffold ? const AppLoadingScaffold() : widget;
      },
      error: (err, stack) {
        final retry = onRetry ?? () => ref.refresh(provider as dynamic);
        final widget = error?.call(err, () => retry()) ?? AppErrorWidget(onRetry: retry);
        return wrapErrorInScaffold ? Scaffold(body: widget) : widget;
      },
    );
  }
}

class AsyncMapWidget<T, R> extends ConsumerWidget {
  final Refreshable<dynamic> provider;
  final R? Function(T data) extract;
  final Widget Function(R data) data;
  final Widget Function()? onNull;
  final Widget Function()? loading;
  final Widget Function(Object error, VoidCallback retry)? error;
  final bool wrapLoadingInScaffold;
  final bool wrapErrorInScaffold;
  final Future<void> Function()? onRetry;

  const AsyncMapWidget({
    super.key,
    required this.provider,
    required this.extract,
    required this.data,
    this.onNull,
    this.loading,
    this.error,
    this.wrapLoadingInScaffold = false,
    this.wrapErrorInScaffold = false,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncValue = ref.watch(provider) as AsyncValue<T>;

    return asyncValue.when(
      data: (value) {
        final extracted = extract(value);
        if (extracted == null) {
          return onNull?.call() ?? const SizedBox.shrink();
        }
        return data(extracted);
      },
      loading: () {
        final widget = loading?.call() ?? const AppLoadingIndicator();
        return wrapLoadingInScaffold ? const AppLoadingScaffold() : widget;
      },
      error: (err, stack) {
        final retry = onRetry ?? () => ref.refresh(provider as dynamic);
        final widget = error?.call(err, () => retry()) ?? AppErrorWidget(onRetry: retry);
        return wrapErrorInScaffold ? Scaffold(body: widget) : widget;
      },
    );
  }
}

extension AsyncDataExtension on WidgetRef {
  Widget asyncData<T>({
    required Refreshable<dynamic> provider,
    required Widget Function(T data) data,
    Widget Function()? loading,
    Widget Function(Object error, VoidCallback retry)? error,
    bool Function(T data)? isEmpty,
    Widget Function()? onEmpty,
    bool wrapLoadingInScaffold = false,
    bool wrapErrorInScaffold = false,
  }) {
    return AsyncDataWidget<T>(
      provider: provider,
      data: data,
      loading: loading,
      error: error,
      isEmpty: isEmpty,
      onEmpty: onEmpty,
      wrapLoadingInScaffold: wrapLoadingInScaffold,
      wrapErrorInScaffold: wrapErrorInScaffold,
    );
  }
}
