import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_book_portfolio/model/book.dart';
import 'package:flutter_book_portfolio/screens/BookDetails.dart';

class FavPage extends StatefulWidget {
  @override
  _FavPageState createState() => _FavPageState();
}

class _FavPageState extends State<FavPage> {

  String aramaKelimesi= "";
  bool _aramaYapiliyormu= true;

  var refImages = FirebaseDatabase.instance.reference().child("Database");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 40,
                child: TextField(
                  onChanged: (aramaSonuc){
                    setState(() {
                      aramaKelimesi = aramaSonuc;
                    });
                  },
                  autofocus: true,

                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey,
                    prefixIcon: Icon(Icons.search),
                    hintText: "Search here...",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none),
                  ),
                ),
              ),
            ),
            Container(
              child: StreamBuilder<Event>(
                  stream: refImages.onValue,
                  builder: (context, event) {
                    if (event.hasData) {
                      var bookList = List<Book>();

                      var gelenImage = event.data.snapshot.value;
                      if (gelenImage != null) {
                        gelenImage.forEach((key, nesne) {
                          var gelenImage = Book.fromJson(key, nesne);
                          if(_aramaYapiliyormu) {
                            if (gelenImage.book_name.contains(aramaKelimesi)) {
                              bookList.add(gelenImage);
                            }
                          }
                         else{
                            bookList.add(gelenImage);
                          }
                        });
                      }

                      return ListView.builder(
                          primary: false,
                          shrinkWrap: true,
                          itemCount: bookList.length,
                          itemBuilder: (context, indeks) {
                            var book = bookList[indeks];

                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => BookDetails(
                                          book: book,
                                        )));
                              },
                              child: Container(
                                alignment: Alignment.topLeft,
                                height: 200,
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SizedBox(
                                        width: 150,
                                        child: Card(
                                          elevation: 8,
                                          child: Image.network("${book.url}"),
                                        ),
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text("${book.book_name}",style: TextStyle(
                                          fontSize: 18
                                        ),),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("${book.book_code}",style: TextStyle(color: Colors.blue),),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
