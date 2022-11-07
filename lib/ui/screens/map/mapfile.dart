// import 'package:eztransport/core/constants/colors.dart';
// import 'package:eztransport/core/constants/style.dart';
// import 'package:eztransport/core/others/logger_customizations/custom_logger.dart';
// import 'package:eztransport/core/services/location_service.dart';
// import 'package:eztransport/locator.dart';
// import 'package:eztransport/ui/screens/map/map_view_model.dart';
// import 'package:flutter/material.dart';
// import 'dart:async';

// import 'package:flutter/services.dart';
// import 'package:flutter_mapbox_navigation/library.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:provider/provider.dart';

// class MapScreen extends StatefulWidget {
//   const MapScreen({Key? key, required this.lat, required this.lng})
//       : super(key: key);
//   final double lat, lng;

//   @override
//   _MapScreenState createState() => _MapScreenState();
// }

// class _MapScreenState extends State<MapScreen> {
//   String _platformVersion = 'Unknown';
//   String instruction = "";
//   final _locationService = locator<LocationService>();
//   final log = CustomLogger(className: "MapBox");

//   final pickupLocation = WayPoint(
//     name: "pickupLocation",
//     latitude: 34.006288,
//     longitude: 71.516711,
//   );
//   final dropOffLocation = WayPoint(
//     name: "dropOffLocation",
//     latitude: 33.996931,
//     longitude: 71.480456,
//   );
//   late final myLocation;

//   MapBoxNavigation? _directions;
//   MapBoxOptions? _options;

//   bool _isMultipleStop = false;
//   double? distanceRemaining, durationRemaining;
//   MapBoxNavigationViewController? _controller;
//   // CameraPosition? _initialCameraPosition;
//   // late MapboxMapController controller;
//   bool routeBuilt = false;
//   bool isNavigating = false;
//   Position? position;

//   @override
//   void initState() {
//     super.initState();
//     initialize();
//   }

//   // Platform messages are asynchronous, so we initialize in an async method.
//   Future<void> initialize() async {
//     // If the widget was removed from the tree while the asynchronous platform
//     // message was in flight, we want to discard the reply rather than calling
//     // setState to update our non-existent appearance.
//     if (!mounted) return;
//     log.i("initializing");
//     position = await _locationService.getCurrentLocation();
//     log.i(position!.latitude);
//     log.i(position!.longitude);
//     myLocation = WayPoint(
//       name: "myLocation",
//       latitude: position!.latitude,
//       longitude: position!.longitude,
//     );

//     _directions = await MapBoxNavigation(onRouteEvent: _onEmbeddedRouteEvent);

//     _options = await MapBoxOptions(
//         initialLatitude: 34.025917,
//         initialLongitude: 71.560135,
//         zoom: 12.0,
//         tilt: 0.0,
//         bearing: 0.0,
//         enableRefresh: false,
//         // alternatives: true,
//         voiceInstructionsEnabled: true,
//         bannerInstructionsEnabled: true,
//         allowsUTurnAtWayPoints: true,
//         mode: MapBoxNavigationMode.drivingWithTraffic,
//         units: VoiceUnits.imperial,
//         // simulateRoute: false,
//         // animateBuildRoute: true,
//         longPressDestinationEnabled: true,
//         language: "en");

//     String platformVersion;
//     // Platform messages may fail, so we use a try/catch PlatformException.
//     try {
//       platformVersion = await _directions!.platformVersion;
//     } on PlatformException {
//       platformVersion = 'Failed to get platform version.';
//     }

