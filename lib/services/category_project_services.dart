part of 'services.dart';

class CategoryProjectServices {
  static CollectionReference _categoryProjectCollection =
      FirebaseFirestore.instance.collection("category_project");
  static FirebaseAuth auth = FirebaseAuth.instance;

  static Future<void> addCategoryProject(
      CategoryProjectModel categoryProjectModel) async {
    final User user = auth.currentUser;
    final uid = user.uid;
    _categoryProjectCollection.doc().set({
      'id': categoryProjectModel.id,
      'userID': uid,
      'projectName': categoryProjectModel.projectName,
      'projectLocation': categoryProjectModel.projectLocation,
      'createdAt': Timestamp.now()
    });
  }

  static Future<List<CategoryProjectModel>> getTransaction() async {
    QuerySnapshot snapshot = await _categoryProjectCollection
        .orderBy('createdAt', descending: false)
        .get();
    final User user = auth.currentUser;
    final uid = user.uid;

    var documents =
        snapshot.docs.where((document) => document.data()['userID'] == uid);

    return documents
        .map((e) => CategoryProjectModel(
              id: e.data()['id'],
              projectName: e.data()['projectName'],
              projectLocation: e.data()['projectLocation'],
            ))
        .toList();
  }
}
