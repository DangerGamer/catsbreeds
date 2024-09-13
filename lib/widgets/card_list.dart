import 'package:flutter/material.dart';
import '../infrastructure/models/cat.dart';
import '../services/cat_services.dart';
import 'details_cat.dart';

class CatList extends StatelessWidget {
  final List<Cat> cats;

  CatList({required this.cats});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: cats.length,
      itemBuilder: (context, index) {
        final cat = cats[index];
        return CatListItem(cat: cat);
      },
    );
  }
}

class CatListItem extends StatelessWidget {
  final Cat cat;
  final CatService _catService = CatService();

  CatListItem({required this.cat});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: _catService.fetchImageUrl(cat.id),
      builder: (context, snapshot) {
        Widget content;
        if (snapshot.connectionState == ConnectionState.waiting) {
          content = Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          content = Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final imageUrl = snapshot.data;
          content = Column(
            children: [
              Container(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(cat.name, style: TextStyle(fontSize: 15)),
                            TextButton(
                              onPressed: () {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailsCat(cats: cat, urlImage: imageUrl ?? ''),
                                  ),
                                  (route) => false
                                );
                              },
                              child: Text('More...', style: TextStyle(color: Colors.black),),
                            ),
                          ],
                        ),
                        if (imageUrl != null)
                          Center(
                            child: Image.network(
                              imageUrl,
                              width: 300,
                              height: 400,
                            ),
                          ),
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Origin: ${cat.origin}', style: TextStyle(fontSize: 15)),
                            Text('Intelligence: ${cat.intelligence}',style: TextStyle(fontSize: 15))
                          ],
                        ),
                      ],
                    ),
                  ),
            ],
          );
        } else {
          content = Center(child: Text('No image available'));
        }
        return Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1),
          ),
          child: Card(
            elevation: 0,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
            child: content,
          ),
        );
      },
    );
  }
}
