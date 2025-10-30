import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/movies_bloc/movies_bloc.dart';
import '../../../config/components/error_message_widget.dart';
import '../../../config/components/internet_exception_widget.dart';
import '../../../data/response/enums.dart';
import 'movie_card.dart';

class MoviesBody extends StatelessWidget {
  final MoviesBloc moviesBloc;

  const MoviesBody({super.key, required this.moviesBloc});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: moviesBloc..add(FetchMoviesEvent()),
      child: BlocBuilder<MoviesBloc, MoviesState>(
        builder: (context, state) {
          switch (state.moviesList.status) {
            case Status.loading:
              return const Center(child: CircularProgressIndicator());
            case Status.error:
              if (state.moviesList.message ==
                  'No Internet Connection: No internet connection') {
                return InternetExceptionWidget(
                  isLoading: state.moviesList.status == Status.loading, // 🔹 here
                  onPress: () {
                    moviesBloc.add(FetchMoviesEvent());
                  },
                );
              }
              return ErrorMessageWidget(
                message: state.moviesList.message.toString(),
                isLoading: state.moviesList.status == Status.loading, // 🔹 here
                onRetry: () {
                  moviesBloc.add(FetchMoviesEvent());
                },
              );

            case Status.completed:
              if (state.moviesList.data == null) {
                return const Center(child: Text("No Data"));
              }

              final shows = state.moviesList.data!;
              return GridView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: shows.tvShows.length,
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.68,
                ),
                itemBuilder: (context, index) {
                  final show = shows.tvShows[index];
                  return MovieCard(
                    show: show,
                    index: index,
                    onTap: () {
                      // TODO: navigate to details later
                    },
                  );
                },
              );

            default:
              return const Center(child: Text("Something went wrong"));
          }
        },
      ),
    );
  }
}
