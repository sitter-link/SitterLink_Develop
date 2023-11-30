// ignore_for_file: constant_identifier_names

enum WorkRequirement {
  WorkPermit(
    label: "Work Permit / PR Holder",
    value: "work_permit_pr",
    boolValueLabel: "has_work_permit",
  ),
  FirstAidTraining(
    label: "First Aid Training",
    value: "first_aid_training_certificate",
    boolValueLabel: "has_first_aid_training",
  ),
  CPRTraining(
    label: "CPR Training",
    value: "cpr_training_certificate",
    boolValueLabel: "has_cpr_training",
  ),
  CertifiedNannyTraining(
    label: "Certified Nanny Training",
    value: "nanny_training_certificate",
    boolValueLabel: "has_nanny_training",
  ),
  CertifiedElderlyCareTraining(
    label: "Certified Elderly Care Training",
    value: "elderly_care_training_certificate",
    boolValueLabel: "has_elderly_care_training",
  );

  final String label;
  final String value;
  final String boolValueLabel;

  const WorkRequirement({
    required this.label,
    required this.value,
    required this.boolValueLabel,
  });
}
