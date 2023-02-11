// ignore_for_file: no_leading_underscores_for_local_identifiers, unused_element

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unscript_app/news/service/news_service.dart';
import 'package:unscript_app/news/ui_view/news_card.dart';
import 'package:unscript_app/utils/unscript_theme.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final TextEditingController _controller = TextEditingController();
    NewsService service = NewsService();

    return Scaffold(
      backgroundColor: UnScriptTheme.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 20,left: 20,right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Discover",
                style: UnScriptTheme.screenText(
                    size: screenWidth / 6.5, weight: FontWeight.bold,),
              ),
              Text(
                "Get trending news about Trading!",
                style: UnScriptTheme.appText(
                    size: screenWidth / 21,
                    weight: FontWeight.bold,
                    color: UnScriptTheme.bgTextColor2.withOpacity(0.6)),
              ),
              SizedBox(
                height: screenWidth / 17,
              ),
              CupertinoSearchTextField(
                controller: _controller,
                padding: const EdgeInsets.all(10.0),
                placeholder: 'search',
                onChanged: (value) {},
                placeholderStyle: UnScriptTheme.appText(
                    size: screenWidth / 23,
                    weight: FontWeight.w500,
                    color: UnScriptTheme.bgTextColor2),
                onSubmitted: (value) {},
                autocorrect: true,
                backgroundColor: Colors.white,
              ),
              const SizedBox(
                height: 20,
              ),
              FutureBuilder(
                  future: service.getLiveNews(context: context),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Expanded(
                        child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return NewsCard(model: snapshot.data![index]);
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                height: 20,
                              );
                            },
                            itemCount: snapshot.data!.length),
                      );
                    } else {
                      return Container();
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