//     setState(() {
//       _platformVersion = platformVersion;
//     });
//     log.i("_platformVersion $_platformVersion");
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (BuildContext context) => MyMapViewModel(),
//       child: Consumer<MyMapViewModel>(
//         builder: (context, model, child) => Scaffold(
//           body: Column(children: <Widget>[
//             Expanded(
//               flex: 1,
//               child: MapBoxNavigationView(
//                   options: _options,
//                   onRouteEvent: _onEmbeddedRouteEvent,
//                   onCreated: (MapBoxNavigationViewController controller) async {
//                     log.i("controller $controller");
//                     _controller = controller;
//                     controller.initialize();
//                   }),
//             ),
//             Column(
//               children: [
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     ElevatedButton(
//                       child: Text(
//                         "Direction to Pick Up",
//                         style: bodyTextStyle.copyWith(color: kBlackColor),
//                       ),
//                       style: ElevatedButton.styleFrom(
//                         primary: kGreyColor,
//                         textStyle: bodyTextStyle.copyWith(),
//                       ),
//                       onPressed: () async {
//                         var wayPoints = <WayPoint>[];
//                         wayPoints.add(pickupLocation);
//                         wayPoints.add(dropOffLocation);
//                         await _directions!.startNavigation(
//                             wayPoints: wayPoints,
//                             options: MapBoxOptions(
//                                 mode: MapBoxNavigationMode.drivingWithTraffic,
//                                 simulateRoute: false,
//                                 language: "en",
//                                 units: VoiceUnits.metric));
//                       },
//                     ),
//                     // const SizedBox(
//                     //   width: 10,
//                     // ),

//                     // ElevatedButton(
//                     //   child: const Text("Start Multi Stop"),
//                     //   onPressed: () async {
//                     //     _isMultipleStop = true;
//                     //     var wayPoints = <WayPoint>[];
//                     //     wayPoints.add(origin);
//                     //     wayPoints.add(stop1);
//                     //     wayPoints.add(origin);
//                     //     await _directions!.startNavigation(
//                     //         wayPoints: wayPoints,
//                     //         options: MapBoxOptions(
//                     //             mode: MapBoxNavigationMode.driving,
//                     //             simulateRoute: true,
//                     //             language: "en",
//                     //             allowsUTurnAtWayPoints: true,
//                     //             units: VoiceUnits.metric));
//                     //   },
//                     // )
//                   ],
//                 ),
//                 // Container(
//                 //   color: Colors.grey,
//                 //   width: double.infinity,
//                 //   child: const Padding(
//                 //     padding: EdgeInsets.all(10),
//                 //     child: (Text(
//                 //       "Embedded Navigation",
//                 //       style: TextStyle(color: Colors.white),
//                 //       textAlign: TextAlign.center,
//                 //     )),
//                 //   ),
//                 // ),

//                 ElevatedButton(
//                   child: Text(
//                     "Arrived at Pick Up",
//                     style: bodyTextStyle.copyWith(color: kBlackColor),
//                   ),
//                   style: ElevatedButton.styleFrom(
//                     primary: kGreyColor,
//                     textStyle: bodyTextStyle.copyWith(),
//                   ),
//                   onPressed: () async {
//                     var wayPoints = <WayPoint>[];
//                     wayPoints.add(pickupLocation);
//                     wayPoints.add(dropOffLocation);
//                     await _directions!.startNavigation(
//                         wayPoints: wayPoints,
//                         options: MapBoxOptions(
//                             mode: MapBoxNavigationMode.drivingWithTraffic,
//                             simulateRoute: false,
//                             language: "en",
//                             units: VoiceUnits.metric));
//                   },
//                 ),

//                 // Row(
//                 //   mainAxisAlignment: MainAxisAlignment.center,
//                 //   children: [
//                 //     ElevatedButton(
//                 //       onPressed: isNavigating
//                 //           ? null
//                 //           : () {
//                 //               if (routeBuilt) {
//                 //                 _controller!.clearRoute();
//                 //               } else {
//                 //                 var wayPoints = <WayPoint>[];
//                 //                 wayPoints.add(origin);
//                 //                 wayPoints.add(stop1);
//                 //                 _isMultipleStop = wayPoints.length > 2;
//                 //                 _controller!.buildRoute(
//                 //                     wayPoints: wayPoints, options: _options);
//                 //               }
//                 //             },
//                 //       child: Text(routeBuilt && !isNavigating
//                 //           ? "Clear Route"
//                 //           : "Build Route"),
//                 //     ),
//                 //     const SizedBox(
//                 //       width: 10,
//                 //     ),
//                 //     ElevatedButton(
//                 //       onPressed: routeBuilt && !isNavigating
//                 //           ? () {
//                 //               _controller!.startNavigation();
//                 //             }
//                 //           : null,
//                 //       child: const Text("Start "),
//                 //     ),
//                 //     const SizedBox(
//                 //       width: 10,
//                 //     ),
//                 //     ElevatedButton(
//                 //       onPressed: isNavigating
//                 //           ? () {
//                 //               _controller!.finishNavigation();
//                 //             }
//                 //           : null,
//                 //       child: const Text("Cancel"),
//                 //     )
//                 //   ],
//                 // ),
//                 // const Center(
//                 //   child: Padding(
//                 //     padding: EdgeInsets.all(10),
//                 //     child: Text(
//                 //       "Long-Press Embedded Map to Set Destination",
//                 //       textAlign: TextAlign.center,
//                 //     ),
//                 //   ),
//                 // ),

//                 Padding(
//                   padding: const EdgeInsets.only(
//                       left: 20.0, right: 20, top: 20, bottom: 10),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       Row(
//                         children: <Widget>[
//                           const Text("Duration Remaining: "),
//                           Text(durationRemaining != null
//                               ? "${(durationRemaining! / 60).toStringAsFixed(0)} minutes"
//                               : "---")
//                         ],
//                       ),
//                       Row(
//                         children: <Widget>[
//                           const Text("Distance Remaining: "),
//                           Text(distanceRemaining != null
//                               ? "${(distanceRemaining! * 0.000621371).toStringAsFixed(1)} miles"
//                               : "---")
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 const Divider()
//               ],
//             ),
//           ]),
//         ),
//       ),
//     );
//   }

//   Future<void> _onEmbeddedRouteEvent(e) async {
//     log.d(e);

//     distanceRemaining = await _directions!.distanceRemaining;
//     durationRemaining = await _directions!.durationRemaining;

//     switch (e.eventType) {
//       case MapBoxEvent.progress_change:
//         var progressEvent = e.data as RouteProgressEvent;
//         if (progressEvent.currentStepInstruction != null) {
//           instruction = progressEvent.currentStepInstruction!;
//         }
//         break;
//       case MapBoxEvent.route_building:
//       case MapBoxEvent.route_built:
//         setState(() {
//           routeBuilt = true;
//         });
//         break;
//       case MapBoxEvent.route_build_failed:
//         setState(() {
//           routeBuilt = false;
//         });
//         break;
//       case MapBoxEvent.navigation_running:
//         setState(() {
//           isNavigating = true;
//         });
//         break;
//       case MapBoxEvent.on_arrival:
//         if (!_isMultipleStop) {
//           await Future.delayed(const Duration(seconds: 3));
//           await _controller!.finishNavigation();
//         } else {}
//         break;
//       case MapBoxEvent.navigation_finished:
//       case MapBoxEvent.navigation_cancelled:
//         setState(() {
//           routeBuilt = false;
//           isNavigating = false;
//         });
//         break;
//       default:
//         break;
//     }
//     setState(() {});
//   }
// }
