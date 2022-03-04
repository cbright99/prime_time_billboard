import 'package:flutter/material.dart';
import '../models/content_item.dart';

// ignore: must_be_immutable
class ShowWidget extends StatefulWidget {
  final ContentItem contentItem;
  Function updateBanner;

  ShowWidget({
    Key? key,
    required this.updateBanner,
    required this.contentItem,
  }) : super(key: key);

  @override
  State<ShowWidget> createState() => _ShowWidgetState();
}

class _ShowWidgetState extends State<ShowWidget> {
  var selected = false;

  void _onClicked() {
    setState(() {
      selected = true;
    });

    widget.updateBanner(widget.contentItem.contentId);
  }

  @override
  Container build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      child: GestureDetector(
        onTap: () {
          _onClicked();
        },
        child: Column(
          children: <Widget>[
            Flexible(
              flex: 9,
              fit: FlexFit.tight,
              child: Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        width: (widget.contentItem.selected ? 3 : 0),
                        color: Colors.yellow,
                      ),
                    ),
                    child: Image.network(widget.contentItem.covers![0].url!),
                  ),
                  //Image.network(widget.contentItem.covers![0].url!),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: (widget.contentItem.selected
                              ? Colors.purple
                              : Colors.grey),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5.0)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            "${widget.contentItem.badges?.badgeText}",
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 1,
            ),
            Flexible(
              flex: 2,
              fit: FlexFit.tight,
              child: Container(
                alignment: Alignment.centerLeft,
                width: 300,
                child: Text(
                  widget.contentItem.label!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
