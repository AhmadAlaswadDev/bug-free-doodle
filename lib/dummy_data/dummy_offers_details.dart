class AmmanCardItem {
  String amanauto_ms;
  String vin;
  String ex_date;
  String color;

  AmmanCardItem({
    required this.amanauto_ms,
    required this.vin,
    required this.ex_date,
    required this.color,
  });
}

class Details {
  int details_id;
  String qr_code;
  AmmanCardItem amman_card =
      AmmanCardItem(amanauto_ms: '', vin: '', ex_date: '', color: '');
  String details_body;

  Details(
      {required this.details_id,
      required this.qr_code,
      required this.amman_card,
      required this.details_body});
}

final String details_body =
    "<style>  li {  list-style: none;}  li::before { content: '\u003E' };  </style>        <p><strong>Highlights</strong></p><ul><li><span>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</span><span></span></li><li><span>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</span></li><li><span>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,</span></li></ul><p><strong>Conditions</strong></p><ul><li><span>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</span></li><li><span>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,</span></li></ul><p><strong>Company</strong></p><p>&nbsp; &nbsp; Zoom Car - Jaddeh - King Faisal Road</p>";

final List<Details> dummy_offer_details = [
  Details(
      details_id: 1,
      qr_code: '1153113151',
      amman_card: AmmanCardItem(
          amanauto_ms: '20250574',
          vin: 'WBAYGB2FF18',
          ex_date: '20 / 12 / 20234',
          color: '#1fadc6'),
      details_body: details_body),
  Details(
      details_id: 2,
      qr_code: '1153123151',
      amman_card: AmmanCardItem(
          amanauto_ms: '20250574',
          vin: 'FER3F21GR2C',
          ex_date: '20 / 12 / 2011',
          color: '#8430f1'),
      details_body: details_body),
  Details(
      details_id: 3,
      qr_code: '1153113151',
      amman_card: AmmanCardItem(
          amanauto_ms: '20250574',
          vin: 'WBAYGB2FF18',
          ex_date: '20 / 12 / 20234',
          color: '#f15f30'),
      details_body: details_body),
  Details(
      details_id: 4,
      qr_code: '1153123151',
      amman_card: AmmanCardItem(
          amanauto_ms: '20250574',
          vin: 'FER3F21GR2C',
          ex_date: '20 / 12 / 2011',
          color: '#8430f1'),
      details_body: details_body),
  Details(
      details_id: 5,
      qr_code: '1153113151',
      amman_card: AmmanCardItem(
          amanauto_ms: '20250574',
          vin: 'WBAYGB2FF18',
          ex_date: '20 / 12 / 20234',
          color: '#1fadc6'),
      details_body: details_body),
  Details(
      details_id: 6,
      qr_code: '1153123151',
      amman_card: AmmanCardItem(
          amanauto_ms: '20250574',
          vin: 'FER3F21GR2C',
          ex_date: '20 / 12 / 2011',
          color: '#8430f1'),
      details_body: details_body),
  Details(
      details_id: 7,
      qr_code: '1153123151',
      amman_card: AmmanCardItem(
          amanauto_ms: '20250574',
          vin: 'FER3F21GR2C',
          ex_date: '20 / 12 / 2011',
          color: '#1fadc6'),
      details_body: details_body)
];
