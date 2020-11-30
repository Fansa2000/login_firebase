import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class InternsList extends StatefulWidget {
  const InternsList({
    Key key,
    @required FirebaseFirestore firestore,
  })  : _firestore = firestore,
        super(key: key);

  final FirebaseFirestore _firestore;


  @override
  _InternsListState createState() => _InternsListState();
}

class _InternsListState extends State<InternsList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold( backgroundColor: Colors.indigo[900].withOpacity(0.2),
      appBar: AppBar( elevation: 0,
        backgroundColor: Colors.purple[900].withOpacity(0.2),
        title: Text(
          'Interns',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height + 150,
        width: MediaQuery.of(context).size.width,
        child: StreamBuilder<QuerySnapshot>(
            stream: widget._firestore.collection('intern_details').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.lightBlue,
                  ),
                );
              }
              final details = snapshot.data.docs;
              List<DetailLayout> detaillayouts = [];
              for (var detail in details) {
                final detailName = detail.data()['name'];
                final detailDepartment = detail.data()['department'];
                final detailLayout = DetailLayout(
                  name: detailDepartment,
                  department: detailName,
                );
                detaillayouts.add(detailLayout);
              }
              return Expanded(
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  children: detaillayouts,
                ),
              );
            }),
      ),
    );
  }
}

class DetailLayout extends StatelessWidget {
  DetailLayout({this.name, this.department});
  final String name;
  final String department;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Material(
        color: Colors.indigo[900].withOpacity(0.01),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(
            '$department  $name',
            style: TextStyle(fontSize: 15, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
