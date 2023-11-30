import 'package:jiffy/jiffy.dart';

class BookANannyParam {
  final int nannyId;
  final List<int> experiences;
  final int commimentId;
  final List<int> skills;
  final List<Map<String, dynamic>> timeslots;
  final String additionalMessage;

  BookANannyParam({
    required this.nannyId,
    required this.experiences,
    required this.commimentId,
    required this.skills,
    required this.timeslots,
    required this.additionalMessage,
  });

  factory BookANannyParam.fromFormData(
    int nannyId,
    Map<String, dynamic> form1,
    Map<String, dynamic> form2,
    Map<String, dynamic> form3,
  ) {
    return BookANannyParam(
      nannyId: nannyId,
      experiences: [int.parse(form1["experiences"])],
      commimentId: int.parse(form1['commitment']),
      skills:
          List.from(form1["skills"] ?? []).map((e) => int.parse(e)).toList(),
      timeslots: form2.entries
          .where((entry) => entry.key.startsWith('date'))
          .map((entry) => {
                'date': Jiffy.parseFromDateTime(entry.value)
                    .format(pattern: "yyyy-MM-dd"),
                'time_slots': form2.entries
                    .where((entry) => entry.key.startsWith('shifts'))
                    .first
                    .value
                    .entries
                    .where((entry) => entry.value == true)
                    .map((entry) => {'slug': entry.key})
                    .toList(),
              })
          .toList(),
      additionalMessage: form3["additional_message"] ?? "",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "care_needs": experiences,
      "commitment": commimentId,
      "expectations": skills,
      "additional_message": additionalMessage,
      "availability": timeslots,
    };
  }
}
