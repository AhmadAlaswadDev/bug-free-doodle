

String host_url='192.168.43.103';

class Entity {
  String id;
  String photo;

  Entity({required this.id, required this.photo,});
}

final List<Entity> dummy_entities_list = [
  Entity(id: "1", photo: "assets/data/entities/1.png"),
  Entity(id: "2", photo: "assets/data/entities/2.png"),
  Entity(id: "3", photo: "assets/data/entities/3.png"),
  Entity(id: "4", photo: "assets/data/entities/4.png"),

  Entity(id: "5", photo: "assets/data/entities/1.png"),
  Entity(id: "6", photo: "assets/data/entities/2.png"),
  Entity(id: "7", photo: "assets/data/entities/3.png"),
  Entity(id: "8", photo: "assets/data/entities/4.png"),

  // Entity(id: "9", photo: "assets/data/entities/1.png"),
  // Entity(id: "10", photo: "assets/data/entities/2.png"),
  // Entity(id: "11", photo: "assets/data/entities/3.png"),
  // Entity(id: "12", photo: "assets/data/entities/4.png"),

  // Entity(id: "13", photo: "assets/data/entities/1.png"),
  // Entity(id: "14", photo: "assets/data/entities/2.png"),
  // Entity(id: "15", photo: "assets/data/entities/3.png"),
  // Entity(id: "16", photo: "assets/data/entities/4.png"),

  // Entity(id: "17", photo: "assets/data/entities/1.png"),
  // Entity(id: "18", photo: "assets/data/entities/2.png"),
  // Entity(id: "19", photo: "assets/data/entities/3.png"),
  // Entity(id: "20", photo: "assets/data/entities/4.png"),

  // Entity(id: "21", photo: "assets/data/entities/1.png"),
  // Entity(id: "22", photo: "assets/data/entities/2.png"),
  // Entity(id: "23", photo: "assets/data/entities/3.png"),
  // Entity(id: "24", photo: "assets/data/entities/4.png"),
  // Entity(id: "5", photo: "http://${host_url}/entities/4.png"),
  // Entity(id: "6", photo: "http://${host_url}/entities/5.png"),
  // Entity(id: "7", photo: "http://${host_url}/entities/6.png"),
];
