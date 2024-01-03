import 'package:flutter/material.dart';

class GifsSearchBox extends StatelessWidget {
  const GifsSearchBox({
    super.key,
    required this.searchController,
    required this.onSearch,
  });

  final TextEditingController searchController;
  final ValueChanged<String> onSearch;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: searchController,
      textInputAction: TextInputAction.search,
      onSubmitted: onSearch,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.search),
        labelText: 'Keyword',
      ),
    );
  }
}
