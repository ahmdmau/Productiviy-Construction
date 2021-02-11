part of 'category_project_bloc.dart';

abstract class CategoryProjectState extends Equatable {
  const CategoryProjectState();

  @override
  List<Object> get props => [];
}

class CategoryProjectInitial extends CategoryProjectState {}

class CategoryProjectLoaded extends CategoryProjectState {
  final List<CategoryProjectModel> categoryProjectModel;

  CategoryProjectLoaded({this.categoryProjectModel});

  @override
  List<Object> get props => [categoryProjectModel];
}
