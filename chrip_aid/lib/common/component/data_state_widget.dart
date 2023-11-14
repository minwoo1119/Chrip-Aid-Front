import 'package:chrip_aid/common/state/data_state.dart';
import 'package:chrip_aid/common/styles/styles.dart';
import 'package:flutter/material.dart';

typedef DataStateWidgetBuilder<T> = Widget Function(
  BuildContext context,
  DataState<T> state,
);

class DataStateWidget<T> extends StatefulWidget {
  final DataState<T> state;
  final DataStateWidgetBuilder? defaultBuilder;
  final DataStateWidgetBuilder? noneBuilder;
  final DataStateWidgetBuilder? loadingBuilder;
  final DataStateWidgetBuilder? successBuilder;
  final DataStateWidgetBuilder? errorBuilder;

  const DataStateWidget({
    Key? key,
    required this.state,
    this.defaultBuilder,
    this.noneBuilder,
    this.loadingBuilder,
    this.successBuilder,
    this.errorBuilder,
  }) : super(key: key);

  @override
  State<DataStateWidget> createState() => _DataStateWidgetState();
}

class _DataStateWidgetState extends State<DataStateWidget> {
  @override
  Widget build(BuildContext context) {
    if (widget.state.isSuccess) {
      return widget.successBuilder?.call(context, widget.state) ??
          widget.defaultBuilder?.call(context, widget.state) ??
          Container(color: CustomColor.contentSubColor);
    }
    if (widget.state.isLoading) {
      return widget.loadingBuilder?.call(context, widget.state) ??
          widget.defaultBuilder?.call(context, widget.state) ??
          const CircularProgressIndicator(
            color: CustomColor.backGroundSubColor,
          );
    }
    if (widget.state.isError) {
      return widget.errorBuilder?.call(context, widget.state) ??
          widget.defaultBuilder?.call(context, widget.state) ??
          const CircularProgressIndicator(
            color: CustomColor.backGroundSubColor,
          );
    }
    return widget.noneBuilder?.call(context, widget.state) ??
        widget.defaultBuilder?.call(context, widget.state) ??
        Container(color: CustomColor.contentSubColor);
  }

  @override
  void initState() {
    widget.state.addListener(_setState);
    super.initState();
  }

  @override
  void dispose() {
    widget.state.removeListener(_setState);
    super.dispose();
  }

  void _setState() {
    print("???????");
    setState(() {});
  }
}
