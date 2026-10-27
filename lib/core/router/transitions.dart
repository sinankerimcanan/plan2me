import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

const _forward = Duration(milliseconds: 320);
const _reverse = Duration(milliseconds: 260);

/// Varsayılan "liquid" geçiş: yumuşak fade + hafif yukarı kayma.
CustomTransitionPage<T> glassPage<T>(GoRouterState state, Widget child) =>
    CustomTransitionPage<T>(
      key: state.pageKey,
      transitionDuration: _forward,
      reverseTransitionDuration: _reverse,
      child: child,
      transitionsBuilder: (context, animation, secondary, child) {
        final curved = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
          reverseCurve: Curves.easeInCubic,
        );
        return FadeTransition(
          opacity: curved,
          child: SlideTransition(
            position: Tween(
              begin: const Offset(0, 0.04),
              end: Offset.zero,
            ).animate(curved),
            child: ScaleTransition(
              scale: Tween(begin: 0.985, end: 1.0).animate(curved),
              child: child,
            ),
          ),
        );
      },
    );

/// Proje → board gibi "derinleşen" geçişler için yatay paylaşımlı eksen.
CustomTransitionPage<T> sharedAxisPage<T>(GoRouterState state, Widget child) =>
    CustomTransitionPage<T>(
      key: state.pageKey,
      transitionDuration: const Duration(milliseconds: 380),
      reverseTransitionDuration: _forward,
      child: child,
      transitionsBuilder: (context, animation, secondary, child) =>
          SharedAxisTransition(
            animation: animation,
            secondaryAnimation: secondary,
            transitionType: SharedAxisTransitionType.horizontal,
            fillColor: Colors.transparent,
            child: child,
          ),
    );

/// go_router için alt sayfa (bottom sheet) rotası.
class BottomSheetPage<T> extends Page<T> {
  const BottomSheetPage({required this.child, super.key});

  final Widget child;

  @override
  Route<T> createRoute(BuildContext context) => ModalBottomSheetRoute<T>(
    settings: this,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: Colors.transparent,
    modalBarrierColor: Colors.black.withValues(alpha: 0.2),
    builder: (_) => child,
  );
}
