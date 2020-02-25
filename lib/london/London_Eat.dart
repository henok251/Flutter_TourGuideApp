import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LondonEat extends StatefulWidget {
  @override
  _LondonEatState createState() => new _LondonEatState();
}

class _LondonEatState extends State<LondonEat> {

  String img = "https://images.pexels.com/photos/1566837/pexels-photo-1566837.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940";


  Future getEat() async {
    var firestore = Firestore.instance;
    QuerySnapshot snapshot = await firestore.collection("london_eat_offer")
        .getDocuments();
    return snapshot.documents;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(

      body: CustomScrollView(
        slivers: <Widget>[

          SliverAppBar(
            expandedHeight: 250.0,
            floating: false,
            pinned: true,
            backgroundColor: Colors.deepOrange,
            flexibleSpace: FlexibleSpaceBar(
              title: Text("Eat quality food"),
              background: Image.network(img,
                fit: BoxFit.cover,
              ),
            ),
          ),

          SliverFillRemaining(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[

                  Container(
                    height: 300.0,
                    margin: EdgeInsets.only(top: 10.0),
                    child: FutureBuilder(
                        future: getEat(),
                        builder: (BuildContext context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: snapshot.data.length,
                                itemBuilder: (BuildContext context, index) {
                                  var ourDate = snapshot.data[index];
                                  return Container(
                                    margin: EdgeInsets.only(left: 10.0),
                                    child: Stack(
                                      children: <Widget>[

                                        Container(
                                          height: 250.0,
                                          width: 370.0,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                                20.0),
                                            child: Image.network(
                                              ourDate.data['img'],
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 80.0,
                                          left: 10.0,
                                          child: Container(
                                            height: 150.0,
                                            width: 340.0,
                                            child: Card(
                                              elevation: 10.0,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius
                                                      .circular(20.0)
                                              ),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment
                                                    .start,
                                                children: <Widget>[
                                                  Container(
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: <Widget>[

                                                        Container(
                                                          padding: EdgeInsets.all(
                                                              10.0),
                                                          child: Text(
                                                            ourDate.data['title'],
                                                            maxLines: 1,
                                                            style: TextStyle(
                                                                fontSize: 18.0,
                                                                fontWeight: FontWeight
                                                                    .bold
                                                            ),
                                                          ),
                                                        ),

                                                        Container(
                                                            child: Icon(Icons.arrow_forward,size: 30.0,color: Colors.amber,),
                                                          margin: EdgeInsets.only(right: 15.0),
                                                        )

                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(height: 6.0,),
                                                  Container(
                                                    padding: EdgeInsets.all(
                                                        10.0),
                                                    child: Text("\$" +
                                                        ourDate.data['price'],
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                          fontSize: 18.0,
                                                          fontWeight: FontWeight
                                                              .bold,
                                                          color: Colors
                                                              .deepOrange
                                                      ),
                                                    ),
                                                  ),

                                                  SizedBox(height: 5.0,),

                                                  Container(
                                                    margin: EdgeInsets.all(10.0),
                                                    child: Row(
                                                      children: <Widget>[

                                                        Expanded(
                                                          flex: 2,
                                                          child: Row(
                                                            children: <Widget>[
                                                              Icon(Icons.fastfood),
                                                              SizedBox(width: 5.0,),
                                                              Text("Dessert",
                                                              style: TextStyle(
                                                                fontSize: 20.0,
                                                              ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 1,
                                                          child: Row(
                                                            children: <Widget>[
                                                              Icon(Icons.location_city),
                                                              SizedBox(width: 5.0,),
                                                              Text(ourDate.data['distance']+"km",
                                                                style: TextStyle(
                                                                  fontSize: 20.0,
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),

                                                        Expanded(
                                                          flex: 1,
                                                          child: Row(
                                                            children: <Widget>[
                                                              Icon(Icons.person_outline),
                                                              SizedBox(width: 5.0,),
                                                              Text(ourDate.data['person'],
                                                                style: TextStyle(
                                                                  fontSize: 20.0,
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),



                                                      ],
                                                    ),
                                                  )



                                                ],
                                              ),
                                            ),
                                          ),
                                        )


                                      ],
                                    ),
                                  );
                                }
                            );
                          }
                        }
                    ),
                  ),


                ],
              ),
            ),
          ),

        ],
      ),

    );
  }
}


