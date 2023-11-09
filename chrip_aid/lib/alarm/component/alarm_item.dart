import 'package:chrip_aid/alarm/model/entity/alarm_entity.dart';
import 'package:chrip_aid/common/styles/styles.dart';
import 'package:chrip_aid/common/utils/date_utils.dart';
import 'package:flutter/material.dart';

class AlarmItem extends StatelessWidget {
  final AlarmEntity entity;
  final VoidCallback? onTap;

  const AlarmItem(this.entity, {Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kBorderRadiusSmallsSize),
          side: const BorderSide(color: CustomColor.subColor, width: 2.0),
        ),
        borderOnForeground: false,
        elevation: 8.0,
        child: Container(
          padding: const EdgeInsets.all(kPaddingSmallSize),
          constraints: const BoxConstraints(maxHeight: 300),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const Icon(Icons.notifications, size: kIconMiniSize),
                  const SizedBox(width: kPaddingSmallSize),
                  Expanded(
                    child: Text(
                      entity.title,
                      style: kTextContentStyleSmall,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    alarmDateFormat.format(entity.time),
                    style: kTextContentStyleSmall,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              const SizedBox(height: kPaddingSmallSize),
              Row(
                children: [
                  const SizedBox(width: kPaddingSmallSize + kIconMiniSize),
                  Expanded(
                    child: Text(
                      entity.body,
                      style: kTextContentStyleSmall,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 5,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
