part of 'services.dart';

class ProjectServies {
  static CollectionReference _projectCollection =
      FirebaseFirestore.instance.collection("project");
  static FirebaseAuth auth = FirebaseAuth.instance;

  static Future<void> addProject(WorkModel workModel) async {
    final User user = auth.currentUser;
    final uid = user.uid;
    _projectCollection.doc().set({
      'id': workModel.id,
      'userID': uid,
      'workName': workModel.workName,
      'workLocation': workModel.workLocation,
      'workDate': workModel.workDate,
      'startTime': workModel.startTime,
      'endTime': workModel.endTime,
      'durationTime': workModel.durationTime,
      'totalWorker': workModel.totalWorker,
      'workResult': workModel.workResult,
      'idProject': workModel.idProject,
      'idTypeWork': workModel.idTypeWork,
      'effective': workModel.effective,
      'contributory': workModel.contributory,
      'ineffective': workModel.ineffective,
      'productivityResult': workModel.productivityResult,
      'weather': workModel.weather,
      'createdAt': Timestamp.now()
    });
  }

  static Future<List<WorkModel>> getWork(String projectID) async {
    final User user = auth.currentUser;
    final uid = user.uid;

    QuerySnapshot snapshot = await _projectCollection
        .orderBy('createdAt', descending: true)
        .where('userID', isEqualTo: uid)
        .where('idProject', isEqualTo: projectID)
        .get();

    var documents = snapshot.docs;

    return documents
        .map((e) => WorkModel(
              id: e.data()['id'],
              idProject: e.data()['idProject'],
              idTypeWork: e.data()['idTypeWork'],
              workName: e.data()['workName'],
              workLocation: e.data()['workLocation'],
              workDate: e.data()['workDate'],
              startTime: e.data()['startTime'],
              endTime: e.data()['endTime'],
              durationTime: e.data()['durationTime'],
              totalWorker: e.data()['totalWorker'],
              workResult: e.data()['workResult'],
              productivityResult: e.data()['productivityResult'],
              effective: e.data()['effective'],
              contributory: e.data()['contributory'],
              ineffective: e.data()['ineffective'],
              weather: e.data()['weather'],
              createdAt: e.data()['createdAt'],
            ))
        .toList();
  }

  static Future<void> updateData(String id) async {
    final User user = auth.currentUser;
    final uid = user.uid;
    // _projectCollection.where('userID', isEqualTo: uid).get().then((value) => {
    //       if (value.size > 0)
    //         {
    //           print("found"),
    //           print(value.docs[0].id),
    //           value.docs.forEach((item) => {
    //                 _projectCollection.doc(item.id).update({"isDeleted": true})
    //               })
    //         }
    //       else
    //         {
    //           print("not found"),
    //         }
    //     });

    _projectCollection
        .where('userID', isEqualTo: uid)
        .where('id', isEqualTo: id)
        .get()
        .then(
          (value) => {
            if (value.size > 0)
              {
                value.docs.forEach(
                  (element) => {_projectCollection.doc(element.id).delete()},
                )
              }
          },
        );
  }
}
