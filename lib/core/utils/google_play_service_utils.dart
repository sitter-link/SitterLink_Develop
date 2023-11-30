import 'package:google_api_availability/google_api_availability.dart';

class GooglePlayServiceUtils {
  Future<bool> get checkGoogleService async {
    final GooglePlayServicesAvailability availability = await GoogleApiAvailability
        .instance
        .checkGooglePlayServicesAvailability(true);

    switch (availability) {
      case GooglePlayServicesAvailability.notAvailableOnPlatform:
      case GooglePlayServicesAvailability.serviceMissing:
      case GooglePlayServicesAvailability.serviceInvalid:
      case GooglePlayServicesAvailability.unknown:
        return false;
      case GooglePlayServicesAvailability.serviceDisabled:
        return false;
      case GooglePlayServicesAvailability.serviceVersionUpdateRequired:
      case GooglePlayServicesAvailability.serviceUpdating:
        return false;
      case GooglePlayServicesAvailability.success:
        return true;
      default:
        return false;
    }
  }
}
