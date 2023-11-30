import 'package:flutter/material.dart';
import 'package:nanny_app/core/constants/assets.dart';
import 'package:nanny_app/core/enum/work_requirement.dart';
import 'package:nanny_app/core/pages/pdf_viewer_screen.dart';
import 'package:nanny_app/core/services/navigation_service.dart';
import 'package:nanny_app/core/theme/app_text_theme.dart';
import 'package:nanny_app/core/theme/custom_theme.dart';
import 'package:nanny_app/core/utils/size_utils.dart';
import 'package:nanny_app/core/widgets/button/custom_icon_button.dart';
import 'package:nanny_app/core/widgets/others/bullet_point.dart';
import 'package:nanny_app/core/widgets/others/section_wrapper.dart';
import 'package:nanny_app/core/widgets/sliver_sized_box.dart';
import 'package:nanny_app/features/customer_home/model/nanny.dart';

class NannyPersonalInformationProfessionalTabBarView extends StatefulWidget {
  final Nanny nanny;
  const NannyPersonalInformationProfessionalTabBarView({
    super.key,
    required this.nanny,
  });

  @override
  State<NannyPersonalInformationProfessionalTabBarView> createState() =>
      _NannyPersonalInformationProfessionalTabBarViewState();
}

class _NannyPersonalInformationProfessionalTabBarViewState
    extends State<NannyPersonalInformationProfessionalTabBarView> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.symmetric(
              horizontal: CustomTheme.horizontalPadding, vertical: 16),
          sliver: SliverToBoxAdapter(
            child: Card(
              color: Colors.white,
              child: SectionWrapper(
                title: "Job Commitment",
                titleFontSize: 18,
                child: Column(
                  children: widget.nanny.commitmentType.map((option) {
                    return BulletPoint(text: option.name);
                  }).toList(),
                ),
              ),
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(
              horizontal: CustomTheme.horizontalPadding, vertical: 8),
          sliver: SliverToBoxAdapter(
            child: Card(
              color: Colors.white,
              child: SectionWrapper(
                title: "Experience With",
                titleFontSize: 18,
                child: Column(
                  children: widget.nanny.experiences.map((option) {
                    return BulletPoint(text: option.value);
                  }).toList(),
                ),
              ),
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(
              horizontal: CustomTheme.horizontalPadding, vertical: 8),
          sliver: SliverToBoxAdapter(
            child: Card(
              color: Colors.white,
              child: SectionWrapper(
                title: "Certifications",
                titleFontSize: 18,
                child: Column(children: [
                  ...WorkRequirement.values
                      .where((e) => switch (e) {
                            WorkRequirement.CPRTraining =>
                              widget.nanny.hasCprTraining,
                            WorkRequirement.CertifiedElderlyCareTraining =>
                              widget.nanny.hasElderlyCareTraining,
                            WorkRequirement.CertifiedNannyTraining =>
                              widget.nanny.hasNannyCerificateTraining,
                            WorkRequirement.FirstAidTraining =>
                              widget.nanny.hasFirstAidPermit,
                            WorkRequirement.WorkPermit =>
                              widget.nanny.hasWorkPermit,
                          })
                      .map((option) {
                    return Column(
                      children: [
                        BulletPoint(text: option.label),
                        const SizedBox(height: 4),
                        switch (option) {
                          WorkRequirement.CPRTraining =>
                            widget.nanny.cprTrainingLink.isNotEmpty
                                ? PdfUploadButton(
                                    text: widget.nanny.cprTrainingLink
                                        .split("/")
                                        .last,
                                    onPressed: () {
                                      NavigationService.push(
                                        target: PdfViewerScreen(
                                          link: widget.nanny.cprTrainingLink,
                                          label:
                                              WorkRequirement.CPRTraining.label,
                                        ),
                                      );
                                    },
                                  )
                                : const SizedBox.shrink(),
                          WorkRequirement.CertifiedElderlyCareTraining =>
                            widget.nanny.elderlyCareTrainingLink.isNotEmpty
                                ? PdfUploadButton(
                                    text: widget.nanny.elderlyCareTrainingLink
                                        .split("/")
                                        .last,
                                    onPressed: () {
                                      NavigationService.push(
                                        target: PdfViewerScreen(
                                          link: widget
                                              .nanny.elderlyCareTrainingLink,
                                          label: WorkRequirement
                                              .CertifiedElderlyCareTraining
                                              .label,
                                        ),
                                      );
                                    },
                                  )
                                : const SizedBox.shrink(),
                          WorkRequirement.CertifiedNannyTraining => widget
                                  .nanny.nannyCerificateTrainingLink.isNotEmpty
                              ? PdfUploadButton(
                                  text: widget.nanny.nannyCerificateTrainingLink
                                      .split("/")
                                      .last,
                                  onPressed: () {
                                    NavigationService.push(
                                      target: PdfViewerScreen(
                                        link: widget
                                            .nanny.nannyCerificateTrainingLink,
                                        label: WorkRequirement
                                            .CertifiedNannyTraining.label,
                                      ),
                                    );
                                  },
                                )
                              : const SizedBox.shrink(),
                          WorkRequirement.FirstAidTraining =>
                            widget.nanny.firstAidPermitLink.isNotEmpty
                                ? PdfUploadButton(
                                    text: widget.nanny.firstAidPermitLink
                                        .split("/")
                                        .last,
                                    onPressed: () {
                                      NavigationService.push(
                                        target: PdfViewerScreen(
                                          link: widget.nanny.firstAidPermitLink,
                                          label: WorkRequirement
                                              .FirstAidTraining.label,
                                        ),
                                      );
                                    },
                                  )
                                : const SizedBox.shrink(),
                          WorkRequirement.WorkPermit => widget
                                  .nanny.workPermitLink.isNotEmpty
                              ? PdfUploadButton(
                                  text: widget.nanny.workPermitLink
                                      .split("/")
                                      .last,
                                  onPressed: () {
                                    NavigationService.push(
                                      target: PdfViewerScreen(
                                        link: widget.nanny.workPermitLink,
                                        label: WorkRequirement.WorkPermit.label,
                                      ),
                                    );
                                  },
                                )
                              : const SizedBox.shrink(),
                        },
                        const SizedBox(height: 8),
                      ],
                    );
                  }).toList(),
                ]),
              ),
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(
              horizontal: CustomTheme.horizontalPadding, vertical: 8),
          sliver: SliverToBoxAdapter(
            child: Card(
              color: Colors.white,
              child: SectionWrapper(
                title: "Skills",
                titleFontSize: 18,
                child: Column(children: [
                  ...widget.nanny.skills.map((option) {
                    return BulletPoint(text: option.name);
                  }).toList(),
                ]),
              ),
            ),
          ),
        ),
        SliverSizedBox(
          height: 20.hp,
        )
      ],
    );
  }
}

class PdfUploadButton extends StatelessWidget {
  final String text;
  final VoidCallback? onClosed;
  final VoidCallback? onPressed;
  const PdfUploadButton({
    super.key,
    required this.text,
    this.onClosed,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final appTextTheme = Theme.of(context).extension<AppTextTheme>()!;
    return Container(
      decoration: BoxDecoration(
        color: CustomTheme.backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      child: InkWell(
        onTap: onPressed,
        child: Row(
          children: [
            Image.asset(
              Assets.pdf,
              height: 28,
              width: 28,
            ),
            SizedBox(width: 8.wp),
            Expanded(
              child: Text(
                text,
                style: appTextTheme.bodyRegular,
              ),
            ),
            if (onClosed != null)
              CustomIconButton(
                icon: Icons.close,
                backgroundColor: const Color(0xFFFFEBEF),
                iconSize: 18,
                iconColor: CustomTheme.red,
                padding: 6,
                onPressed: onClosed,
              )
          ],
        ),
      ),
    );
  }
}
