import 'package:bloc_clean_coding/bloc/movies_bloc/movies_bloc.dart';
import 'package:bloc_clean_coding/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/components/internet_exception_widget.dart';
import '../../data/response/enums.dart';

class MoviesScreen extends StatefulWidget {
  const MoviesScreen({super.key});

  @override
  State<MoviesScreen> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {

  late MoviesBloc moviesBloc;

  @override
  void initState() {
    super.initState();
    moviesBloc = MoviesBloc(moviesRepository: getIt());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    moviesBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Popular TV Shows',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: BlocProvider(
        create: (context) => moviesBloc..add(FetchMoviesEvent()),
        child: BlocBuilder<MoviesBloc, MoviesState>(
          builder: (context, state) {
            switch(state.moviesList.status) {
              case Status.loading:
                return const Center(child: CircularProgressIndicator(),);
              case Status.error:
                if(state.moviesList.message == 'No Internet Connection: No internet connection') {
                  return InternetExceptionWidget(
                    onPress: () {
                      moviesBloc.add(FetchMoviesEvent());
                    },
                  );
                }
                return Center(child: Text(state.moviesList.message.toString()),);
              case Status.completed:
                if(state.moviesList.data == null) {
                  return const Center(child: Text("No Data"),);
                }
                final shows = state.moviesList.data!;
                return GridView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: shows.tvShows.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // 2 cards per row
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.68,
                  ),
                  itemBuilder: (context, index) {
                    final show = shows.tvShows[index];
                    return GestureDetector(
                      onTap: () {
                        // You can navigate to a details screen here later
                      },
                      child: Hero(
                        tag: index,
                        child: Card(
                          elevation: 5,
                          shadowColor: Colors.black26,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.network(
                                show.imageThumbnailPath.toString(),
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.broken_image,
                                    size: 80, color: Colors.grey),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.transparent,
                                      Colors.black.withOpacity(0.7),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 10,
                                right: 10,
                                bottom: 10,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      show.name.toString(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        const Icon(Icons.play_circle_fill,
                                            color: Colors.deepPurpleAccent,
                                            size: 16),
                                        const SizedBox(width: 4),
                                        Text(
                                          show.network.toString(),
                                          style: const TextStyle(
                                            color: Colors.white70,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              default:
                return const Center(child: Text("Something went wrong"),);
            }

          },
        ),
      ),
    );
  }
}
