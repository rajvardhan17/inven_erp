import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // 🧱 REGISTER WITH TENANT
  Future<void> registerBusiness({
    required String email,
    required String password,
    required String businessName,
    required String ownerName,
  }) async {
    try {
      // 1️⃣ Create Auth User
      final result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = result.user!;
      final userId = user.uid;

      // 2️⃣ Create Tenant
      final tenantRef = _firestore.collection('tenants').doc();
      final tenantId = tenantRef.id;

      await tenantRef.set({
        'businessName': businessName,
        'ownerId': userId,
        'createdAt': FieldValue.serverTimestamp(),
      });

      // 3️⃣ Create User inside Tenant
      await _firestore
          .collection('tenants')
          .doc(tenantId)
          .collection('users')
          .doc(userId)
          .set({
            'name': ownerName,
            'email': email,
            'role': 'admin',
            'tenantId': tenantId,
            'createdAt': FieldValue.serverTimestamp(),
          });
    } on FirebaseAuthException catch (e) {
      throw e.message ?? "Registration failed";
    }
  }
}
