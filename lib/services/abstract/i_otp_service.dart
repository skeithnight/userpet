import 'dart:async';

import 'package:userpet/models/login.dart';
import 'package:userpet/models/otp.dart';
import 'package:userpet/services/network_service_response.dart';

abstract class IOTPService {
  Future<NetworkServiceResponse<CreateOTPResponse>> createOTP(
      String phoneNumber);
  Future<NetworkServiceResponse<OTPResponse>> fetchOTPLoginResponse(
      Login userLogin);
}
