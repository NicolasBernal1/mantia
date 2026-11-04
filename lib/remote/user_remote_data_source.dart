import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mantia/models/user_profile.dart';

class UserRemoteDataSource {
  final FirebaseFirestore firestore;

  UserRemoteDataSource(this.firestore);

  Future<UserProfile?> getProfile(String uid) async {
    final snapshot = await firestore.collection('users').doc(uid).get();
    final data = snapshot.data();
    return data == null ? null : UserProfile.fromJson(data);
  }

  Future<UserProfile> createProfile({
    required String uid,
    required String email,
    required String displayName,
  }) async {
    final profile = UserProfile(
      uid: uid,
      email: email,
      displayName: displayName,
      role: UserRole.requester,
    );
    await firestore.collection('users').doc(uid).set(profile.toJson());
    return profile;
  }

  Future<List<UserProfile>> getTechnicians() async {
    final snapshot = await firestore
        .collection('users')
        .where('role', isEqualTo: UserRole.technician)
        .get();
    return snapshot.docs.map((doc) => UserProfile.fromJson(doc.data())).toList();
  }
}
