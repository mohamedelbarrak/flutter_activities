import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:empty_widget/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:m2miage/model/activity_model.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../utils/constant.dart';
import 'activity_detail_screen.dart';


class ActivitiesScreen extends StatefulWidget {
 String? category;

  ActivitiesScreen(
      {Key? key,this.category})
      : super(key: key);

  @override
  State<ActivitiesScreen> createState() =>
      _ActivitiesScreenState();
}

class _ActivitiesScreenState
    extends State<ActivitiesScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream:widget.category == "All"?FirebaseFirestore.instance
          .collection('activities')
          .snapshots():
      FirebaseFirestore.instance
          .collection('activities')
          .where('category', isEqualTo: widget.category)
          .snapshots(),
      builder: (
          BuildContext context,
          snapshot,
          ) {
        if (snapshot.data == null) {
          return Center(
              child: SpinKitCircle(
                color: mainPrimaryColor,
                size: 50.0,
              ));
        } else if (snapshot.connectionState == ConnectionState.active ||
            snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return const Text('Error');
          } else if (snapshot.hasData) {
            List<ActivityModel> activities = List<ActivityModel>.from(
                snapshot.data!.docs
                    .map((e) => ActivityModel().fromJson(e.data()))).toList();

            return activities.isEmpty
                ? Container(
              alignment: Alignment.center,
              child: EmptyWidget(
                image: null,
                packageImage: PackageImage.Image_3,
                title: 'No Activities',
                subTitle: 'No activities are available',
                titleTextStyle: const TextStyle(
                  fontSize: 22,
                  color: Color(0xff9da9c7),
                  fontWeight: FontWeight.w500,
                  fontFamily: popinsFont
                ),
                subtitleTextStyle: const TextStyle(
                  fontSize: 14,
                  color: Color(0xffabb8d6),
                ),
              ),
            )
                : ListView.builder(
                physics: AlwaysScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: activities.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  margin: const EdgeInsets.only(
                      left: 15, right: 10, bottom: 10,top: 10), // Responsive margins
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(10)), // Responsive borderRadius
                              child: CachedNetworkImage(
                                  progressIndicatorBuilder:
                                      (context, url, downloadProgress) => Center(
                                      child: CircularProgressIndicator(
                                          value: downloadProgress.progress)),
                                imageUrl: activities[index].image!,
                                fit: BoxFit.cover,
                                height: screenHeight(context) * 0.15,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 20, // Responsive width
                          ),
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      activities[index].title!,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 3,
                                      textAlign: TextAlign.start,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontFamily: popinsFont,
                                        fontSize: 17, // Responsive font size
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  activities[index].location!,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                    color: Colors.black54,
                                    fontFamily: popinsFont,
                                    fontSize: 16, // Responsive font size
                                  ),
                                ),
                                const SizedBox(height: 5), // Responsive height

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Text(
                                          "\$${activities[index].price!}",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontFamily: popinsFont,
                                            fontSize: 17, // Responsive font size
                                          ),
                                        ),
                                      ],
                                    ),

                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),

                    ],
                  ),
                ).onTap((){ActivitiesDeatilScreen(activityModel: activities[index],).launch(context);});
                });
          } else {
            return Container(
              alignment: Alignment.center,
              child: EmptyWidget(
                image: null,
                packageImage: PackageImage.Image_3,
                title: 'No Activities',
                subTitle: 'No activities are available',
                titleTextStyle: const TextStyle(
                  fontSize: 22,
                  color: Color(0xff9da9c7),
                  fontWeight: FontWeight.w500,
                ),
                subtitleTextStyle: const TextStyle(
                  fontSize: 14,
                  color: Color(0xffabb8d6),
                ),
              ),
            );
          }
        } else {
          return Center(
              child: SpinKitCircle(
                color: mainPrimaryColor,
                size: 50.0,
              ));
        }
      },
    );
  }
}
