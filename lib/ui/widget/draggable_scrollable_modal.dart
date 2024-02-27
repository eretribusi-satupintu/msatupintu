import 'package:flutter/material.dart';
import 'package:satupintu_app/shared/theme.dart';

class DraggableScrollableModal extends StatelessWidget {
  const DraggableScrollableModal({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
        builder: (BuildContext context, ScrollController scrollController) {
      return Container(
        color: mainColor,
        child: ListView.builder(
          controller: scrollController,
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text('mantapjiaw $index'),
            );
          },
        ),
      );
    });
  }
}
