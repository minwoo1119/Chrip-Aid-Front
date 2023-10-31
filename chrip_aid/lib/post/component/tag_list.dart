import 'package:chrip_aid/post/component/tag_item.dart';
import 'package:flutter/material.dart';

class TagList extends StatefulWidget {
  final List<String> tags;
  const TagList({Key? key, required this.tags}) : super(key: key);

  @override
  State<TagList> createState() => _TagListState();
}

class _TagListState extends State<TagList> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 4.0,
      children: widget.tags.map((e) => TagItem(e, isChecked: false,)).toList(),
    );
  }
}
