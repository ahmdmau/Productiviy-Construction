part of 'models.dart';

class CategoryWork extends Equatable {
  final int id;
  final String title;
  final String subtitle;

  CategoryWork(
      {@required this.id, @required this.title, @required this.subtitle});

  @override
  List<Object> get props => [id, title, subtitle];
}

List<CategoryWork> dummyCategoryWorks = [
  CategoryWork(
      id: 1,
      title: "Pembesian",
      subtitle: "Hitung Pembesian anda agar tepat dan akurat"),
  CategoryWork(
      id: 2,
      title: "Pengecoran",
      subtitle: "Hitung Pengecoran tepat dan akurat")
];
