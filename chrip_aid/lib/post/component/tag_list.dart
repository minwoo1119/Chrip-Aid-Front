import 'package:chrip_aid/post/component/tag_item.dart';
import 'package:chrip_aid/post/model/entity/tag_entity.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

class TagList extends StatelessWidget {
  final TagListController controller;

  const TagList({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 4.0,
      alignment: WrapAlignment.start,
      runAlignment: WrapAlignment.start,
      children: controller.tags
          .mapIndexed(
            (i, e) => TagItem(
              e.name,
              isChecked: e.isSelected,
              onTap: (checked) => controller.onTap(i, checked),
            ),
          )
          .toList(),
    );
  }
}

class TagListController extends ChangeNotifier {
  late List<TagEntity> tags;

  TagListController({List<TagEntity>? tags}) {
    this.tags = tags ?? [];
  }

  void onTap(int index, bool checked) {
    tags[index].isSelected = checked;
  }

  void setTags(List<TagEntity> tags) {
    this.tags = tags;
    notifyListeners();
  }

  List<TagEntity> get selectedList => tags.where((e) => e.isSelected).toList();
}
