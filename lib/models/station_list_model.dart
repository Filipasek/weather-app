// class Address{
//   final String country;
//   final String city;
//   final String street;
//   final String number;
//   final String displayAddress1;
//   final String displayAddress2;

//   Address({
//     this.city,
//     this.country,
//     this.displayAddress1,
//     this.street,
//     this.displayAddress2,
//     this.number,
//   });
// }
class Station{
  final int stationId;
  final String address1;
  final String address2;

  Station({
    this.stationId,
    this.address1,
    this.address2,
  });

  factory Station.fromJson(Map<String, dynamic> json) {
    return Station(
      stationId: json['id'],
      address1: json['address']['displayAddress1'],
      address2: json['address']['displayAddress2'],
    );
  }
}
class StationList{
  final List<Station> stations;
  // var lgt;
  StationList({
    this.stations,
  });
  
  factory StationList.fromJson(List<dynamic> parsedJson){
    List<Station> stations = new List<Station>();
    stations = parsedJson.map((i) => Station.fromJson(i)).toList();
    return new StationList(
      stations: stations,
      // lgt: threads.length
    );
  }
}