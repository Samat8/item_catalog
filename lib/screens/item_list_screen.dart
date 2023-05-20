import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'add_item_screen.dart';
import '../services/api_service.dart';
import 'item_details_screen.dart';
import '../items_provider.dart';

class ItemListScreen extends StatefulWidget {
  const ItemListScreen({super.key});

  @override
  _ItemListScreenState createState() => _ItemListScreenState();
}

class _ItemListScreenState extends State<ItemListScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    _fetchItems();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _fetchItems();
    }
  }

  Future<void> _fetchItems() async {
    if (!_isLoading) {
      setState(() {
        _isLoading = true;
      });

      // Make API call to fetch more items
      try {
        final newItems = await ApiService.getItems();

        // Add new items to the existing list
        Provider.of<ItemsProvider>(context, listen: false).addItems(newItems);

        setState(() {
          _isLoading = false;
        });
      } catch (error) {
        setState(() {
          _isLoading = false;
        });
        print('Error: $error');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final itemsProvider = Provider.of<ItemsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Item List'),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddItemScreen()),
              );
            },
            child: Icon(Icons.add),
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await itemsProvider.fetchItems();
        },
        child: ListView.builder(
          controller: _scrollController,
          itemCount: itemsProvider.items.length + 1,
          itemBuilder: (ctx, index) {
            if (index < itemsProvider.items.length) {
              final item = itemsProvider.items[index];

              return Dismissible(
                key: UniqueKey(),
                onDismissed: (direction) {
                  itemsProvider.deleteItem(item);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Item dismissed'),
                    ),
                  );
                },
                background: Container(
                  color: Colors.red, //
                  child: Icon(Icons.delete, color: Colors.white),
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 16.0),
                ),
                child: ListTile(
                  title: Text(item.title),
                  subtitle: Text(item.description),
                  leading: CachedNetworkImage(
                      width: 100, imageUrl: item.imageUrl, fit: BoxFit.cover),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ItemDetailsScreen(item: item),
                      ),
                    );
                  },
                ),
              );
            } else {
              return _buildLoader();
            }
          },
        ),
      ),
    );
  }

  Widget _buildLoader() {
    return _isLoading
        ? Container(
            padding: EdgeInsets.all(16.0),
            alignment: Alignment.center,
            child: CircularProgressIndicator(),
          )
        : Container();
  }
}
