part of 'models.dart';

class WorkModel {
  String id;
  String workName;
  String workLocation;
  Timestamp workDate;
  String startTime;
  String endTime;
  double durationTime;
  int totalWorker;
  double workResult;
  double workProductivity;
  String note;
  String idProject;
  int idTypeWork;
  int effective;
  int contributory;
  int ineffective;
  double productivityResult;
  String weather;
  Timestamp createdAt;

  WorkModel(
      {this.id,
      this.workName,
      this.workLocation,
      this.workDate,
      this.startTime,
      this.endTime,
      this.durationTime,
      this.totalWorker,
      this.workResult,
      this.workProductivity,
      this.note,
      this.idProject,
      this.idTypeWork,
      this.effective,
      this.contributory,
      this.ineffective,
      this.productivityResult,
      this.weather,
      this.createdAt})
      : super();

  // partially applicable sorter
  static Function(WorkModel, WorkModel) sorter(int sortOrder, String property) {
    int handleSortOrder(int sortOrder, int sort) {
      if (sortOrder == 1) {
        // a is before b
        if (sort == -1) {
          return -1;
        } else if (sort > 0) {
          // a is after b
          return 1;
        } else {
          // a is same as b
          return 0;
        }
      } else {
        // a is before b
        if (sort == -1) {
          return 1;
        } else if (sort > 0) {
          // a is after b
          return 0;
        } else {
          // a is same as b
          return 0;
        }
      }
    }

    return (WorkModel a, WorkModel b) {
      switch (property) {
        case "createdAt":
          int sort = a.createdAt.compareTo(b.createdAt);
          return handleSortOrder(sortOrder, sort);
        case "createdAt":
          int sort = a.createdAt.compareTo(b.createdAt);
          return handleSortOrder(sortOrder, sort);
        default:
          break;
      }
    };
  }

  // sortOrder = 1 ascending | 0 descending
  static void sortPosts(List<WorkModel> posts,
      {int sortOrder = 1, String property = "createdAt"}) {
    switch (property) {
      case "createdAt":
        posts.sort(sorter(sortOrder, property));
        break;
      case "createdAt":
        posts.sort(sorter(sortOrder, property));
        break;
      default:
        print("Unrecognized property $property");
    }
  }
}
