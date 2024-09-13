import 'package:Catsbreeds/infrastructure/models/cat.dart';
import 'package:Catsbreeds/screens/home_screen.dart';
import 'package:flutter/material.dart';

class DetailsCat extends StatefulWidget {
  
  final Cat cats;
  final String urlImage;
  const DetailsCat({super.key, required this.cats, required this.urlImage});

  @override
  State<DetailsCat> createState() => _DetailsCatState();
}

class _DetailsCatState extends State<DetailsCat> {
  Cat? cat;
  String url = '';
  @override
  void initState() {
    super.initState();
    cat = widget.cats; 
    url = widget.urlImage;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        titleSpacing: 70,
        leading: IconButton(onPressed: (){
          Navigator.pushAndRemoveUntil(
            context, 
            MaterialPageRoute(builder: (context){
              return  HomeScreen();
            }),
            (route) => false
          );
        }, 
        icon: Icon(Icons.arrow_back_ios)),
        title: null,
        flexibleSpace: Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 30,),
            Text('${cat?.name}', style: TextStyle(fontSize: 20),)
          ],
        )),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Image.network(url),
            SizedBox(height: 20,),
            Expanded(
              child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${cat?.description}'
                    '\n\nCountry: ${cat?.origin}'
                    '\nIntelligence: ${cat?.intelligence}'
                    '\nAdaptability: ${cat?.adaptability}'
                    '\nLife Span: ${cat?.lifeSpan}'
                    '\n',
                    style: TextStyle(fontSize: 20),)
                ],
              ),
            ),
            )
          ],
        )
      ),
    );
  }
}