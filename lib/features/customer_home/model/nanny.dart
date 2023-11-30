// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:nanny_app/core/model/availability.dart';
import 'package:nanny_app/core/model/commitment_type.dart';
import 'package:nanny_app/core/model/experience.dart';
import 'package:nanny_app/core/model/skill.dart';
import 'package:nanny_app/features/rating/model/review.dart';
import 'package:nanny_app/features/rating/model/review_stat.dart';

class Nanny {
  final int id;
  final List<CommitmentType> commitmentType;
  final String gender;
  final DateTime? dateOfBirth;
  final num pricePerHrs;
  final String country;
  final String city;
  final String address;
  final String postalCode;
  final String name;
  final String avatar;
  final num rating;
  final num perHrsRate;
  final bool isFavorite;
  final num noOfExperience;
  final String phoneNUmber;
  final String bio;
  final String language;
  final bool hasWorkPermit;
  final bool hasFirstAidPermit;
  final bool hasCprTraining;
  final bool hasNannyCerificateTraining;
  final bool hasElderlyCareTraining;

  final String workPermitLink;
  final String firstAidPermitLink;
  final String cprTrainingLink;
  final String nannyCerificateTrainingLink;
  final String elderlyCareTrainingLink;
  final List<Skill> skills;
  final List<Experience> experiences;
  final List<Availability> availability;
  final List<Review> reviews;
  final ReviewStat reviewStat;
  final bool hasBeenBooked;

  Nanny({
    required this.id,
    required this.commitmentType,
    required this.gender,
    required this.dateOfBirth,
    required this.pricePerHrs,
    required this.country,
    required this.city,
    required this.address,
    required this.postalCode,
    required this.name,
    required this.avatar,
    required this.rating,
    required this.perHrsRate,
    required this.isFavorite,
    required this.noOfExperience,
    required this.phoneNUmber,
    required this.bio,
    required this.language,
    required this.hasCprTraining,
    required this.hasElderlyCareTraining,
    required this.hasFirstAidPermit,
    required this.hasNannyCerificateTraining,
    required this.hasWorkPermit,
    required this.experiences,
    required this.skills,
    required this.availability,
    required this.workPermitLink,
    required this.firstAidPermitLink,
    required this.cprTrainingLink,
    required this.nannyCerificateTrainingLink,
    required this.elderlyCareTrainingLink,
    required this.reviews,
    required this.reviewStat,
    required this.hasBeenBooked,
  });

  num? get age {
    if (dateOfBirth != null) {
      return DateTime.now().year - dateOfBirth!.year;
    } else {
      return null;
    }
  }

  factory Nanny.fromMap(Map<String, dynamic> map) {
    return Nanny(
      id: map['user_detail']?["id"],
      commitmentType: List.from(map['commitment_type'] ?? [])
          .map<CommitmentType>(
            (x) => CommitmentType.fromMap(x),
          )
          .toList(),
      gender: map['gender'] ?? "",
      dateOfBirth: DateTime.tryParse(map["date_of_birth"])?.toLocal(),
      pricePerHrs: map['amount_per_hour'] ?? 0,
      country: map['country'] ?? "",
      city: map['city'] ?? "",
      address: map['address'] ?? "",
      postalCode: map['postal_code'] ?? "",
      avatar: map["user_detail"]?["avatar"] ?? "",
      isFavorite: map["has_been_favorite"] ?? false,
      name: map["user_detail"]?["fullname"] ?? "",
      noOfExperience: map["experience_years"] ?? 0,
      perHrsRate: map["amount_per_hour"] ?? 0,
      rating: map["rating"] ?? 0,
      phoneNUmber: map["user_detail"]?["phone_number"] ?? "",
      bio: map["user_detail"]?["bio"] ?? "",
      language: map["personal_detail"]?["language"] ?? "",
      hasCprTraining: map["personal_detail"]?["has_cpr_training"] ?? false,
      hasElderlyCareTraining:
          map["personal_detail"]?["has_elderly_care_training"] ?? false,
      hasFirstAidPermit:
          map["personal_detail"]?["has_first_aid_training"] ?? false,
      hasNannyCerificateTraining:
          map["personal_detail"]?["has_nanny_training"] ?? false,
      hasWorkPermit: map["personal_detail"]?["has_work_permit"] ?? false,
      experiences: List.from(map['personal_detail']?["experience"] ?? [])
          .map((e) => Experience.fromMap(e))
          .toList(),
      skills: List.from(map['personal_detail']?["skills"] ?? [])
          .map((e) => Skill.fromMap(e))
          .toList(),
      availability: [],
      workPermitLink: map["work_permit_pr"] ?? "",
      firstAidPermitLink: map["first_aid_training_certificate"] ?? "",
      cprTrainingLink: map["cpr_training_certificate"] ?? "",
      nannyCerificateTrainingLink: map["nanny_training_certificate"] ?? "",
      elderlyCareTrainingLink: map["elderly_care_training_certificate"] ?? "",
      reviews:
          List.from(map["review"] ?? []).map((e) => Review.fromMap(e)).toList(),
      reviewStat: ReviewStat.fromMap(map["review_stats"] ?? {}),
      hasBeenBooked: map["has_been_booked"] ?? false,
    );
  }

