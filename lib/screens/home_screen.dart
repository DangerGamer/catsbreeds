import 'package:flutter/material.dart';
import 'package:Catsbreeds/widgets/search_box.dart';
import '../infrastructure/models/cat.dart';
import '../services/cat_services.dart';
import '../widgets/card_list.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CatService _catService = CatService();
  List<Cat> _cats = [];
  String _searchText = '';
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchCats('');
  }

  Future<void> _fetchCats(String filter) async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final cats = await _catService.fetchCatsBreeds(filter);
      setState(() {
        _cats = cats;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Error fetching cats: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _handleTextChanged(String text) {
    setState(() {
      _searchText = text;
    });
    _fetchCats(_searchText);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Catsbreeds'),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            SearchBox(onTextChanged: _handleTextChanged),
            if (_isLoading) 
              Center(child: CircularProgressIndicator()),
            if (_errorMessage != null)
              Center(child: Text('Not Data Found')),
            if (!_isLoading && _errorMessage == null)
              Expanded(child: CatList(cats: _cats)),
          ],
        ),
      ),
    );
  }
}
