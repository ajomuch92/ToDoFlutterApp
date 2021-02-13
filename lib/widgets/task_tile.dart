import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:todoapp/models/task.dart';
import 'package:todoapp/theme/theme.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  final Function onTap, onEditTap, onDeleteTap;
  const TaskTile({Key key, @required this.task, this.onTap, this.onEditTap, this.onDeleteTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: task.isComplete? Icon(FeatherIcons.checkCircle): Icon(FeatherIcons.clock),
        onTap: onTap,
        title: Text(task.title),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _getButton(FeatherIcons.trash2, redColor, onDeleteTap),
            _getButton(FeatherIcons.edit, orangeColor, onEditTap),
          ],
        ),
      ),
    );
  }

  Widget _getButton(IconData icon, Color backgroundColor, Function onPress) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: backgroundColor,
        shape: CircleBorder(),
      ),
      child: Icon(
        icon,
        color: Colors.white,
        size: 18.0
      ),
      onPressed: onPress,
    );
  }
}