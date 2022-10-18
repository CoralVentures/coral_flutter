import 'dart:async';
import 'package:flutter/foundation.dart';

/// {@template analytics_repository}
/// Class responsible of reporting different events to Segment and Amplitude
/// {@endtemplate}
class CoralAnalyticsRepository {
  /// {@macro analytics_repository}
  CoralAnalyticsRepository({
    required VoidCallback onInit,
    required this.onTrack,
    required this.onIdentify,
    required this.onScreen,
  }) : timestamp = DateTime.now().millisecondsSinceEpoch {
    onInit();
  }

  Future<void> Function({
    required String eventName,
    Map<String, dynamic>? properties,
    Map<String, dynamic>? options,
  }) onTrack;

  Future<void> Function({
    String? userId,
    Map<String, dynamic>? traits,
    Map<String, dynamic>? options,
  }) onIdentify;

  Future<void> Function({
    required String screenName,
    Map<String, dynamic>? properties,
    Map<String, dynamic>? options,
  }) onScreen;

  final int timestamp;
  String? _coralSessionId;

  // ignore: use_setters_to_change_properties
  void setCoralSessionId(String sessionId) {
    _coralSessionId = sessionId;
  }

  Map<String, dynamic> createOptions(Map<String, dynamic>? options) {
    return <String, dynamic>{
      'integrations': {
        'Amplitude': {
          'session_id': timestamp,
        }
      }
    }..addAll(options ?? {});
  }

  Map<String, dynamic> createProperties(Map<String, dynamic>? properties) {
    return <String, dynamic>{
      'coral_session_id': _coralSessionId,
    }..addAll(
        properties ?? {},
      );
  }

  /// Send Track event to Segment
  void track({
    required String eventName,
    Map<String, dynamic>? options,
    Map<String, dynamic>? properties,
  }) {
    unawaited(
      onTrack(
        eventName: eventName,
        options: createOptions(options),
        properties: createProperties(properties),
      ),
    );
  }

  /// Send Identity event to Segment
  void identify({
    required String userId,
    Map<String, dynamic>? options,
    Map<String, dynamic>? traits,
  }) {
    unawaited(
      onIdentify(
        userId: userId,
        options: createOptions(options),
        traits: traits,
      ),
    );
  }

  /// Send Screen event to Segment
  void screen({
    required String screenName,
    Map<String, dynamic>? options,
    Map<String, dynamic>? properties,
  }) {
    unawaited(
      onScreen(
        screenName: screenName,
        options: createOptions(options),
        properties: createProperties(properties),
      ),
    );
  }
}
