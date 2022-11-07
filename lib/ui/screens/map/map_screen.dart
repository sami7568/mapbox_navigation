import 'package:eztransport/core/constants/colors.dart';
import 'package:eztransport/core/constants/style.dart';
import 'package:eztransport/ui/screens/map/map_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mapbox_navigation/library.dart';
import 'package:provider/provider.dart';

class MapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => MyMapViewModel(),
      child: Consumer<MyMapViewModel>(
        builder: (context, model, child) => Scaffold(
          body: model.isMyLocationLoading
              ? Center(child: CircularProgressIndicator(color: kYellowColor))
              : Column(children: <Widget>[
                  Expanded(
                      flex: 1,
                      child: MapBoxNavigationView(
                          options: model.options,
                          onRouteEvent: model.onEmbeddedRouteEvent,
                          onCreated: (MapBoxNavigationViewController
                              controller) async {
                            model.log.i("controller $controller");
                            model.controller = controller;
                            controller.initialize();
                          })),
                  Column(
                    children: [
                      const SizedBox(height: 10),
                      !model.isPickupCompleted
                          ? pickUp(model)
                          : !model.isDropOffCompleted
                              ? dropOff(model)
                              : delivered(model),
                      const Divider()
                    ],
                  ),
                ]),
        ),
      ),
    );
  }

  pickUp(MyMapViewModel model) {
    return Column(
      children: [
        ElevatedButton(
          child: Text(
            "Direction to Pick Up",
            style: bodyTextStyle.copyWith(color: kBlackColor),
          ),
          style: ElevatedButton.styleFrom(
            primary: kGreyColor,
            textStyle: bodyTextStyle.copyWith(),
          ),
          onPressed: () async {
            model.navigateToPickUp();
          },
        ),
        ElevatedButton(
          child: Text(
            "Arrived at Pick Up",
            style: bodyTextStyle.copyWith(color: kBlackColor),
          ),
          style: ElevatedButton.styleFrom(
            primary: kGreyColor,
            textStyle: bodyTextStyle.copyWith(),
          ),
          onPressed: () async {
            model.arriveAtPickup();
          },
        ),
      ],
    );
  }

  dropOff(MyMapViewModel model) {
    return Column(
      children: [
        ElevatedButton(
          child: Text(
            "No Show",
            style: bodyTextStyle.copyWith(color: kBlackColor),
          ),
          style: ElevatedButton.styleFrom(
            primary: kGreyColor,
            textStyle: bodyTextStyle.copyWith(),
          ),
          onPressed: () async {
            model.noShow();
          },
        ),
        ElevatedButton(
          child: Text(
            "Start Trip",
            style: bodyTextStyle.copyWith(color: kBlackColor),
          ),
          style: ElevatedButton.styleFrom(
            primary: kGreyColor,
            textStyle: bodyTextStyle.copyWith(),
          ),
          onPressed: () async {
            model.navigateToDropOff();
          },
        ),
      ],
    );
  }

  delivered(MyMapViewModel model) {
    return ElevatedButton(
      child: Text(
        "Delivered",
        style: bodyTextStyle.copyWith(color: kBlackColor),
      ),
      style: ElevatedButton.styleFrom(
        primary: kGreyColor,
        textStyle: bodyTextStyle.copyWith(),
      ),
      onPressed: () async {
        model.delivered();
      },
    );
  }
}