  factory Nanny.fromFavoriteApiMap(Map<String, dynamic> map) {
    return Nanny(
      id: map['personal_detail']?['user_detail']?["id"],
      commitmentType:
          List.from(map['personal_detail']?['commitment_type'] ?? [])
              .map<CommitmentType>(
                (x) => CommitmentType.fromMap(x),
              )
              .toList(),
      gender: map['personal_detail']?['gender'] ?? "",
      dateOfBirth: DateTime.tryParse(map['personal_detail']?["date_of_birth"])
          ?.toLocal(),
      pricePerHrs: map['personal_detail']?['amount_per_hour'] ?? 0,
      country: map['personal_detail']?['country'] ?? "",
      city: map['personal_detail']?['city'] ?? "",
      address: map['personal_detail']?['address'] ?? "",
      postalCode: map['personal_detail']?['postal_code'] ?? "",
      avatar: map['personal_detail']?["user_detail"]?["avatar"] ?? "",
      isFavorite: true,
      name: map['personal_detail']?["user_detail"]?["fullname"] ?? "",
      noOfExperience: map['personal_detail']?["experience_years"] ?? 0,
      perHrsRate: map['personal_detail']?["amount_per_hour"] ?? 0,
      rating: map['personal_detail']?["rating"] ?? 0,
      phoneNUmber:
          map['personal_detail']?["user_detail"]?["phone_number"] ?? "",
      bio: map['personal_detail']?["user_detail"]?["bio"] ?? "",
      language: map['personal_detail']?["language"] ?? "",
      hasCprTraining: map['personal_detail']?["has_cpr_training"] ?? false,
      hasElderlyCareTraining:
          map["personal_detail"]?["has_elderly_care_training"] ?? false,
      hasFirstAidPermit:
          map["personal_detail"]?["has_first_aid_training"] ?? false,
      hasNannyCerificateTraining:
          map["personal_detail"]?["has_nanny_training"] ?? false,
      hasWorkPermit: map["personal_detail"]?["has_work_permit"] ?? false,
      experiences: List.from(map['personal_detail']?["experience"] ?? [])
          .map((e) => Experience.fromMap(e))
          .toList(),
      skills: List.from(map['personal_detail']?["skills"] ?? [])
          .map((e) => Skill.fromMap(e))
          .toList(),
      availability: [],
      cprTrainingLink:
          map['personal_detail']?["cpr_training_certificate"] ?? "",
      elderlyCareTrainingLink:
          map['personal_detail']?["elderly_care_training_certificate"] ?? "",
      firstAidPermitLink:
          map['personal_detail']?["first_aid_training_certificate"] ?? "",
      nannyCerificateTrainingLink:
          map['personal_detail']?["nanny_training_certificate"] ?? "",
      workPermitLink: map['personal_detail']?["work_permit_pr"] ?? "",
      reviews:
          List.from(map["review"] ?? []).map((e) => Review.fromMap(e)).toList(),
      reviewStat: ReviewStat.fromMap(map["review_stats"] ?? {}),
      hasBeenBooked: map["has_been_booked"] ?? false,
    );
  }

