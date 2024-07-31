import 'package:flutter/material.dart';

class SearchWidget extends StatefulWidget {
  final String title;
  final String routeNameForm;
  final List<dynamic> results;
  final Widget? Function(BuildContext context, int index) onItemBuilder;
  final Function() updateListView;

  SearchWidget({
    Key? key,
    required this.title,
    required this.routeNameForm,
    required this.results,
    required this.onItemBuilder,
    required this.updateListView,
  }) : super(key: key);

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  List<dynamic> _filteredResults = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredResults = widget.results;
    _searchController.addListener(_filterResults);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterResults() {
    setState(() {
      if (_searchController.text.isEmpty) {
        _filteredResults = widget.results;
      } else {
        _filteredResults = widget.results.where((item) {
          return item.toString().toLowerCase().contains(_searchController.text.toLowerCase());
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _body(context),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue[400],
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () async {
          await Navigator.pushNamed(context, widget.routeNameForm);
          widget.updateListView();
        },
      ),
    );
  }

  Widget _body(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _createSearchTextField(context),
          const SizedBox(height: 16),
          _createListView(context),
        ],
      ),
    );
  }

  Widget _createSearchTextField(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              labelText: "Pesquisar...",
              suffixIcon: Icon(Icons.search),
            ),
          ),
        ),
      ],
    );
  }

  Widget _createListView(BuildContext context) {
    if (_filteredResults.isEmpty) {
      return const Text(
        "Sem dados disponíveis",
        style: TextStyle(fontSize: 20),
      );
    } else {
      return Expanded(
        child: SizedBox(
          height: 150,
          child: ListView.builder(
            itemCount: _filteredResults.length,
            itemBuilder: (context, index) {
              return widget.onItemBuilder(context, index);
            },
          ),
        ),
      );
    }
  }
}
