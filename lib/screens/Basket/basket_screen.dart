import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:empty_widget/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:m2miage/model/activity_model.dart';
import '../../../utils/constant.dart';

class BasketScreen extends StatefulWidget {
  BasketScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<BasketScreen> createState() => _BasketScreenState();
}

class _BasketScreenState extends State<BasketScreen> {
  List<ActivityModel> activitiesList = [];
  int totalPrices = 0;
  bool isLoading = false;
  @override
  void initState() {
   getTotalPrices(activitiesList);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      bottomSheet: BottomSheet(
        elevation: 10,
        enableDrag: false,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(10), // Responsive padding
            child: Container(
                margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Total Price : ${totalPrices}\$",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontFamily: popinsFont,
                        fontSize: 18, // Responsive font size
                      ),
                    )
                  ],
                )),
          );
        },
        onClosing: () {},
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          "Cart",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: popinsFont,
              fontWeight: FontWeight.w700,
              fontSize: 18),
        ),
        backgroundColor: mainPrimaryColor,
      ),
      body:isLoading? Center(
          child: SpinKitCircle(
            color: mainPrimaryColor,
            size: 50.0,
          )):StreamBuilder(
        stream: FirebaseFirestore.instance.collection('activities').where(
            'is_cart_add',
            arrayContainsAny: [Constants.userModel!.id!]).snapshots(),
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
              List<ActivityModel> activities = List<ActivityModel>.from(snapshot
                  .data!.docs
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
                            fontFamily: popinsFont),
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
                              left: 15,
                              right: 10,
                              bottom: 10,
                              top: 20), // Responsive margins
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 1,
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                      // Responsive borderRadius
                                      child: CachedNetworkImage(
                                        progressIndicatorBuilder: (context, url,
                                                downloadProgress) =>
                                            Center(
                                                child:
                                                    CircularProgressIndicator(
                                                        value: downloadProgress
                                                            .progress)),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Expanded(
                                                child: Text(
                                              activities[index].title!,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 3,
                                              textAlign: TextAlign.start,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontFamily: popinsFont,
                                                fontSize:
                                                    17, // Responsive font size
                                              ),
                                            )),
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
                                            fontSize:
                                                16, // Responsive font size
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        // Responsive height

                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                Text(
                                                  "\$${activities[index].price!}",
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    fontFamily: popinsFont,
                                                    fontSize:
                                                        17, // Responsive font size
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                      child: GestureDetector(
                                    onTap: () async {
                                      await activities[index].removeFromCart();
                                       getTotalPrices(activities);
                                    },
                                    child: Icon(
                                      Icons.cancel,
                                      color: mainPrimaryColor,
                                      size: 30,
                                    ),
                                  ))
                                ],
                              ),
                            ],
                          ),
                        );
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
      ),
    ));
  }

  Future<void> getTotalPrices(List<ActivityModel> activities) async {
    totalPrices = 0;
    activitiesList = [];
    setState(() {
      isLoading = true;
    });
    await FirebaseFirestore.instance
        .collection('activities').where(
        'is_cart_add',
        arrayContainsAny: [Constants.userModel!.id!])
        .get()
        .then((checkSnapshot) {
      print(checkSnapshot.docs);
      if (checkSnapshot.docs.isNotEmpty) {
        activitiesList = List<ActivityModel>.from(checkSnapshot.docs
            .map((e) => ActivityModel().fromJson(e.data()))).toList();
      }
    });
    activitiesList.forEach((element) {
      totalPrices += int.parse(element.price!);
    });
    setState(() {
      isLoading = false;
    });
  }
}
