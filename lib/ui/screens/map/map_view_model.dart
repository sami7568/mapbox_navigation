import 'package:eztransport/core/enums/view_state.dart';
import 'package:eztransport/core/others/base_view_model.dart';
import 'package:eztransport/core/others/logger_customizations/custom_logger.dart';
import 'package:eztransport/core/services/database_service.dart';
import 'package:eztransport/core/services/location_service.dart';
import 'package:eztransport/locator.dart';
import 'package:eztransport/ui/screens/home/home_screen.dart';
import 'package:eztransport/ui/screens/page4/page4.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mapbox_navigation/library.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class MyMapViewModel extends BaseViewModel {
  String _platformVersion = 'android';
  String instruction = "";
  final _locationService = LocationService();
  final _databaseService = locator<DatabaseService>();
  final log = CustomLogger(className: "MapBox");

  final pickupLocation = WayPoint(
    name: "pickupLocation",
    latitude: 34.006288,
    longitude: 71.516711,
  );
  final dropOffLocation = WayPoint(
    name: "dropOffLocation",
    latitude: 33.996931,
    longitude: 71.480456,
  );
  WayPoint? myLocation;

  MapBoxNavigation? directions;
  MapBoxOptions? options;

  bool isPickupCompleted = false;
  bool isDropOffCompleted = false;
  bool isDelivered = false;

  bool isMultipleStop = false;
  double? distanceRemaining, durationRemaining;
  MapBoxNavigationViewController? controller;

  bool routeBuilt = false;
  bool isNavigating = false;
  Position? position;
  bool isMyLocationLoading = false;

  MyMapViewModel() {
    init();
  }

  Future<void> init() async {
    log.i("initializing");
    isMyLocationLoading = true;
    position = await _locationService.getCurrentLocation();
    log.i(position!.latitude);
    log.i(position!.longitude);

    myLocation = WayPoint(
      name: "myLocation",
      latitude: position!.latitude,
      longitude: position!.longitude,
    );
    directions = await MapBoxNavigation(onRouteEvent: onEmbeddedRouteEvent);
    options = await MapBoxOptions(
        initialLatitude: position!.latitude,
        initialLongitude: position!.longitude,
        zoom: 12.0,
        tilt: 0.0,
        bearing: 0.0,
        enableRefresh: false,
        // alternatives: true,
        voiceInstructionsEnabled: true,
        bannerInstructionsEnabled: true,
        allowsUTurnAtWayPoints: true,
        mode: MapBoxNavigationMode.drivingWithTraffic,
        units: VoiceUnits.imperial,
        // simulateRoute: false,
        // animateBuildRoute: true,
        longPressDestinationEnabled: true,
        language: "en");
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await directions!.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    _platformVersion = platformVersion;

    log.i("_platformVersion $_platformVersion");
    isMyLocationLoading = false;
    notifyListeners();
  }

  Future<void> onEmbeddedRouteEvent(e) async {
    log.d(e);

    distanceRemaining = await directions!.distanceRemaining;
    durationRemaining = await directions!.durationRemaining;

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
        if (!isMultipleStop) {
          await Future.delayed(const Duration(seconds: 3));
          await controller!.finishNavigation();
        } else {}
        break;
      case MapBoxEvent.navigation_finished:
      case MapBoxEvent.navigation_cancelled:
        routeBuilt = false;
        isNavigating = false;
        log.e("cancel navigation");
        break;
      default:
        break;
    }
    notifyListeners();
  }

  navigateToPickUp() async {
    isPickupCompleted = true;
    notifyListeners();
    var wayPoints = <WayPoint>[];
    wayPoints.add(myLocation!);
    wayPoints.add(pickupLocation);
    var response = await directions!.startNavigation(
      wayPoints: wayPoints,
      options: MapBoxOptions(
          mode: MapBoxNavigationMode.drivingWithTraffic,
          simulateRoute: false,
          language: "en",
          units: VoiceUnits.metric),
    );
    log.i(response);
    init();
    notifyListeners();
  }

  arriveAtPickup({double? lat, double? lng}) async {
    isPickupCompleted = true;
    notifyListeners();
    var date = DateTime.now();
    final response = await _databaseService.arriveAtPickup(
        pickupLocation.latitude!, pickupLocation.longitude!, date);
    log.i(response);
    notifyListeners();
  }

  navigateToDropOff() async {
    isDropOffCompleted = true;
    notifyListeners();
    var wayPoints = <WayPoint>[];
    wayPoints.add(pickupLocation);
    wayPoints.add(dropOffLocation);
    var response = await directions!.startNavigation(
      wayPoints: wayPoints,
      options: MapBoxOptions(
          mode: MapBoxNavigationMode.drivingWithTraffic,
          simulateRoute: false,
          language: "en",
          units: VoiceUnits.metric),
    );
    log.i(response);
    init();
    notifyListeners();
  }

  noShow() async {
    isDropOffCompleted = true;
    notifyListeners();
    final date = DateTime.now();
    log.i(date);
    setState(ViewState.busy);
    final response = await _databaseService.noShow(date);
    log.i(response);
    setState(ViewState.idle);
    Get.offAll(HomeScreen());
    notifyListeners();
  }

  delivered() async {
    Get.to(Page4());
    notifyListeners();
  }

  @override
  void dispose() {
    controller!.clearRoute();
    super.dispose();
  }
}
