

import 'package:ammanauto/helpers/shared_value_helper.dart';

String host_url='192.168.43.103';

class Service {
  String id;
  String photo;
  String name;

  Service({required this.id, required this.photo,required this.name});
}

final List<Service> dummy_services_list_en = [
  Service(id: "1", name:  'Battery Boost', photo: "assets/data/services/1.png"),
  Service(id: "2", name:  'Fuel Backup' , photo: "assets/data/services/2.png"),
  Service(id: "3", name:  'Replace Flat Tire' , photo: "assets/data/services/3.png"),
  
  Service(id: "4", name:  'Towing Service', photo: "assets/data/services/4.png"),
  Service(id: "5", name:  'Battery Boost', photo: "assets/data/services/5.png"),
  Service(id: "6", name:  'Lockout Service' , photo: "assets/data/services/6.png"),
  
  Service(id: "7", name: 'Limousine Service' , photo: "assets/data/services/7.png"),
  Service(id: "8",  name:  'Coverd Ksa' , photo: "assets/data/services/8.png"),
  Service(id: "9",  name: 'Crash Towing' , photo: "assets/data/services/9.png"),
  
];

final List<Service> dummy_services_list_ar = [
  Service(id: "1", name: 'شحن بطارية', photo: "assets/data/services/1.png"),
  Service(id: "2", name:  'بنزين احتياطي', photo: "assets/data/services/2.png"),
  Service(id: "3", name:  'استبدال اطار', photo: "assets/data/services/3.png"),
  
  Service(id: "4", name: 'خدمة سحب', photo: "assets/data/services/4.png"),
  Service(id: "5", name:  'شحن بطارية', photo: "assets/data/services/5.png"),
  Service(id: "6", name:  'خدمة القفل', photo: "assets/data/services/6.png"),
  
  Service(id: "7", name:  'خدمة ليموزين', photo: "assets/data/services/7.png"),
  Service(id: "8",  name:  'تغطية السعودية', photo: "assets/data/services/8.png"),
  Service(id: "9",  name:  'سحب حادث', photo: "assets/data/services/9.png"),
  
];
