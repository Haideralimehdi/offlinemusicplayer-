import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var isLoading = false.obs;

  User? get currentUser => _auth.currentUser;

  /// FETCH USER DATA (STREAM)
  Stream<DocumentSnapshot<Map<String, dynamic>>> userStream() {
    return _firestore
        .collection('users')
        .doc(currentUser!.uid)
        .snapshots();
  }

  /// UPDATE NAME ONLY
  Future<void> updateName(String name) async {
    try {
      isLoading.value = true;

      await _firestore.collection('users').doc(currentUser!.uid).update({
        'name': name,
      });
    } finally {
      isLoading.value = false;
    }
  }
}
