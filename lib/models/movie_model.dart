import 'dart:developer';

class Episode {
  int id;
  String url;
  String name;
  int season;
  int number;
  String type;
  String airdate;
  String airtime;
  String airstamp;
  int runtime;
  Rating rating;
  String summary;
  Links links;
  Embedded embedded;

  Episode({
    required this.id,
    required this.url,
    required this.name,
    required this.season,
    required this.number,
    required this.type,
    required this.airdate,
    required this.airtime,
    required this.airstamp,
    required this.runtime,
    required this.rating,
    required this.summary,
    required this.links,
    required this.embedded,
  });

  factory Episode.fromJson(Map<String, dynamic> json) {
    return Episode(
      id: json['id'] ?? 0,
      url: json['url'] ?? '',
      name: json['name'] ?? '',
      season: json['season'] ?? 0,
      number: json['number'] ?? 0,
      type: json['type'] ?? '',
      airdate: json['airdate'] ?? '',
      airtime: json['airtime'] ?? '',
      airstamp: json['airstamp'] ?? '',
      runtime: json['runtime'] ?? 0,
      rating: Rating.fromJson(json['rating'] ?? {}),
      summary: json['summary'] ?? '',
      links: Links.fromJson(json['_links'] ?? {}),
      embedded: Embedded.fromJson(json['_embedded'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'url': url,
        'name': name,
        'season': season,
        'number': number,
        'type': type,
        'airdate': airdate,
        'airtime': airtime,
        'airstamp': airstamp,
        'runtime': runtime,
        'rating': rating.toJson(),
        'summary': summary,
        '_links': links.toJson(),
        '_embedded': embedded.toJson(),
      };
}

class Rating {
  double? average;

  Rating({
    this.average,
  });

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      average: json['average']?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
        'average': average,
      };
}

class Links {
  Link self;
  Link show;

  Links({
    required this.self,
    required this.show,
  });

  factory Links.fromJson(Map<String, dynamic> json) {
    return Links(
      self: Link.fromJson(json['self'] ?? {}),
      show: Link.fromJson(json['show'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        'self': self.toJson(),
        'show': show.toJson(),
      };
}

class Link {
  String href;

  Link({
    required this.href,
  });

  factory Link.fromJson(Map<String, dynamic> json) {
    return Link(
      href: json['href'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'href': href,
      };
}

class Embedded {
  Show show;

  Embedded({
    required this.show,
  });

  factory Embedded.fromJson(Map<String, dynamic> json) {
    return Embedded(
      show: Show.fromJson(json['show'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        'show': show.toJson(),
      };
}

class Show {
  int id;
  String url;
  String name;
  String type;
  String language;
  List<String> genres;
  String status;
  int runtime;
  int averageRuntime;
  String premiered;
  String officialSite;
  Schedule schedule;
  Rating showRating;
  int weight;
  WebChannel webChannel;
  Externals externals;
  Image image;
  String showSummary;
  int updated;
  Links showLinks;

  Show({
    required this.id,
    required this.url,
    required this.name,
    required this.type,
    required this.language,
    required this.genres,
    required this.status,
    required this.runtime,
    required this.averageRuntime,
    required this.premiered,
    required this.officialSite,
    required this.schedule,
    required this.showRating,
    required this.weight,
    required this.webChannel,
    required this.externals,
    required this.image,
    required this.showSummary,
    required this.updated,
    required this.showLinks,
  });

  factory Show.fromJson(Map<String, dynamic> json) {
    return Show(
      id: json['id'] ?? 0,
      url: json['url'] ?? '',
      name: json['name'] ?? '',
      type: json['type'] ?? '',
      language: json['language'] ?? '',
      genres: List<String>.from(json['genres'] ?? []),
      status: json['status'] ?? '',
      runtime: json['runtime'] ?? 0,
      averageRuntime: json['averageRuntime'] ?? 0,
      premiered: json['premiered'] ?? '',
      officialSite: json['officialSite'] ?? '',
      schedule: Schedule.fromJson(json['schedule'] ?? {}),
      showRating: Rating.fromJson(json['rating'] ?? {}),
      weight: json['weight'] ?? 0,
      webChannel: WebChannel.fromJson(json['webChannel'] ?? {}),
      externals: Externals.fromJson(json['externals'] ?? {}),
      image: Image.fromJson(json['image'] ?? {}),
      showSummary: json['summary'] ?? '',
      updated: json['updated'] ?? 0,
      showLinks: Links.fromJson(json['_links'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'url': url,
        'name': name,
        'type': type,
        'language': language,
        'genres': genres,
        'status': status,
        'runtime': runtime,
        'averageRuntime': averageRuntime,
        'premiered': premiered,
        'officialSite': officialSite,
        'schedule': schedule.toJson(),
        'rating': showRating.toJson(),
        'weight': weight,
        'webChannel': webChannel.toJson(),
        'externals': externals.toJson(),
        'image': image.toJson(),
        'summary': showSummary,
        'updated': updated,
        '_links': showLinks.toJson(),
      };
}

class Schedule {
  String time;
  List<String> days;

  Schedule({
    required this.time,
    required this.days,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      time: json['time'] ?? '',
      days: List<String>.from(json['days'] ?? []),
    );
  }

  Map<String, dynamic> toJson() => {
        'time': time,
        'days': days,
      };
}

class WebChannel {
  int id;
  String name;
  Country country;
  String officialSite;

  WebChannel({
    required this.id,
    required this.name,
    required this.country,
    required this.officialSite,
  });

  factory WebChannel.fromJson(Map<String, dynamic> json) {
    return WebChannel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      country: Country.fromJson(json['country'] ?? {}),
      officialSite: json['officialSite'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'country': country.toJson(),
        'officialSite': officialSite,
      };
}

class Country {
  String name;
  String code;
  String timezone;

  Country({
    required this.name,
    required this.code,
    required this.timezone,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      name: json['name'] ?? '',
      code: json['code'] ?? '',
      timezone: json['timezone'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'code': code,
        'timezone': timezone,
      };
}

class Externals {
  dynamic tvrage;
  dynamic thetvdb;
  dynamic imdb;

  Externals({
    required this.tvrage,
    required this.thetvdb,
    required this.imdb,
  });

  factory Externals.fromJson(Map<String, dynamic> json) {
    return Externals(
      tvrage: json['tvrage'] ?? '',
      thetvdb: json['thetvdb'] ?? '',
      imdb: json['imdb'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'tvrage': tvrage,
        'thetvdb': thetvdb,
        'imdb': imdb,
      };
}

class Image {
  String medium;
  String original;

  Image({
    required this.medium,
    required this.original,
  });

  factory Image.fromJson(Map<String, dynamic> json) {
    return Image(
      medium: json['medium'] ?? '',
      original: json['original'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'medium': medium,
        'original': original,
      };
}

class ShowResponse {
  final List<Show> showList;

  ShowResponse({
    required this.showList,
  });

  factory ShowResponse.fromJson(Map<String, dynamic> json) {
    var showListJson = json['list'];
    log('response ${showListJson}');

    if (showListJson == null) {
      return ShowResponse(showList: []);
    }
    List<Show> showList = parseShows(showListJson).cast<Show>();
    log('response ${showList}');

    return ShowResponse(showList: showList);
  }

  static List<Show> parseShows(List<dynamic> showListJson) {
    List<Show> showList =
        showListJson.map((show) => Show.fromJson(show)).toList();
    return showList;
  }

  Map<String, dynamic> toJson() => {
        'list': showList.map((show) => show.toJson()).toList(),
      };
}
