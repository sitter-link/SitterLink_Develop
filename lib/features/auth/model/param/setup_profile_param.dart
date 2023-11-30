import 'dart:convert';

import 'package:jiffy/jiffy.dart';
import 'package:nanny_app/core/forms/common_form_attributes.dart';

class SetupProfileParam {
  final List<int> commitmentType;
  final String gender;
  final DateTime dateOfBirth;
  final String country;
  final String city;
  final String address;
  final String postalCode;
  final String amountPerHours;
  final String noOfExperience;
  final List<int> experiences;
  final List<MultiCheckboxFile> certifications;
  final List<int> skills;
  final Map<String, Map<String, bool?>> availability;
  final String bio;
  final String languages;

  SetupProfileParam({
    required this.commitmentType,
    required this.gender,
    required this.dateOfBirth,
    required this.city,
    required this.country,
    required this.address,
    required this.postalCode,
    required this.amountPerHours,
    required this.noOfExperience,
    required this.experiences,
    required this.certifications,
    required this.skills,
    required this.availability,
    required this.bio,
    required this.languages,
  });

  factory SetupProfileParam.fromMap(
    Map<String, dynamic> personal,
    Map<String, dynamic> experienceData,
    Map<String, dynamic> availability,
  ) {
    return SetupProfileParam(
      commitmentType: List.from(personal["commitment_type"])
          .map((e) => int.parse(e.toString()))
          .toList(),
      gender: personal["gender"],
      dateOfBirth: personal["date_of_birth"],
      city: personal["city"],
      country: personal["country"],
      address: personal["address"],
      postalCode: personal["postal_code"],
      amountPerHours: personal["amount_per_hour"],
      noOfExperience: experienceData["no_of_experience"],
      languages: personal["language"],
      experiences: List.from(experienceData["experinence"] ?? [])
          .map((e) => int.parse(e.toString()))
          .toList(),
      certifications:
          experienceData["certification"] as List<MultiCheckboxFile>,
      skills: List.from(experienceData["skill"] ?? [])
          .map((e) => int.parse(e.toString()))
          .toList(),
      availability: {
        for (var singleAvailable in availability.entries)
          if (singleAvailable.value is Map) ...{
            singleAvailable.key: singleAvailable.value as Map<String, bool?>
          },
      },
      bio: availability["bio"],
    );
  }

  Future<Map<String, dynamic>> toApiMap() async {
    return {
      "commitment_type": commitmentType,
      "gender": gender,
      "date_of_birth":
          Jiffy.parseFromDateTime(dateOfBirth).format(pattern: "yyyy-MM-dd"),
      "country": country,
      "city": city,
      "address": address,
      "experience_years": noOfExperience,
      "experience": experiences,
      "amount_per_hour": amountPerHours,
      "postal_code": postalCode,
      "skills": skills,
      for (var singleCertificate in certifications) ...{
        singleCertificate.boolenValueKey: true,
        singleCertificate.key:
            base64Encode(await singleCertificate.file!.readAsBytes()),
      },
      "bio": bio,
      "language": languages,
      "availability": availability.entries
          .map(
            (en) => {
              "day": int.parse(en.key),
              "timeslots": en.value.entries
                  .where((e) => e.value == true)
                  .map(
                    (e) => {
                      "slug": e.key,
                    },
                  )
                  .toList(),
            },
          )
          .where((e) => List.from(e["timeslots"] as List).isNotEmpty)
          .toList()
    };
  }
}
