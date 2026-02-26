import 'package:flutter/material.dart' hide RootWidget;
import 'package:hello_universe/src/injector_delegate_impl.dart';
import 'package:hello_universe/src/root_widget.dart';
import 'package:hello_universe/src/utils/dependency_injection/injector_delegate_provider.dart';

void main() {
  final injector = InjectorDelegateImpl();

  runApp(
    InjectorDelegateProvider(
      injectorDelegate: injector,
      child: const RootWidget(),
    ),
  );
}
