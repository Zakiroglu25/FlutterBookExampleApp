import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_book_portfolio/model/aforizmler.dart';
import 'package:flutter_book_portfolio/model/book.dart';

import 'BookDetails.dart';
import 'FavoritePage.dart';

class BookPage extends StatefulWidget {
  @override
  _BookPageState createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  var refAfo = FirebaseDatabase.instance.reference().child("aforizm");

  var refImages = FirebaseDatabase.instance.reference().child("Database");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 120,
              child: StreamBuilder<Event>(
                  stream: refAfo.onValue,
                  builder: (context, event) {
                    if (event.hasData) {
                      var afoList = List<Aforizmler>();

                      var gelenDeger = event.data.snapshot.value;
                      if (gelenDeger != null) {
                        gelenDeger.forEach((key, nesne) {
                          var gelenAfo = Aforizmler.fromJson(key, nesne);
                          afoList.add(gelenAfo);
                        });
                      }

                      return ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: afoList.length,
                          itemBuilder: (context, indeks) {
                            var aforizm = afoList[indeks];
                            return Padding(
                              padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                              child: Card(
                                color: Colors.black87,
                                elevation: 4,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: SizedBox(
                                  width: 260,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        aforizm.name_person,
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 8.0),
                                        child: Text(
                                          aforizm.content_id,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  ),
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
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 0, 0),
              child: Row(
                children: [
                  Text(
                    "Programming books",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
            Container(
              height: 210,
              child: StreamBuilder<Event>(
                  stream: refImages.onValue,
                  builder: (context, event) {
                    if (event.hasData) {
                      var bookList = List<Book>();

                      var gelenImage = event.data.snapshot.value;
                      if (gelenImage != null) {
                        gelenImage.forEach((key, nesne) {
                          var gelenImage = Book.fromJson(key, nesne);
                          bookList.add(gelenImage);
                        });
                      }

                      return ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: bookList.length,
                          itemBuilder: (context, indeks) {
                            var book = bookList[indeks];
                           return Padding(
                             padding: const EdgeInsets.all(12.0),
                             child: GestureDetector(
                               onTap: (){
                                 Navigator.push(
                                     context,
                                     MaterialPageRoute(
                                         builder: (context) => BookDetails(
                                           book: book,
                                         )));
                               },
                               child: Card(
                                 elevation: 10,
                                    child: Image.network("${book.url}"),
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
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 0, 0),
              child: Row(
                children: [
                  Text(
                    "Programming books",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),

            Container(
              height: 210,
              child: StreamBuilder<Event>(
                  stream: refImages.onValue,
                  builder: (context, event) {
                    if (event.hasData) {
                      var bookList = List<Book>();

                      var gelenImage = event.data.snapshot.value;
                      if (gelenImage != null) {
                        gelenImage.forEach((key, nesne) {
                          var gelenImage = Book.fromJson(key, nesne);
                          bookList.add(gelenImage);
                        });
                      }

                      return ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: bookList.length,
                          itemBuilder: (context, indeks) {
                            var book = bookList[indeks];
                            return Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: GestureDetector(
                                onTap: (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => BookDetails(
                                            book: book,
                                          )));
                                },
                                child: Card(
                                  elevation: 10,
                                  child: Image.network("${book.url}"),
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
