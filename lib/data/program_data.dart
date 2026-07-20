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

List<Program> globalPrograms = [];
