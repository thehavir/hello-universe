import 'package:flutter/widgets.dart';
import 'package:hello_universe/src/utils/dependency_injection/injector_delegate.dart';
import 'package:provider/provider.dart';

/// Provides a child injector to the child widget.
///
/// The [injectorDelegate] is the injector that will be provided to the child widget.
/// The ownership of [injectorDelegate] is passed to this widget.
class InjectorDelegateProvider extends StatefulWidget {
  const InjectorDelegateProvider({
    super.key,
    required this.child,
    required this.injectorDelegate,
  });

  static InjectorDelegate of(BuildContext context) =>
      Provider.of(context, listen: false);

  final InjectorDelegate injectorDelegate;
  final Widget child;

  @override
  State<InjectorDelegateProvider> createState() =>
      _InjectorDelegateProviderState();
}

class _InjectorDelegateProviderState extends State<InjectorDelegateProvider> {
  @override
  void didUpdateWidget(covariant InjectorDelegateProvider oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.injectorDelegate != oldWidget.injectorDelegate) {
      oldWidget.injectorDelegate.dispose();
    }
  }

  @override
  Widget build(BuildContext context) =>
      Provider.value(value: widget.injectorDelegate, child: widget.child);

  @override
  void dispose() {
    widget.injectorDelegate.dispose();

    super.dispose();
  }
}

extension InjectorProviderExtension on BuildContext {
  T resolve<T extends Object>() =>
      InjectorDelegateProvider.of(this).resolve<T>();

  T resolveWithParams<T extends Object, P extends Object?>(P params) =>
      InjectorDelegateProvider.of(this).resolveWithParams<T, P>(params);
}
