// import 'dart:io';
// import 'package:http/http.dart' as http;

// class HttpHelper {
//   final String _urlKey = '?api_key=2851e952313e506fc87c66c611f084c0';
//   final String _urlBase = 'https://api.themoviedb.org';
//   // final String _imgBase = 'https://image.tmdb.org/t/p/w500';

//   Future<String> getMovieGenre() async {
//     var url = Uri.parse(_urlBase + '/3/genre/movie/list' + _urlKey);
//     http.Response result = await http.get(url);
//     if (result.statusCode == HttpStatus.ok) {
//       String responseBody = result.body;
//       return responseBody;
//     }
//     return result.statusCode.toString();
//   }

//   Future<String> getMovieNowPlaying(int numPage) async {
//     var url = Uri.parse(
//         _urlBase + '/3/movie/now_playing' + _urlKey + '&page=$numPage');
//     http.Response result = await http.get(url);
//     if (result.statusCode == HttpStatus.ok) {
//       String responseBody = result.body;
//       return responseBody;
//     }
//     return result.statusCode.toString();
//   }

//   Future<String> getMovieTopRated(int numPage) async {
//     var url =
//         Uri.parse(_urlBase + '/3/movie/top_rated' + _urlKey + '&page=$numPage');
//     http.Response result = await http.get(url);
//     if (result.statusCode == HttpStatus.ok) {
//       String responseBody = result.body;
//       return responseBody;
//     }
//     return result.statusCode.toString();
//   }

//   Future<String> getMovieLatest() async {
//     var url = Uri.parse(_urlBase + '/3/movie/latest' + _urlKey);
//     http.Response result = await http.get(url);
//     if (result.statusCode == HttpStatus.ok) {
//       String responseBody = result.body;
//       return responseBody;
//     }
//     return result.statusCode.toString();
//   }

//   Future<String> getMoviePopular(int numPage) async {
//     var url = Uri.parse(_urlBase + '/3/movie/popular' + _urlKey + '&page=$numPage');
//     http.Response result = await http.get(url);
//     if (result.statusCode == HttpStatus.ok) {
//       String responseBody = result.body;
//       return responseBody;
//     }
//     return result.statusCode.toString();
//   }

//   Future<String> getMovieUpcoming(int numPage) async {
//     var url =
//         Uri.parse(_urlBase + '/3/movie/upcoming' + _urlKey + '&page=$numPage');
//     http.Response result = await http.get(url);
//     if (result.statusCode == HttpStatus.ok) {
//       String responseBody = result.body;
//       return responseBody;
//     }
//     return result.statusCode.toString();
//   }
// }
