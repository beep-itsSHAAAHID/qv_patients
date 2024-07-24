import '../models/item.dart';

List<Item> items = [
  Item(
      title: 'Appoint your ',
      subtitle: 'assessment now.',
      lottie: lotties[0],
      description: desc),
  Item(
      title: 'Find the ',
      lottie: lotties[1],
      description: desc,
      subtitle: 'best doctors.'),
  Item(
      title: 'Trace your ',
      subtitle: 'assessment request.',
      lottie: lotties[2],
      description: desc),
];

const String desc =
    "Thee followed but to lost heart thy raven my lining. Ah in you chamber once shall distinctly, smiling came this.";

List<String> lotties = [
  'assets/lotties/assisment.json',
  'assets/lotties/doctor_circle.json',
  'assets/lotties/doctor_explaining.json',
];
