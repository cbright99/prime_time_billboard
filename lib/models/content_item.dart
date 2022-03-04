class ContentItem {
  Badges? badges;
  String? contentId;
  List<Covers>? covers;
  String? ctaData;
  String? ctaType;
  String? description;
  String? label;
  String? type;
  bool selected = false;

  ContentItem(
      {this.badges,
      this.contentId,
      this.covers,
      this.ctaData,
      this.ctaType,
      this.description,
      this.label,
      this.type});

  ContentItem.fromJson(Map<String, dynamic> json) {
    badges = json['badges'] != null ? Badges.fromJson(json['badges']) : null;
    contentId = json['contentId'];
    if (json['covers'] != null) {
      covers = <Covers>[];
      json['covers'].forEach((v) {
        covers!.add(Covers.fromJson(v));
      });
    }
    ctaData = json['ctaData'];
    ctaType = json['ctaType'];
    description = json['description'];
    label = json['label'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (badges != null) {
      data['badges'] = badges!.toJson();
    }
    data['contentId'] = contentId;
    if (covers != null) {
      data['covers'] = covers!.map((v) => v.toJson()).toList();
    }
    data['ctaData'] = ctaData;
    data['ctaType'] = ctaType;
    data['description'] = description;
    data['label'] = label;
    data['type'] = type;
    return data;
  }
}

class Badges {
  String? badgeBGColor;
  String? badgeText;

  Badges({this.badgeBGColor, this.badgeText});

  Badges.fromJson(Map<String, dynamic> json) {
    badgeBGColor = json['badgeBGColor'];
    badgeText = json['badgeText'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['badgeBGColor'] = badgeBGColor;
    data['badgeText'] = badgeText;
    return data;
  }
}

class Covers {
  String? aspectRatio;
  String? url;

  Covers({this.aspectRatio, this.url});

  Covers.fromJson(Map<String, dynamic> json) {
    aspectRatio = json['aspectRatio'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['aspectRatio'] = aspectRatio;
    data['url'] = url;
    return data;
  }
}
