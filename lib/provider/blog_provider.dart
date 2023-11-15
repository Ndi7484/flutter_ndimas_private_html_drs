import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_blog_html/http_helper.dart';
import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart' as dom;
import 'package:url_launcher/url_launcher.dart';
// import 'package:translator/translator.dart';

class BlogProvider extends ChangeNotifier {
  HttpHelper http = HttpHelper();
  // final translator = GoogleTranslator();

  String _htmlRaw = 'loading...';
  String get htmlRaw => _htmlRaw;
  set htmlRaw(value) {
    _htmlRaw = value;
    notifyListeners();
  }

  List<dom.Element>? _listElement;
  List<dom.Element>? get listElement => _listElement;
  set listElement(value) {
    _listElement = value;
    notifyListeners();
  }

  Future<void> loadDrsBlogHtmlRaw() async {
    final response = await http.getDrsBlog();
    htmlRaw = response;
    htmlFormater();
  }

  void htmlFormater() async {
    final document = parse(htmlRaw);
    final divs = document.querySelectorAll('dl');
    listElement = divs;
  }

  String dlParserDate(String htmlContent) {
    // Define a regular expression pattern to match the data-date attribute
    RegExp pattern = RegExp(r'data-date="([^"]+)"');

    // Find the first match in the HTML content
    Match? match = pattern.firstMatch(htmlContent);

    if (match != null) {
      // Extract the value within the data-date attribute
      String dataDate = match.group(1) ?? '';
      return dataDate;
    }
    return '';
  }

  String dateFormatter(String inputDate) {
    // Split the input into date and time parts
    String datePart = inputDate.substring(0, 8);
    // String timePart = inputDate.substring(9);

    // Convert the date part to the desired format
    String formattedDate =
        "${datePart.substring(6)}-${datePart.substring(4, 6)}-${datePart.substring(0, 4)}";

    // Combine the formatted date and time parts
    String formattedDateTime = formattedDate;

    return formattedDateTime;
  }

  String titleParser(String htmlContent) {
    // Parse the HTML content
    var document = parse(htmlContent);

    // Find the <div> element with the class "cl_news_title"
    var titleElement = document.querySelector('.cl_news_title');

    if (titleElement != null) {
      // Extract the text content within the <div> element
      String textContent = titleElement.text;
      return tr(textContent);
    }
    return '';
  }

  String? contentParser(String htmlContent) {
    var document = parse(htmlContent);
    
    List<dom.Node> listElement = [];

    var detailElement = document.querySelector('.cl_news_detail');

    if (detailElement != null) {
      for (var node in detailElement.children) {
        print(node);
        listElement.add(node);
      }
    }

    return (detailElement?.innerHtml);
  }

