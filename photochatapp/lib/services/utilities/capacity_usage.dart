import 'package:flutter/foundation.dart';
import 'package:photochatapp/services/requests/capacity_usage_request.dart';

double calculateCapacityUsage(CapacityUsageRequest req) {
  String msg = req.msg;
  double encoderCapacity = req.imgBytes.toDouble();
  double msgSize = msg.length.toDouble();
  return msgSize / encoderCapacity;
}

Future<double> calculateCapacityUsageAsync(CapacityUsageRequest req) async {
  double usage = await compute(calculateCapacityUsage, req);
  return usage;
}
