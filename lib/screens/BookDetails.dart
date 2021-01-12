
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_book_portfolio/model/book.dart';

class BookDetails extends StatefulWidget {
  Book book;

  BookDetails({this.book});

  @override
  _BookDetailsState createState() => _BookDetailsState();
}

class _BookDetailsState extends State<BookDetails> {

  var refImages = FirebaseDatabase.instance.reference().child("Database");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black45,
        title: Text(widget.book.book_name),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                SizedBox(
                    width: 150,
                    height: 150,
                    child: Image.network(widget.book.url)),
                Text(
                  widget.book.book_name,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.pink),
                ),

                // Text(widget.book.book_code,style: TextStyle(fontSize: 40,color: Colors.pink),)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              widget.book.desc,
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black),
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
    );
  }
}