  Widget easyContent(String htmlContent) {
    htmlContent = htmlContent.replaceAll('<br>', '\n');
    var document = parse(htmlContent);

    var detailElement = document
        .querySelector('.cl_news_detail')!
        .querySelector('div')!
        .innerHtml;
    // var text = detailElement?.text ?? '';
    // text = text.replaceAll('<br>', '\n');
    List<Widget> listString = [];
    for (var el in detailElement.split('\n')) {
      if (el.contains('href')) {
        // Use the regular expression to split the string into segments
        List<String?> elements = RegExp(r'<[^>]+>|[^<]+')
            .allMatches(el)
            .map((match) => match.group(0))
            .toList();
        print(elements);
        List<InlineSpan> listTextSpan = [];
        for (int i = 0; i < elements.length; i++) {
          if (elements[i]!.contains('href')) {
            listTextSpan.add(TextSpan(
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  final String? match = RegExp(r'\"([^"]+)\"')
                      .stringMatch(elements[i - 2]!)
                      ?.replaceAll('"', '');
                  print(match);
                },
              text: tr(elements[i + 1]!),
              style: const TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.blue,
                  decorationStyle: TextDecorationStyle.solid,
                  decorationThickness: 3),
            ));
            i = i + 2;
          } else {
            listTextSpan.add(TextSpan(text: elements[i]?.trim()));
          }
        }
        listString.add(
          Text.rich(
            TextSpan(children: listTextSpan),
          ),
        );
      } else if (el.contains('src=')) {
        continue;
      } else {
        listString.add(
          Text(
            tr(el.trim()),
          ),
        );
      }
    }

    var imageElement = document.querySelector('.news_img_main');
    String imageUrl = imageElement?.attributes['src'] ?? '';

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...listString,
        const SizedBox(height: 8), // Add some space between text and image
        if (imageUrl != '') Image.network('https://p.eagate.573.jp$imageUrl'),
      ],
    );
  }

  Widget eventContent(BuildContext context, String htmlContent) {
    htmlContent = htmlContent.replaceAll('<br>', '\n');
    var document = parse(htmlContent);

    List<Widget> _listWidget = [];
    List<dom.Element> detailElement = document
        .querySelector('.cl_news_detail')!
        .querySelector('.cl_nodisp_in_digest')!
        .children;

    for (var el in detailElement) {
      if (el.className == 'news_img_main') {
        print('news_img_main');
        // _listWidget.add(Text('news img \n ${el.innerHtml}'));
        _listWidget.add(Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
          child: Image.network(
              'https://p.eagate.573.jp${el.attributes['src'] ?? ''}'),
        ));
      } else if (el.className == 'news_title_sub') {
        print('news_title_sub');
        // _listWidget.add(Text('news title \n ${el.innerHtml}'));
        _listWidget.add(
          Container(
            padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.grey[850],
            ),
            child: Text(
              tr(el.innerHtml.toString()),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      } else if (el.className == 'schedule') {
        _listWidget.add(Padding(
          padding: const EdgeInsets.fromLTRB(8, 2, 8, 0),
          child: Text(
            '${tr(el.text.replaceAll('\n', '').toString())}\n',
          ),
        ));
      } else if (el.className == 'news_2clm') {
        var news2clmParse = parse(el.innerHtml);
        var _queryTextHtml = news2clmParse.querySelector('.text')?.innerHtml;
        var _queryTextChild = news2clmParse.querySelector('.text')?.children;

        // Split the input string using regular expressions to extract HTML elements
        List<String> elements = (_queryTextHtml ?? '').split(RegExp(r'(<[^>]*>.*?)'));

        // Remove empty or whitespace elements
        elements.removeWhere((element) => element.trim().isEmpty);

        List<String> listYellow = [];
        List<String> listRed = [];
        for (var el2 in (_queryTextChild ?? [])) {
          if (el2.attributes['style']!.contains('yellow')) {
            listYellow.add(el2.text);
          } else if (el2.attributes['style']!.contains('#ff')) {
            listRed.add(el2.text);
          }
        }

        _listWidget.add(
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
            child: Text.rich(
              TextSpan(
                  children: List.generate(elements.length, (index) {
                if (listYellow.contains(elements[index])) {
                  return TextSpan(
                      text: tr(elements[index].trim()),
                      style: const TextStyle(
                          backgroundColor: Colors.yellowAccent));
                } else if (listRed.contains(elements[index])) {
                  return TextSpan(
                      text: tr(elements[index].trim()),
                      style: const TextStyle(color: Colors.red));
                } else {
                  return TextSpan(text: tr(elements[index].trim()));
                }
              })),
            ),
          ),
        );

        // image image image
        _listWidget.add(
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
            child: Image.network(
                'https://p.eagate.573.jp${news2clmParse.querySelector('img')!.attributes['src']!}'),
          ),
        );
        _listWidget.add(const Divider(
          indent: 8,
          endIndent: 8,
          thickness: 2,
        ));
      } else if (el.className == 'cl_nodisp_in_digest') {
        for (var el2 in el.text.split('\n')) {
          _listWidget.add(Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: Text(tr(el2.trim())),
          ));
        }
        _listWidget.add(
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
            child: Image.network(
                'https://p.eagate.573.jp${parse(el.innerHtml).querySelector('img')?.attributes['src']}'),
          ),
        );
      } else {
        print('object else');
        _listWidget.add(Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: Text('object \n ${el.innerHtml}'),
        ));
      }
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _listWidget,
    );
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      print('Could not launch $url');
    }
  }
}
