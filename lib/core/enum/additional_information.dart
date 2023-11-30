// ignore_for_file: constant_identifier_names

enum AdditionalInformation {
  NonSmoker(label: "Non-Smoker", value: "non_smoker"),
  Vegan(label: "100% Vegan", value: "100%_vegan"),
  HaveValidDriverLicence(label: "Have a valid driver’s licence", value: "have_a_valid_driver’s_licence"),
  WillingToRelocate(label: "Willing to relocate", value: "willing_to_relocate"),
  HaveOwnChild(label: "Have own child/children", value: "have_own_child/children");

  final String label;
  final String value;

  const AdditionalInformation({required this.label, required this.value});
}
