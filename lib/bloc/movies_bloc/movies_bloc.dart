import 'package:bloc/bloc.dart';
import 'package:bloc_clean_coding/data/response/api_response.dart';
import 'package:bloc_clean_coding/models/movies/movies.dart';
import 'package:bloc_clean_coding/repository/movies/movies_repository.dart';
import 'package:equatable/equatable.dart';

import '../../data/exceptions/app_exceptions.dart';
part 'movies_event.dart';
part 'movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  MoviesRepository moviesRepository;
  MoviesBloc({required this.moviesRepository})
    : super(MoviesState(moviesList: ApiResponse.loading())) {
    on<FetchMoviesEvent>(_onFetchMovies);
  }

  Future<void> _onFetchMovies(
    FetchMoviesEvent event,
    Emitter<MoviesState> emit,
  ) async {
    try {

      // 🔹 Emit loading immediately
      emit(state.copyWith(moviesList: ApiResponse.loading()));

      final response = await moviesRepository.fetchMoviesApiService();

      emit(state.copyWith(moviesList: ApiResponse.completed(response)));
    } on AppException catch (e) {
      print(e.toString());
      emit(state.copyWith(moviesList: ApiResponse.error(e.toString())));
    } catch (e) {
      emit(state.copyWith(moviesList: ApiResponse.error(e.toString())));
    }
  }
}
