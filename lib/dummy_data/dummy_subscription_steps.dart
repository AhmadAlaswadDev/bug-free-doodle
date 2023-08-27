

String host_url='192.168.43.103';

class SubsriptionStep {
  String id;
  String name;
  String photo;

  SubsriptionStep({required this.id, required this.name ,required this.photo,});
}

final List<SubsriptionStep> dummy_subsription_steps_list_en = [
  SubsriptionStep(id: "1", name:"Register", photo: "assets/data/steps/1.png"),
  SubsriptionStep(id: "2", name:"Subscription", photo: "assets/data/steps/2.png"),
  SubsriptionStep(id: "3", name:"Service Call", photo: "assets/data/steps/3.png"),

];


final List<SubsriptionStep> dummy_subsription_steps_list_ar = [
  SubsriptionStep(id: "1", name:"تسجيل", photo: "assets/data/steps/1.png"),
  SubsriptionStep(id: "2", name:"اشتراك", photo: "assets/data/steps/2.png"),
  SubsriptionStep(id: "3", name:"خدمة مكالمة", photo: "assets/data/steps/3.png"),

];
