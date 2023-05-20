import 'package:flutter/material.dart';
import 'services/api_service.dart';
import 'services/models.dart';

//Implement state management

class ItemsProvider with ChangeNotifier {
  List<Item> _items = [];

  List<Item> get items => _items;

  Future<void> fetchItems() async {
    try {
      final newItems = await ApiService.getItems();
      _items = newItems;
      notifyListeners();
    } catch (error) {
      print('Error: $error');
    }
  }

  void addItem(Item newItem) {
    _items.add(newItem);
    notifyListeners();
  }

  void addItems(List<Item> newItems) {
    _items.addAll(newItems);
    notifyListeners();
  }

  void deleteItem(Item item) {
    _items.remove(item);
    notifyListeners();
  }
}
