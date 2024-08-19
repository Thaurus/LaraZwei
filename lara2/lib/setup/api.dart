import 'package:cloud_firestore/cloud_firestore.dart';


FirebaseFirestore db = FirebaseFirestore.instance;

// Method to upload String to Firebase
Future<void> uploadString(String string) async {
  try {
    await db.collection("test").add({"string": string});
  } catch (e) {
    print(e);
  }
  // await db.collection("test").add({"string": string});
}