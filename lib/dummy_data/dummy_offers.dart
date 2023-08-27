import 'package:ammanauto/helpers/shared_value_helper.dart';

String host_url = '192.168.43.103';

class Offer {
  int offer_id;
  String name;
  String cmp_name;
  String dicount_amount;
  String end_date;

  Offer({
    required this.offer_id,
    required this.name,
    required this.cmp_name,
    required this.dicount_amount,
    required this.end_date,
  });
}

final List<Offer> dummy_offers_list_en = [
  Offer(
    offer_id: 1,
    name:  'Car Wash'  ,
    cmp_name: "petormin company",
    dicount_amount: "50",
    end_date: '20/12/2013',
  ),
  Offer(
    offer_id: 2,
    name:  'Oil Change 5000 Miles',
    cmp_name: "petormin company",
    dicount_amount: "25",
    end_date: '20/12/2013',
  ),
  Offer(
    offer_id: 3,
    name:  'Car Wash'  ,
    cmp_name: "petormin company",
    dicount_amount: "50",
    end_date: '20/12/2013',
  ),
  Offer(
    offer_id: 4,
    name: 'Oil Change 5000 Miles' ,
    cmp_name: "petormin company",
    dicount_amount: "25",
    end_date: '20/12/2019',
  ),
  Offer(
    offer_id: 5,
    name:  'Car Wash' ,
    cmp_name: "petormin company",
    dicount_amount: "36",
    end_date: '20/12/2026',
  ),
  Offer(
    offer_id: 6,
    name: 'Oil Change 5000 Miles' ,
    cmp_name: "petormin company",
    dicount_amount: "80",
    end_date: '20/12/2013',
  ),
  Offer(
    offer_id: 7,
    name:  'Oil Change 5000 Miles',
    cmp_name: "petormin company",
    dicount_amount: "12",
    end_date: '20/12/2023',
  ),
];


final List<Offer> dummy_offers_list_ar = [
  Offer(
    offer_id: 1,
    name:  " غسيل سيارة",
    cmp_name: "petormin company",
    dicount_amount: "50",
    end_date: '20/12/2013',
  ),
  Offer(
    offer_id: 2,
    name: ' تبديل زيت 5000 ميل',
    cmp_name: "petormin company",
    dicount_amount: "25",
    end_date: '20/12/2013',
  ),
  Offer(
    offer_id: 3,
    name: " غسيل سيارة",
    cmp_name: "petormin company",
    dicount_amount: "50",
    end_date: '20/12/2013',
  ),
  Offer(
    offer_id: 4,
    name: ' تبديل زيت 5000 ميل',
    cmp_name: "petormin company",
    dicount_amount: "25",
    end_date: '20/12/2019',
  ),
  Offer(
    offer_id: 5,
    name:  " غسيل سيارة",
    cmp_name: "petormin company",
    dicount_amount: "36",
    end_date: '20/12/2026',
  ),
  Offer(
    offer_id: 6,
    name:  ' تبديل زيت 5000 ميل',
    cmp_name: "petormin company",
    dicount_amount: "80",
    end_date: '20/12/2013',
  ),
  Offer(
    offer_id: 7,
    name:  ' تبديل زيت 5000 ميل',
    cmp_name: "petormin company",
    dicount_amount: "12",
    end_date: '20/12/2023',
  ),
];
