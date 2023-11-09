// import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;
// import 'package:html/dom.dart';

class HttpHelper {
  final String _urlBase = 'https://p.eagate.573.jp/game/dan/1st/news/news.html';
  final String _urlBaseTrans =
      'https://api.apilayer.com/language_translation/translate?target=en';
  final List<String> _listApi = ['7jjCFJjSLLquB2osu7fWG0NizScgTL15'];
  // https://apilayer.com/marketplace/language_translation-api ?? api 7jjCFJjSLLquB2osu7fWG0NizScgTL15

  Future<String> getDrsBlog() async {
    var url = Uri.parse(_urlBase);
    http.Response result = await http.get(url);
    if (result.statusCode == 200) {
      final document = parse(result.body);
      // final body = document.querySelector('body');
      final divs = document.querySelectorAll('div');

      return divs[0].innerHtml;
      // if (divs.length >= 2) {
      // return divs[1].outerHtml;
      // }
    }

    return 'Failed to fetch and parse HTML';
  }

  Future<String> postTranslate(String text) async {
    var url = Uri.parse(_urlBaseTrans);
    http.Response result = await http.post(
      url,
      headers: {
        "apikey": _listApi[0],
      },
      body: text,
    );
    if (result.statusCode == 200) {
      return result.body;
    }
    return 'null';
  }
}
