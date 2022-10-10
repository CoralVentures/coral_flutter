import 'package:coral_analytics_repository/coral_analytics_repository.dart';
import 'package:coral_bootstrap/coral_bootstrap.dart';
import 'package:flutter/material.dart';
import 'package:lumberdash/lumberdash.dart';
import 'package:mocktail/mocktail.dart';

class CoralMockedApp {
  CoralMockedApp({
    required this.appBuilder,
  });

  final CoralAppBuilder appBuilder;

  final mockAnalyticsRepository = MockAnalyticsRepository();
  final mockLumberdashClient = MockLumberdashClient();

  Future<Widget> createApp() async {
    return await appBuilder(
      analyticsRepository: mockAnalyticsRepository,
    );
  }
}

class MockAnalyticsRepository extends Mock implements CoralAnalyticsRepository {
}

class MockLumberdashClient extends Mock implements LumberdashClient {}
