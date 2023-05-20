import 'package:flutter/material.dart';
import '../services/models.dart';

class ItemDetailsScreen extends StatelessWidget {
  final Item item;

  const ItemDetailsScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyText1;
    const sizedBox = SizedBox(height: 15);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Item Details'),
      ),
      body: Column(
        children: [
          Image.network(item.imageUrl),
          Text(item.title, style: textStyle),
          sizedBox,
          Text(
            item.description,
            style: textStyle,
          ),
          sizedBox,
          Text(
            item.gender,
            style: textStyle,
          ),
          sizedBox,
          Text(
            item.type,
            style: textStyle,
          )
        ],
      ),
    );
  }
}
