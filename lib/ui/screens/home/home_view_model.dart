import 'dart:convert';

import 'package:eztransport/core/others/base_view_model.dart';
import 'package:eztransport/core/others/logger_customizations/custom_logger.dart';
import 'package:eztransport/core/services/database_service.dart';
import 'package:eztransport/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mapbox_navigation/library.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeViewModel extends BaseViewModel {
  int _currentTabIndex = 2;
  final _log = CustomLogger(className: "Home View Model");
  int get currentTabIndex => _currentTabIndex;
  late TabController tabController;
  bool isExpand = false;
  final _dbService = locator<DatabaseService>();

  String _platformVersion = 'Unknown';
  String instruction = "";
  final _origin = WayPoint(
    name: "Way Point 1",
    latitude: 34.015858,
    longitude: 71.975449,
  );
  final _stop1 = WayPoint(
    name: "Way Point 2",
    latitude: 34.025917,
    longitude: 71.560135,
  );
  MapBoxNavigation? _directions;
  MapBoxOptions? options;
  bool _isMultipleStop = false;
  double? _distanceRemaining, _durationRemaining;
  MapBoxNavigationViewController? _controller;
  bool routeBuilt = false;
  bool isNavigating = false;

  HomeViewModel(TickerProvider tickerProvider) {
    tabController =
        TabController(length: 2, vsync: tickerProvider, initialIndex: 0);
    tabController.addListener(_handleTabController);
    _handleTabController();
    getTodayData(0);
    _directions = MapBoxNavigation(onRouteEvent: _onEmbeddedRouteEvent);
    initialize();
  }

  Future<void> _onEmbeddedRouteEvent(e) async {
    _distanceRemaining = await _directions!.distanceRemaining;
    _durationRemaining = await _directions!.durationRemaining;
    _log.i(_distanceRemaining != null
        ? "${(_distanceRemaining! * 0.000621371).toStringAsFixed(1)} miles"
        : "---");
    _log.i(_durationRemaining != null
        ? "${(_durationRemaining! / 60).toStringAsFixed(0)} minutes"
        : "---");

    switch (e.eventType) {
      case MapBoxEvent.progress_change:
        var progressEvent = e.data as RouteProgressEvent;
        if (progressEvent.currentStepInstruction != null) {
          instruction = progressEvent.currentStepInstruction!;
        }
        break;
      case MapBoxEvent.route_building:
      case MapBoxEvent.route_built:
        routeBuilt = true;
        break;
      case MapBoxEvent.route_build_failed:
        routeBuilt = false;
        break;
      case MapBoxEvent.navigation_running:
        isNavigating = true;

        break;
      case MapBoxEvent.on_arrival:
        if (!_isMultipleStop) {
          await Future.delayed(const Duration(seconds: 3));
          await _controller!.finishNavigation();
        } else {}
        break;
      case MapBoxEvent.navigation_finished:
      case MapBoxEvent.navigation_cancelled:
        routeBuilt = false;
        isNavigating = false;
        break;
      default:
        break;
    }
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initialize() async {
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    _log.i("initializing");
    _directions = MapBoxNavigation(onRouteEvent: _onEmbeddedRouteEvent);
    options = MapBoxOptions(
        initialLatitude: 34.025917,
        initialLongitude: 71.560135,
        zoom: 12.0,
        tilt: 0.0,
        bearing: 0.0,
        enableRefresh: false,
        alternatives: true,
        voiceInstructionsEnabled: true,
        bannerInstructionsEnabled: true,
        allowsUTurnAtWayPoints: true,
        mode: MapBoxNavigationMode.drivingWithTraffic,
        units: VoiceUnits.imperial,
        simulateRoute: false,
        animateBuildRoute: true,
        longPressDestinationEnabled: true,
        language: "en");

    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await _directions!.platformVersion;
      _log.wtf(_directions!.currentLegIndex);
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    _platformVersion = platformVersion;

    _log.i("_platformVersion $_platformVersion");
    notifyListeners();
  }

  startNavigation() async {
    var wayPoints = <WayPoint>[];
    wayPoints.add(_origin);
    wayPoints.add(_stop1);
    await _directions!.startNavigation(
        wayPoints: wayPoints,
        options: MapBoxOptions(
            mode: MapBoxNavigationMode.drivingWithTraffic,
            bannerInstructionsEnabled: true,
            simulateRoute: false,
            language: "en",
            units: VoiceUnits.metric));
  }

  _handleTabController() {
    _currentTabIndex = tabController.index;
    getTodayData(_currentTabIndex);
    notifyListeners();
  }

  getTodayData(int index) async {
    DateTime now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String date = formatter.format(now);
    _log.i(date);
    String response = await _dbService.getData(index);
    var decode = jsonDecode(response);
    _log.i(decode['query']);
    if (decode['query'] != "$index") {
      if (decode['data'] == "0 Trip Found") {
        Get.dialog(AlertDialog(
          title: Text("Data"),
          content: Text(decode['data']),
        ));
      }
    } else {
      _log.i(decode);
    }
    notifyListeners();
  }

  toggleIsExpand() {
    isExpand = !isExpand;
    notifyListeners();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }
}
