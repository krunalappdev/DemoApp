class User {
  int count = 0;
  String next = '';
  String? previous;
  List<Results> results = <Results>[];

  User({required this.count, required this.next, this.previous, required this.results});

  User.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      json['results'].forEach((v) {
        results.add(new Results.fromJson(v));
      });
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['next'] = this.next;
    data['previous'] = this.previous;
    if (this.results != null) {
      data['results'] = this.results.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Results {
  String name ='';
  String rotationPeriod ='';
  String orbitalPeriod ='';
  String diameter ='';
  String climate ='';
  String gravity ='';
  String terrain ='';
  String surfaceWater='';
  String population='';
  List<String> residents=[];
  List<String> films=[];
  String created='';
  String edited='';
  String url='';

  Results(
      {required this.name,
        required this.rotationPeriod,
        required this.orbitalPeriod,
        required this.diameter,
        required this.climate,
        required this.gravity,
        required this.terrain,
        required this.surfaceWater,
        required this.population,
        required this.residents,
        required this.films,
        required this.created,
        required this.edited,
        required this.url});

  Results.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    rotationPeriod = json['rotation_period'];
    orbitalPeriod = json['orbital_period'];
    diameter = json['diameter'];
    climate = json['climate'];
    gravity = json['gravity'];
    terrain = json['terrain'];
    surfaceWater = json['surface_water'];
    population = json['population'];
    residents = json['residents'].cast<String>();
    films = json['films'].cast<String>();
    created = json['created'];
    edited = json['edited'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['rotation_period'] = this.rotationPeriod;
    data['orbital_period'] = this.orbitalPeriod;
    data['diameter'] = this.diameter;
    data['climate'] = this.climate;
    data['gravity'] = this.gravity;
    data['terrain'] = this.terrain;
    data['surface_water'] = this.surfaceWater;
    data['population'] = this.population;
    data['residents'] = this.residents;
    data['films'] = this.films;
    data['created'] = this.created;
    data['edited'] = this.edited;
    data['url'] = this.url;
    return data;
  }
}