import 'package:flutter/material.dart';
import 'package:project/repositories/shop/models/shops_repository.dart';

class SearchBarShops extends StatefulWidget {
  final List<Shop> shops;
  final Function(List<Shop>) onShopsListChanged;
  const SearchBarShops(
      {super.key, required this.shops, required this.onShopsListChanged});

  @override
  State<SearchBarShops> createState() => _SearchBarShopState();
}

class _SearchBarShopState extends State<SearchBarShops> {
  List<Shop> filterShops = [];
  final TextEditingController _textEditingController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    filterShops = widget.shops;
  }

  void _onTextChanged(String value) {
    setState(() {
      if (_textEditingController.text.isNotEmpty) {
        filterShops = widget.shops
            .where((shops) =>
                shops.name
                    .toLowerCase()
                    .contains(_textEditingController.text.toLowerCase()) ||
                shops.address
                    .toLowerCase()
                    .contains(_textEditingController.text.toLowerCase()))
            .toList();
      } else {
        filterShops = shops;
      }
    });
    widget.onShopsListChanged(filterShops);
  }

  void _clearText() {
    setState(() {
      _textEditingController.clear();
      filterShops = shops;
      widget.onShopsListChanged(filterShops);
      _focusNode.unfocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      TextField(
        controller: _textEditingController,
        onChanged: _onTextChanged,
        focusNode: _focusNode,
        decoration: InputDecoration(
          icon: const Icon(
            Icons.search_rounded,
            size: 30.0,
          ),
          hintText: "Поиск",
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          suffixIcon: _textEditingController.text.isNotEmpty
              ? IconButton(onPressed: _clearText, icon: const Icon(Icons.clear))
              : null,
        ),
      ),
    ]);
  }
}
