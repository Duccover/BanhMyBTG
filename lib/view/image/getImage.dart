import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetImage extends StatelessWidget {
   GetImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('Bread').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) => GridView.builder(
              itemCount: snapshot.data!.docs.length,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              itemBuilder: (context,index) {
              QueryDocumentSnapshot x = snapshot.data!.docs[index];
               return InkWell(
                 onTap: (){
                   Navigator.push(context, MaterialPageRoute(builder: (context) => View(
                     url: x['imageUrl'],
                   ),));
                 },
                 child: Hero(tag: x['imageUrl'], child: Container(
                   child: Image.network(x['imageUrl'],fit: BoxFit.fill,),
                 )),
               );
              },),
        ));
  }
}
class View extends StatelessWidget {
  final url;
   View({this.url});
   
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(),
      body: Container(
        height: 500,
        width: 500,
        child: Hero(
          tag: url,
          child: Image.network(url,fit: BoxFit.fill,),
        ),
      ),
    );
  }
}
