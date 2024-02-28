
import 'package:flutter/material.dart';
import 'package:m2miage/model/activity_model.dart';
import 'package:m2miage/screens/Dashboard/dashboard_screen.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../utils/constant.dart';


class ActivitiesDeatilScreen extends StatefulWidget {
  ActivityModel? activityModel;

  ActivitiesDeatilScreen(
      {Key? key,this.activityModel})
      : super(key: key);

  @override
  State<ActivitiesDeatilScreen> createState() =>
      _ActivitiesDeatilScreenState();
}

class _ActivitiesDeatilScreenState
    extends State<ActivitiesDeatilScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
      appBar: AppBar(
      automaticallyImplyLeading: true,
      centerTitle: true,
      title:  Text(widget.activityModel!.title!,
        textAlign: TextAlign.center,
        style: const TextStyle(fontFamily: popinsFont,fontWeight: FontWeight.w700,fontSize: 18),),
      backgroundColor: mainPrimaryColor,

    ),
    body: SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
    child:Column(
        children: [
          Container(
            child: Image.network(
              widget.activityModel!.image!,
              width: screenWidth(context),
              height: screenHeight(context) * 0.3,
            ),
          ),
          SizedBox(height: 20,),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

            Text(
              "Title  : ${widget.activityModel!.title!}",
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
              textAlign: TextAlign.start,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontFamily: popinsFont,
                fontSize: 17, // Responsive font size
              ),
            ),
            SizedBox(height: 6,),
            Text(
              "Location  : ${widget.activityModel!.location!}",
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
              textAlign: TextAlign.start,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontFamily: popinsFont,
                fontSize: 17, // Responsive font size
              ),
            ),
            SizedBox(height: 6,),    Text(
              "Price  : ${widget.activityModel!.price!}",
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
              textAlign: TextAlign.start,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontFamily: popinsFont,
                fontSize: 17, // Responsive font size
              ),
            ),
            SizedBox(height: 6,),    Text(
              "Number of People  : ${widget.activityModel!.totalPeople!}",
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
              textAlign: TextAlign.start,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontFamily: popinsFont,
                fontSize: 17, // Responsive font size
              ),
            ),
            SizedBox(height: 6,),
            Text(
              "Category  : ${widget.activityModel!.category!}",
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
              textAlign: TextAlign.start,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontFamily: popinsFont,
                fontSize: 17, // Responsive font size
              ),
            ),
            SizedBox(height: 6,),
          ],),
          SizedBox(height: 30,),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              widget.activityModel!.isAddToCart() == true?
                  Container():
              GestureDetector(
                onTap: () async {
                  if (!widget.activityModel!.isAddToCart()) {
                    await widget.activityModel!.addToCart();
                  } else {
                    await widget.activityModel!.removeFromCart();
                  }
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text(
                        "Your activity is added to cart"),
                  ));
                  DashBoardScreen().launch(context);
                },
                child: Container(
                  height: screenHeight(context) * 0.07,
                  width: screenWidth(context) * 0.4,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: boxDecorationWithRoundedCorners(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    backgroundColor:mainPrimaryColor!,
                  ),
                  child:
                  Text('Add To Cart', style: boldTextStyle(color: white)),
                ),
              ),
            ],
          )
        ],
      ),
    ))));
  }

}
