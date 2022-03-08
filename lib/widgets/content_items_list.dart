import 'package:flutter/material.dart';
import 'show_widget.dart';
import '../models/content_item.dart';

class ContentItemsList extends StatefulWidget {
  const ContentItemsList({Key? key, required this.contentItems})
      : super(key: key);

  final List<ContentItem> contentItems;

  @override
  State<ContentItemsList> createState() => _ContentItemsListState();
}

class _ContentItemsListState extends State<ContentItemsList> {
  var bannerUrl = "";
  var showLabel = "";
  var showDescription = "";

  void _updateBanner(String contentId) {
    ContentItem ci = widget.contentItems
        .where((element) => element.contentId == contentId)
        .first;

    setState(() {
      bannerUrl = ci.covers![0].url!;
      showLabel = ci.label!;
      showDescription = ci.description!;

      // reset all other show widgets
      for (int i = 0; i < widget.contentItems.length; i++) {
        if (widget.contentItems[i].selected) {
          widget.contentItems[i].selected = false;
        }
        if (widget.contentItems[i].contentId == contentId) {
          widget.contentItems[i].selected = true;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (bannerUrl.isEmpty) {
      ContentItem firstContentItem = widget.contentItems[0];
      firstContentItem.selected = true;
      bannerUrl = firstContentItem.covers![0].url!;
      showLabel = firstContentItem.label!;
      showDescription = firstContentItem.description!;
    }

    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: widget.contentItems.isEmpty
          ? Column(
              children: <Widget>[
                Text('No content!',
                    style: Theme.of(context).textTheme.titleLarge),
              ],
            )
          : Stack(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Flexible(
                      child: Image.network(
                        bannerUrl,
                        fit: BoxFit.fill,
                        //color: const Color.fromRGBO(255, 255, 255, 0.9),
                        //colorBlendMode: BlendMode.modulate
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    const Spacer(
                      flex: 38,
                    ),
                    Flexible(
                      flex: 22,
                      fit: FlexFit.tight,
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.55,
                            child: Column(
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    showLabel,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      //backgroundColor: Colors.black.withOpacity(0.2),
                                      color: Colors.white,
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 7,
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    showDescription,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      //backgroundColor: Colors.black.withOpacity(0.2),
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 50,
                      fit: FlexFit.tight,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(10.0),
                        alignment: Alignment.bottomCenter,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (ctx, index) {
                            return ShowWidget(
                                updateBanner: _updateBanner,
                                contentItem: widget.contentItems[index]);
                          },
                          itemCount: widget.contentItems.length,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
