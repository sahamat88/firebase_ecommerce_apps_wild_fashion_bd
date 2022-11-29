import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FireStoreDbInstance {
  final Stream<QuerySnapshot> manShirt = FirebaseFirestore.instance
      .collection('categories')
      .doc('IBSF7RXjOE2JWQKsn80a')
      .collection('Man Shirt')
      .limit(7)
      .snapshots();

  final Stream<QuerySnapshot> flashSale = FirebaseFirestore.instance
      .collection('categories')
      .doc('Owf61dqjoC0DDGA3rNop')
      .collection('Flash Sale')
      .limit(7)
      .snapshots();

  final Stream<QuerySnapshot> womenDress = FirebaseFirestore.instance
      .collection('categories')
      .doc('4LLIH7duWNKcwX4Ti9oy')
      .collection('Dress')
      .limit(7)
      .snapshots();

      final  auth = FirebaseAuth.instance;
}


