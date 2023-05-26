import 'package:flutter/material.dart';

class Search extends StatelessWidget {
  const Search({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: TextFormField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          label: Text("Search..."),
          suffixIcon: Icon(Icons.search),
          hintText: "Ex: Alen Walker",
        ),
      ),
    );
  }
}
