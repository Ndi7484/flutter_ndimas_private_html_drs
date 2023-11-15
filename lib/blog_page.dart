import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_blog_html/provider/blog_provider.dart';
import 'package:provider/provider.dart';

class BlogPage extends StatefulWidget {
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  final int _numberCard = 10;
  int _numberPage = 1;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent - 200 ||
        _scrollController.position.outOfRange) {
      // User has reached the end of the list, load more data here
      setState(() {
        _numberPage =
            _numberPage + 1; // Increase the page number to load more data
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    context.setLocale(const Locale('en', 'US'));
    var blogProv = Provider.of<BlogProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('DRS Update'),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            if (blogProv.listElement != null)
              ...List.generate(
                  blogProv.listElement!
                      .sublist(0, _numberPage * _numberCard)
                      .length, (index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Card(
                    elevation: 4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // date
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(color: Colors.grey[400]),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                blogProv.dateFormatter(
                                  blogProv.dlParserDate(
                                      blogProv.listElement![index].outerHtml),
                                ),
                              ),
                              // title
                              Text(
                                blogProv.titleParser(
                                    blogProv.listElement![index].outerHtml),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        (!blogProv.listElement![index].outerHtml
                                .contains('data-type="event"'))
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: blogProv.easyContent(
                                    blogProv.listElement![index].outerHtml),
                              )
                            : Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: blogProv.eventContent(context,
                                    blogProv.listElement![index].outerHtml),
                              )
                      ],
                    ),
                  ),
                );
              }),
            if (blogProv.listElement == null)
              Center(
                heightFactor: MediaQuery.of(context).size.height * 0.025,
                child: const CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }
}
