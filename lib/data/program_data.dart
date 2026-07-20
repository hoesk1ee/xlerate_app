import 'dart:io';

class Program {
  final String title;
  final String description;
  final String host;
  final String? speaker;
  final String startDate;
  final String? endDate;
  final String time;
  final String locationType;
  final String location;
  final String tag;
  final List<String> skills;
  final String eligibility;
  final bool isFree;
  final double fee;
  final bool offersCertificate;
  final bool offersBadge;
  final String imageUrl;
  final File? imageFile;

  Program({
    required this.title,
    required this.description,
    required this.host,
    this.speaker,
    required this.startDate,
    this.endDate,
    required this.time,
    required this.locationType,
    required this.location,
    required this.tag,
    required this.skills,
    required this.eligibility,
    required this.isFree,
    required this.fee,
    required this.offersCertificate,
    required this.offersBadge,
    required this.imageUrl,
    this.imageFile,
  });
}

List<Program> globalPrograms = [
  Program(
    title: 'UI/UX Masterclass',
    description:
        'Learn Figma basics and foundational UI/UX concepts from industry experts.',
    host: 'Excelerate',
    speaker: 'Alex Uzbek, B.Cs.',
    startDate: 'Oct 12, 2026',
    time: '10:00 AM',
    locationType: 'Virtual',
    location: 'Zoom Link provided upon registration',
    tag: 'Tech, Design',
    skills: ['Wireframing', 'Prototyping', 'User Research'],
    eligibility: 'All Levels',
    isFree: true,
    fee: 0.0,
    offersCertificate: true,
    offersBadge: true,
    imageUrl: 'https://picsum.photos/seed/uiux/200',
  ),
  Program(
    title: 'Data Analytics',
    description: 'An introduction to Python and SQL for absolute beginners.',
    host: 'DataCamp',
    speaker: 'Bishvajit Kumar, Data Scientist',
    startDate: 'Oct 15, 2026',
    endDate: 'Oct 17, 2026',
    time: '02:00 PM',
    locationType: 'In-Person',
    location: 'Room 304, Tech Hub',
    tag: 'Tech, Data, SQL',
    skills: ['Python', 'SQL', 'Data Visualisation'],
    eligibility: 'Beginners',
    isFree: false,
    fee: 25.0,
    offersCertificate: true,
    offersBadge: false,
    imageUrl: 'https://picsum.photos/seed/data/200',
  ),
  Program(
    title: 'Leadership Workshop',
    description:
        'Lead with empathy and vision in modern corporate environments.',
    host: 'Excelerate',
    speaker: 'Ferry Gunawan, CEO PT Astra',
    startDate: 'Oct 20, 2026',
    time: '09:00 AM',
    locationType: 'Hybrid',
    location: 'Main Hall & Webex',
    tag: 'Economy, Business',
    skills: ['Leadership', 'Communication'],
    eligibility: 'Managers & Team Leads',
    isFree: true,
    fee: 0.0,
    offersCertificate: false,
    offersBadge: true,
    imageUrl: 'https://picsum.photos/seed/lead/200',
  ),
  Program(
    title: 'Digital Marketing Strategies',
    description:
        'Learn SEO and social media marketing to scale your small business.',
    host: 'Marketing Pro',
    speaker: 'Emmanuel Nyarkotey, Marketing Expert',
    startDate: 'Oct 22, 2026',
    time: '01:00 PM',
    locationType: 'Virtual',
    location: 'Google Meet',
    tag: 'Economy, Marketing',
    skills: ['SEO', 'Content Strategy'],
    eligibility: 'Entrepreneurs',
    isFree: false,
    fee: 15.0,
    offersCertificate: true,
    offersBadge: true,
    imageUrl: 'https://picsum.photos/seed/marketing/200',
  ),
  Program(
    title: 'AI & Machine Learning',
    description:
        'The basics of AI, neural networks, and machine learning ethics.',
    host: 'Tech Forward',
    speaker: 'Harini Duggirala, AI Expert',
    startDate: 'Oct 25, 2026',
    time: '11:00 AM',
    locationType: 'In-Person',
    location: 'Innovation Center, Block B',
    tag: 'Tech, AI',
    skills: ['Machine Learning', 'AI Ethics'],
    eligibility: 'Intermediate Coders',
    isFree: true,
    fee: 0.0,
    offersCertificate: true,
    offersBadge: true,
    imageUrl: 'https://picsum.photos/seed/ai/200',
  ),
  Program(
    title: 'Sustainable Economy Panel',
    description:
        'A discussion on how eco-friendly practices drive economic growth.',
    host: 'EcoWorld',
    speaker: 'Augustine Chidera, Economist',
    startDate: 'Nov 02, 2026',
    time: '04:00 PM',
    locationType: 'Virtual',
    location: 'Zoom',
    tag: 'Nature, Economy',
    skills: ['Sustainability', 'Economics'],
    eligibility: 'Open to Everyone',
    isFree: true,
    fee: 0.0,
    offersCertificate: true,
    offersBadge: false,
    imageUrl: 'https://picsum.photos/seed/eco/200',
  ),
  Program(
    title: 'Flutter for Beginners',
    description:
        'Build your very first cross-platform mobile app using Flutter and Dart.',
    host: 'Excelerate',
    speaker: 'Murli Kumar, Junior Developer',
    startDate: 'Nov 05, 2026',
    endDate: 'Nov 07, 2026',
    time: '10:00 AM',
    locationType: 'Hybrid',
    location: 'Dev Studio & Zoom',
    tag: 'Tech, Coding',
    skills: ['Flutter', 'Dart', 'App Dev'],
    eligibility: 'Beginners',
    isFree: false,
    fee: 10.0,
    offersCertificate: true,
    offersBadge: true,
    imageUrl: 'https://picsum.photos/seed/flutter/200',
  ),
  Program(
    title: 'Advanced Mobile Architecture',
    description:
        'A deep dive into state management, scalable app design, and clean architecture patterns.',
    host: 'Tech University',
    speaker: 'Joan Gils, Senior Develper',
    startDate: 'Nov 05, 2026',
    endDate: 'Nov 07, 2026',
    time: '10:00 AM',
    locationType: 'Hybrid',
    location: 'Dev Studio & Zoom',
    tag: 'Tech, Coding',
    skills: ['Flutter', 'Dart', 'App Dev'],
    eligibility: 'Beginners',
    isFree: false,
    fee: 10.0,
    offersCertificate: true,
    offersBadge: true,
    imageUrl: 'https://picsum.photos/seed/flutter/200',
  ),
  Program(
    title: 'Green Tech Entrepreneurship',
    description:
        'Learn how to build, fund, and scale sustainable and profitable eco-friendly startups.',
    host: 'EcoInnovate Labs',
    speaker: 'Michael Ankomah, MBA',
    startDate: 'Nov 05, 2026',
    endDate: 'Nov 07, 2026',
    time: '10:00 AM',
    locationType: 'Hybrid',
    location: 'Dev Studio & Zoom',
    tag: 'Tech, Coding',
    skills: ['Flutter', 'Dart', 'App Dev'],
    eligibility: 'Beginners',
    isFree: false,
    fee: 10.0,
    offersCertificate: false,
    offersBadge: true,
    imageUrl: 'https://picsum.photos/seed/flutter/200',
  ),
];
