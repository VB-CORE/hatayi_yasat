import 'package:equatable/equatable.dart';

final class FavoriteState extends Equatable {
  const FavoriteState({
    this.searchWord = '',
    this.isGridView = false,
  });

  final String searchWord;
  final bool isGridView;

  bool get isSearchActive => searchWord.isNotEmpty;

  @override
  List<Object> get props => [searchWord, isGridView];

  FavoriteState copyWith({
    String? searchWord,
    bool? isGridView,
  }) {
    return FavoriteState(
      searchWord: searchWord ?? this.searchWord,
      isGridView: isGridView ?? this.isGridView,
    );
  }
}
