import 'package:equatable/equatable.dart';
import 'package:life_shared/life_shared.dart';

final class HomeState extends Equatable {
  const HomeState({required this.categories});

  final List<CategoryModel> categories;
  @override
  List<Object> get props => [
        categories,
      ];
}
