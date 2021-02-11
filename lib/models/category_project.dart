part of 'models.dart';

class CategoryProjectModel extends Equatable {
  final String id;
  final String projectName;
  final String projectLocation;

  CategoryProjectModel({
    @required this.id,
    @required this.projectName,
    @required this.projectLocation,
  });

  @override
  List<Object> get props => [id, projectName, projectLocation];
}
