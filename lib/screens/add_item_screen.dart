import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../items_provider.dart';
import '../services/models.dart';

//Add item screen

class AddItemScreen extends StatelessWidget {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();

  AddItemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final itemsProvider = Provider.of<ItemsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Item'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(labelText: 'Title'),
          ),
          TextField(
            controller: _descriptionController,
            decoration: const InputDecoration(labelText: 'Description'),
          ),
          TextField(
            controller: _genderController,
            decoration: const InputDecoration(labelText: 'Gender'),
          ),
          TextField(
            controller: _typeController,
            decoration: const InputDecoration(labelText: 'Type'),
          ),
          const SizedBox(
            height: 15,
          ),
          ElevatedButton(
            onPressed: () {
              final newItem = Item(
                title: _titleController.text,
                description: _descriptionController.text,
                imageUrl:
                    'https://rickandmortyapi.com/api/character/avatar/2.jpeg',
                gender: '',
                type: '',
                id: '',
              );
              itemsProvider.addItem(newItem);
              Navigator.pop(context);
            },
            child: const Text('Add Item'),
          ),
        ],
      ),
    );
  }
}
