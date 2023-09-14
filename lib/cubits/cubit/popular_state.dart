part of 'popular_cubit.dart';

@immutable
sealed class PopularState {}

final class PopularInitial extends PopularState {}

class PopularLoading extends PopularState {}

class PopularFetched extends PopularState {
  final List<ProductsModel> products;

  PopularFetched(this.products);
}

class PopularFetchError extends PopularState {}
