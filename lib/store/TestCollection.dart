import 'package:cloud_firestore/cloud_firestore.dart';

Future<List<String>> getFavorites(String user_id) async {
  DocumentSnapshot querySnapshot = await Firestore.instance
      .collection('test')
      .document(user_id)
      .get();
  if (querySnapshot.exists &&
      querySnapshot.data.containsKey('name') &&
      querySnapshot.data['name'] is List) {
    return List<String>.from(querySnapshot.data['name']);
  }
  return [];
}