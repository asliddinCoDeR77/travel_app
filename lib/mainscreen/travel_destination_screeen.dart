import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:permissions/services/add_destionation.dart';

class TravelDestinationsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Travel Destinations'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AddEditDestinationScreen()),
              );
            },
          ),
        ],
      ),
      body: StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection('destinations').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final destinations = snapshot.data!.docs;

          return GridView.builder(
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemCount: destinations.length,
            itemBuilder: (context, index) {
              final destination = destinations[index];

              return GridTile(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddEditDestinationScreen(
                          id: destination.id,
                          title: destination['title'],
                          photoUrl: destination['photoUrl'],
                          location: destination['location'],
                        ),
                      ),
                    );
                  },
                  child:
                      Image.network(destination['photoUrl'], fit: BoxFit.cover),
                ),
                footer: GridTileBar(
                  backgroundColor: Colors.black54,
                  title: Text(destination['title']),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      FirebaseFirestore.instance
                          .collection('destinations')
                          .doc(destination.id)
                          .delete();
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
