import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gardenesp/generated/l10n.dart';
import 'package:gardenesp/test/preview.dart';

abstract class GardenCardUiData {
  abstract final num sectors;
  abstract final num pointOfIrrigation;
  abstract final num humidity;
  abstract final String name;
  abstract final DateTime startTime;
}

class GardenCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        width: 164,
        height: 103,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/grass.jpg"),
            fit: BoxFit.fill,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [Colors.black, Colors.transparent],
              stops: [0.0, 0.5],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildContentTop(context, sectors: 2, poi: 20),
                _buildContentBottom(
                  context,
                  gardenName: "Main Garden",
                  activeSectors: 2,
                  activeDuration: Duration(minutes: 5),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContentTop(
    BuildContext context, {
    required num sectors,
    required num poi,
    num? humidity,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SprinklerAnimated(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              S.current.garden_card_sectors_poi(sectors, poi),
              style: Theme.of(context).textTheme.headline5,
            ),
            SizedBox(height: 4),
            Row(
              children: [
                SvgPicture.asset(
                  "assets/water_drop.svg",
                  width: 8,
                  height: 8,
                  color: Colors.white,
                ),
                SizedBox(width: 4),
                Text(
                  "${humidity?.toStringAsFixed(1) ?? "--"} %",
                  style: Theme.of(context).textTheme.headline5,
                ),
              ],
            )
          ],
        ),
      ],
    );
  }

  Widget _buildContentBottom(
    BuildContext context, {
    required String gardenName,
    required num activeSectors,
    required Duration activeDuration,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          gardenName,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        Text(
          "Start at 10:20",
          style: Theme.of(context).textTheme.bodyText2,
        ),
        Text(
          "2 active sectors - 5 min",
          style: Theme.of(context).textTheme.subtitle1,
        ),
      ],
    );
  }
}

class SprinklerAnimated extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      "assets/sprinkler_icon.svg",
      height: 17,
      color: Colors.white,
    );
  }
}

void main() {
  runApp(
    preview(
      GardenCard(),
    ),
  );
}
