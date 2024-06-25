import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:sokari_flutter_interview/atom/custom_map_marker.dart';
import 'package:sokari_flutter_interview/model/map_marker_model.dart';

class MapView extends StatefulWidget {
  const MapView(this.markerModel, {super.key});

  final MapMarkerModel markerModel;

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  @override
  void dispose() {
    _mapController.dispose();
    widget.markerModel.dispose();
    super.dispose();
  }

  final MapController _mapController = MapController();
  static const _initialCenter = LatLng(37.4221, 122.0853);
  final Future _mapFuture =
      Future.delayed(const Duration(milliseconds: 4000), () => true);

  @override
  void initState() {
    super.initState();
    widget.markerModel.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final markerState = widget.markerModel.markerState;
    return FutureBuilder(
      future: _mapFuture,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container(
            color: Colors.grey.shade300,
          );
        }
        return FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            initialCenter: _initialCenter,
            initialZoom: 15,
            onMapEvent: (e) {
              if (e is MapEventMoveEnd || e is MapEventFlingAnimationEnd) {
                _mapController.move(_initialCenter, 15);
              }
            },
          ),
          children: [
            darkModeTilesContainerBuilder(
                context,
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.app',
                )),
            MarkerLayer(markers: [
              Marker(
                height: 50,
                width: 145,
                point: _initialCenter,
                child: AnimatedSwitcher(
                  duration: 1.seconds,
                  transitionBuilder: (widget, animation) {
                    return ScaleTransition(
                      alignment: Alignment.bottomLeft,
                      scale: animation,
                      child: widget,
                    );
                  },
                  child: markerState == MarkerState.hidden
                      ? const SizedBox.shrink()
                      : AnimatedSwitcher(
                          duration: 1.seconds,
                          transitionBuilder: (widget, animation) {
                            return Stack(
                              children: [
                                SizeTransition(
                                  axisAlignment: -1,
                                  axis: Axis.horizontal,
                                  sizeFactor: animation,
                                  child: widget,
                                ),
                                FadeTransition(
                                  opacity: animation,
                                  child: widget,
                                ),
                              ],
                            );
                            return SizeTransition(
                              axisAlignment: -1,
                              axis: Axis.horizontal,
                              sizeFactor: animation,
                              child: widget,
                            );
                            return FadeTransition(
                              opacity: animation,
                              child: widget,
                            );
                          },
                          layoutBuilder: (widget, widgets) {
                            return Stack(
                              children: [
                                Positioned(
                                  left: 0,
                                  child: widget ?? const SizedBox.shrink(),
                                ),
                                ...List.generate(
                                  widgets.length,
                                  (index) => Positioned(
                                      left: 0, child: widgets[index]),
                                ),
                              ],
                            );
                          },
                          child: markerState == MarkerState.icon
                              ? CustomMapMarker(
                                  key: UniqueKey(),
                                )
                              : const CustomMapMarker(
                                  child: AutoSizeText(
                                    minFontSize: 8,
                                    "Google Complex",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                        ),
                ),
              ),
            ]),
          ],
        );
      },
    );
  }

  Widget darkModeTilesContainerBuilder(
    BuildContext context,
    Widget tilesContainer,
  ) {
    return ColorFiltered(
      colorFilter: const ColorFilter.matrix(<double>[
        -1,
        0,
        0,
        0,
        255,
        0,
        -1,
        0,
        0,
        255,
        0,
        0,
        -1,
        0,
        255,
        0,
        0,
        0,
        1,
        0,
      ]),
      child: tilesContainer,
    );
  }
}
