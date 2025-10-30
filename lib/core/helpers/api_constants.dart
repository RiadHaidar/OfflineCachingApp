class ApiConstants {
  static const String baseUrl = 'https://api.themoviedb.org/3';
  static const String bearerToken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI1NDFlN2IzYjA1YjdhMDJmYzlkMWMzMTUyN2JjMDU1YiIsIm5iZiI6MTc2MTc1MDc2NS4yODYsInN1YiI6IjY5MDIyZWVkNWU3YjM5ZjI0ZDkzNWM0ZSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.ZjvlpCqDz3k92eyeo-ka0LfVE-KpFUyUwwoz3wGRtoI';
}

class MoviesApiConstants {
  static const String discoverMovies = '/discover/movie';
  static const String movieDetails = '/movie/{id}';
}
