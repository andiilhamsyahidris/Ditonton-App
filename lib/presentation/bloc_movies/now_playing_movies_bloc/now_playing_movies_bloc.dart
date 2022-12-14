import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:equatable/equatable.dart';

part 'now_playing_movies_event.dart';
part 'now_playing_movies_state.dart';

class MovieListBloc extends Bloc<NowPlayingMoviesEvent, NowPlayingMoviesState> {
  final GetNowPlayingMovies getNowPlayingMovies;

  MovieListBloc({required this.getNowPlayingMovies}) : super(MovieListEmpty()) {
    on<FetchNowPlayingMovies>(
      (event, emit) async {
        emit(MovieListLoading());

        final result = await getNowPlayingMovies.execute();
        result.fold(
          (failure) {
            emit(MovieListError(failure.message));
          },
          (data) {
            emit(
              MovieListHasData(data),
            );
          },
        );
      },
    );
  }
}