  factory Nanny.fromMapDetails(Map<String, dynamic> map) {
    return Nanny(
      id: map["user_detail"]['id'],
      commitmentType:
          List.from(map["personal_detail"]?['commitment_type'] ?? [])
              .map<CommitmentType>(
                (x) => CommitmentType.fromMap(x),
              )
              .toList(),
      gender: map['personal_detail']?['gender'] ?? "",
      dateOfBirth:
          DateTime.tryParse(map['personal_detail']?["date_of_birth"] ?? "")
              ?.toLocal(),
      pricePerHrs: map['personal_detail']?['amount_per_hour'] ?? 0,
      country: map["personal_detail"]?['country'] ?? "",
      city: map["personal_detail"]?['city'] ?? "",
      address: map['personal_detail']?['address'] ?? "",
      postalCode: map['personal_detail']?['postal_code'] ?? "",
      avatar: map["user_detail"]?["avatar"] ?? "",
      isFavorite: map["has_been_favorite"] ?? false,
      name: map["user_detail"]?["fullname"] ?? "",
      noOfExperience: map['personal_detail']?["experience_years"] ?? 0,
      perHrsRate: map['personal_detail']?["amount_per_hour"] ?? 0,
      rating: map['personal_detail']?["rating"] ?? 0,
      phoneNUmber: map["user_detail"]?["phone_number"] ?? "",
      bio: map["personal_detail"]?["bio"] ?? "",
      language: map["personal_detail"]?["language"] ?? "",
      hasCprTraining: map["personal_detail"]?["has_cpr_training"] ?? false,
      hasElderlyCareTraining:
          map["personal_detail"]?["has_elderly_care_training"] ?? false,
      hasFirstAidPermit:
          map["personal_detail"]?["has_first_aid_training"] ?? false,
      hasNannyCerificateTraining:
          map["personal_detail"]?["has_nanny_training"] ?? false,
      hasWorkPermit: map["personal_detail"]?["has_work_permit"] ?? false,
      experiences: List.from(map['personal_detail']?["experience"] ?? [])
          .map((e) => Experience.fromMap(e))
          .toList(),
      skills: List.from(map['personal_detail']?["skills"] ?? [])
          .map((e) => Skill.fromMap(e))
          .toList(),
      availability: List.from(map["personal_detail"]?['availability'] ?? [])
          .map((e) => Availability.fromApiMap(e))
          .toList(),
      cprTrainingLink:
          map['personal_detail']?["cpr_training_certificate"] ?? "",
      elderlyCareTrainingLink:
          map['personal_detail']?["elderly_care_training_certificate"] ?? "",
      firstAidPermitLink:
          map['personal_detail']?["first_aid_training_certificate"] ?? "",
      nannyCerificateTrainingLink:
          map['personal_detail']?["nanny_training_certificate"] ?? "",
      workPermitLink: map['personal_detail']?["work_permit_pr"] ?? "",
      reviews:
          List.from(map["review"] ?? []).map((e) => Review.fromMap(e)).toList(),
      reviewStat: ReviewStat.fromMap(map["review_stats"] ?? {}),
      hasBeenBooked: map["has_been_booked"] ?? false,
    );
  }

  Nanny copyWith({
    int? id,
    List<CommitmentType>? commitmentType,
    String? gender,
    DateTime? dateOfBirth,
    num? pricePerHrs,
    String? country,
    String? address,
    String? postalCode,
    String? name,
    String? avatar,
    num? rating,
    num? perHrsRate,
    bool? isFavorite,
    num? noOfExperience,
    String? phoneNUmber,
  }) {
    return Nanny(
      id: id ?? this.id,
      commitmentType: commitmentType ?? this.commitmentType,
      gender: gender ?? this.gender,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      pricePerHrs: pricePerHrs ?? this.pricePerHrs,
      country: country ?? this.country,
      address: address ?? this.address,
      postalCode: postalCode ?? this.postalCode,
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
      rating: rating ?? this.rating,
      perHrsRate: perHrsRate ?? this.perHrsRate,
      isFavorite: isFavorite ?? this.isFavorite,
      noOfExperience: noOfExperience ?? this.noOfExperience,
      phoneNUmber: phoneNUmber ?? this.phoneNUmber,
      bio: bio,
      language: language,
      hasCprTraining: hasCprTraining,
      hasElderlyCareTraining: hasElderlyCareTraining,
      hasFirstAidPermit: hasFirstAidPermit,
      hasNannyCerificateTraining: hasNannyCerificateTraining,
      hasWorkPermit: hasWorkPermit,
      experiences: experiences,
      city: city,
      availability: availability,
      skills: skills,
      cprTrainingLink: cprTrainingLink,
      elderlyCareTrainingLink: elderlyCareTrainingLink,
      firstAidPermitLink: firstAidPermitLink,
      nannyCerificateTrainingLink: nannyCerificateTrainingLink,
      workPermitLink: workPermitLink,
      reviews: reviews,
      reviewStat: reviewStat,
      hasBeenBooked: hasBeenBooked,
    );
  }
}
