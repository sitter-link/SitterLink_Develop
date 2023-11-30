// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:nanny_app/core/utils/snackbar_utils.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLauncher {
  static Future<bool> launchWebsite(
      {required BuildContext context, required String url}) async {
    try {
      final canLaunch = await canLaunchUrl(Uri.parse(url));
      if (canLaunch) {
        launchUrl(Uri.parse(url));
        return true;
      } else {
        SnackBarUtils.showErrorMessage(
          context: context,
          message: "Unable to Launch Url",
        );
      }
      return false;
    } catch (e) {
      SnackBarUtils.showErrorMessage(
        context: context,
        message: "Unable to Launch Url",
      );
      return false;
    }
  }

  static Future<void> launchPhone(
      {required BuildContext context, required String phone}) async {
    try {
      final canLaunch = await canLaunchUrl(Uri.parse("tel:$phone"));
      if (canLaunch) {
        launchUrl(Uri.parse("tel:$phone"));
      } else {
        SnackBarUtils.showErrorMessage(
          context: context,
          message: "Unable to Launch Url",
        );
      }
    } catch (e) {
      SnackBarUtils.showErrorMessage(
        context: context,
        message: "Unable to Launch Url",
      );
    }
  }

  static Future<void> launchSMS(
      {required BuildContext context, required String phone}) async {
    try {
      final canLaunch = await canLaunchUrl(Uri.parse("sms:$phone"));
      if (canLaunch) {
        launchUrl(Uri.parse("sms:$phone"));
      } else {
        SnackBarUtils.showErrorMessage(
          context: context,
          message: "Unable to Launch Url",
        );
      }
    } catch (e) {
      SnackBarUtils.showErrorMessage(
        context: context,
        message: "Unable to Launch Url",
      );
    }
  }

  static Future<void> launchEmail(
      {required BuildContext context, required String email}) async {
    try {
      final Uri emailLaunchUri = Uri(scheme: 'mailto', path: email);
      final canLaunch = await canLaunchUrl(emailLaunchUri);
      if (canLaunch) {
        launchUrl(emailLaunchUri);
      } else {
        SnackBarUtils.showErrorMessage(
          context: context,
          message: "Unable to Launch Url",
        );
      }
    } catch (e) {
      SnackBarUtils.showErrorMessage(
        context: context,
        message: "Unable to Launch Url",
      );
    }
  }

  static Future<void> launchYoutubeChannel(
      {required BuildContext context, required String channelId}) async {
    try {
      final url = Uri.parse('https://www.youtube.com/channel/$channelId');
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        SnackBarUtils.showErrorMessage(
          context: context,
          message: "Unable to Launch Url",
        );
      }
    } catch (e) {
      SnackBarUtils.showErrorMessage(
        context: context,
        message: "Unable to Launch Url",
      );
    }
  }

  static Future<void> launchUrlLink(
      {required BuildContext context, required String url}) async {
    try {
      final url0 = Uri.parse(url);
      if (await canLaunchUrl(url0)) {
        await launchUrl(url0);
      } else {
        SnackBarUtils.showErrorMessage(
          context: context,
          message: "Unable to Launch Url",
        );
      }
    } catch (e) {
      SnackBarUtils.showErrorMessage(
        context: context,
        message: "Unable to Launch Url",
      );
    }
  }
}
