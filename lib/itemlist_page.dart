import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ItemListPage extends StatefulWidget {
  const ItemListPage({super.key});

  @override
  State<ItemListPage> createState() => _ItemListState();
}

class _ItemListState extends State<ItemListPage> {
  final ScrollController _scrollController = ScrollController();
  final List<dynamic> _items = [];
  bool isLoading = false;
  bool _hasMore = true;
  int _page = 1;
  final int _limit = 10;
  @override
  void initState() {
    super.initState();
    _fetchItems();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          !isLoading &&
          _hasMore) {
        _fetchItems();
      }
    });
  }

  Future<void> _fetchItems({bool isRefresh = false}) async {
    print("inside _fetchItems");
    if (isRefresh) {
      setState(() {
        _items.clear();
        _page = 1;
        _hasMore = true;
      });
    }
  /*  if (isLoading || !_hasMore) return;*/
    setState(() => isLoading = true);
    print("before api calling");
    try {
    final response = await http.get(Uri.parse(
        'https://jsonplaceholder.typicode.com/posts?_page=$_page&_limit=$_limit'));
    print("response : ${response}");


      if (response.statusCode == 200) {
        final List<dynamic> fetchedItems = json.decode(response.body);
        setState(() {
          if (isRefresh) {
            _items.clear();
          }
          _items.addAll(fetchedItems);
          _hasMore = fetchedItems.length == _limit;
          if (_hasMore) _page++;
        });
      } else {
        print("Error: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Paginated App"),
      ),
      body: RefreshIndicator(
        onRefresh: () => _fetchItems(isRefresh: true),
        child: ListView.builder(
            controller: _scrollController,
            itemCount: _items.length + (_hasMore ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == _items.length) {
                return const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              print("items : ${_items[index]}");
              final item = _items[index];
              return ListTile(
                title: Text(item['title']),
                subtitle: Text("ID : ${item['id']}"),
              );
            }),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
