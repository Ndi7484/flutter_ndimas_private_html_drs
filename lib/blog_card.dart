// import 'package:flutter/material.dart';
// import 'package:flutter_application_drs/core/BlogState.dart';
// import 'package:intl/intl.dart';
// import 'package:url_launcher/url_launcher.dart';

// class BlogCard extends StatelessWidget {
//   Blog blog;
//   BlogCard({super.key, required this.blog});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: MediaQuery.of(context).size.width,
//       padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
//       child: Card(
//         elevation: 4.0,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               padding: const EdgeInsets.all(8.0),
//               decoration: BoxDecoration(color: Colors.grey[300]),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(DateFormat('yyyy-MM-dd').format(blog.date).toString()),
//                   const SizedBox(
//                     height: 4,
//                   ),
//                   Text(
//                     blog.title,
//                     style: const TextStyle(fontWeight: FontWeight.bold),
//                   )
//                 ],
//               ),
//             ),
//             const SizedBox(
//               height: 8,
//             ),
//             ...List.generate(blog.content.length, (index) {
//               switch (blog.content[index].type) {
//                 case 'text_bold':
//                   return Container(
//                     decoration: BoxDecoration(color: Colors.grey[850]),
//                     padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
//                     child: Row(children: [
//                       Text(
//                         (blog.content[index].content!).replaceAll('\\n', '\n'),
//                         style: const TextStyle(
//                             fontWeight: FontWeight.bold, color: Colors.white),
//                       ),
//                       const Spacer(),
//                     ]),
//                   );
//                 case 'text_red':
//                   return Padding(
//                     padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
//                     child: Text(
//                       (blog.content[index].content!).replaceAll('\\n', '\n'),
//                       style: const TextStyle(color: Colors.red),
//                     ),
//                   );
//                 case 'link':
//                   return Padding(
//                     padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
//                     child: InkWell(
//                       onTap: () async {
//                         if (await canLaunchUrl(
//                             Uri.parse(blog.content[index].href.toString()))) {
//                           await launchUrl(
//                               Uri.parse(blog.content[index].href.toString()));
//                         } else {
//                           throw 'Could not launch ${blog.content[index].href.toString()}';
//                         }
//                       },
//                       child: Text.rich(
//                         TextSpan(
//                           text: blog.content[index].content!,
//                           style: const TextStyle(
//                               color: Colors.blue,
//                               decoration: TextDecoration.underline),
//                         ),
//                       ),
//                     ),
//                   );
//                 case 'image':
//                   return Padding(
//                     padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
//                     child: Image.network(blog.content[index].content!),
//                   );
//                 case 'br':
//                   return const Divider(
//                     indent: 4,
//                     endIndent: 4,
//                     thickness: 2.0,
//                   );
//                 default:
//                   return Padding(
//                     padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
//                     child: Text(
//                         (blog.content[index].content!).replaceAll('\\n', '\n'),
//                         textAlign: TextAlign.justify),
//                   );
//               }
//             })
//           ],
//         ),
//       ),
//     );
//   }
// }
