import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'items_provider.dart';
import 'screens/item_list_screen.dart';

void main() {
  MyApp myApp = const MyApp();
  runApp(myApp);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ItemsProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Task',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Consumer<ItemsProvider>(
          builder: (ctx, itemsProvider, _) {
            if (itemsProvider.items.isEmpty) {
              itemsProvider.fetchItems();
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            } else {
              return ItemListScreen();
            }
          },
        ),
      ),
    );
  }
}
