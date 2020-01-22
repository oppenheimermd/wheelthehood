import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../locator.dart';

/// Shared setup for all views
//  Most of the views require their own model, they need to have a root widget
//  Provider and a child Consumer that takes a build method. [BaseView] is a
//  generic class that will do all this for us.

class BaseView<T extends ChangeNotifier> extends StatefulWidget {
  final Widget Function(BuildContext context, T model, Widget child) builder;
  final Function(T) onModelReady;

  BaseView({@required this.builder, this.onModelReady});

  @override
  _BaseViewState<T> createState() => _BaseViewState<T>();
}

class _BaseViewState<T extends ChangeNotifier> extends State<BaseView<T>> {
  //  using dependency injection
  T model = locator<T>();

  @override
  void initState() {
    if (widget.onModelReady != null) {
      widget.onModelReady(model);
    }
    super.initState();
  }

  //
  /// Remember [ChangeNotifierProvider] is the widget that provides an
  /// instance of a [ChangeNotifier] to it's descendants. [Consumer] allows fot
  /// the consumption of our ChangeNotifierProvider object.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
        create: (context) => model,
        child: Consumer<T>(builder: widget.builder));
  }
}