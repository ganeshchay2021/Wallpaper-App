import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future addWallpaper(
      Map<String, dynamic> wallpaperInfo, String id, String category) async {
    return await FirebaseFirestore.instance
        .collection(category)
        .doc(id)
        .set(wallpaperInfo);
  }
}
