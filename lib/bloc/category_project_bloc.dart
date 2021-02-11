import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:productivity_contruction/models/models.dart';
import 'package:productivity_contruction/services/services.dart';

part 'category_project_event.dart';
part 'category_project_state.dart';

class CategoryProjectBloc
    extends Bloc<CategoryProjectEvent, CategoryProjectState> {
  CategoryProjectBloc() : super(CategoryProjectInitial());

  @override
  Stream<CategoryProjectState> mapEventToState(
    CategoryProjectEvent event,
  ) async* {
    if (event is FetchCategoryProject) {
      List<CategoryProjectModel> categoryProjectModel =
          await CategoryProjectServices.getTransaction();
      yield CategoryProjectLoaded(categoryProjectModel: categoryProjectModel);
    }
  }
}
