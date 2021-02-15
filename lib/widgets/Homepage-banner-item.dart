import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class HomepageBannerItem extends StatelessWidget {
  final String imageUrl;
  final String bannerText;
  final bool isLandscape;
  final Function navigate;

  const HomepageBannerItem(this.isLandscape,
      this.imageUrl,
      this.bannerText,
      this.navigate,);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: navigate,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 9.0,
          horizontal: 17.0,
        ),
        child: Container(
          height: isLandscape
              ? (MediaQuery
              .of(context)
              .size
              .height -
              MediaQuery
                  .of(context)
                  .padding
                  .top) *
              0.70
              : (MediaQuery
              .of(context)
              .size
              .height -
              MediaQuery
                  .of(context)
                  .padding
                  .top) *
              0.30,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.transparent,
          ),
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            color: Colors.blueAccent,
            child: Stack(
                children: <Widget>[
            ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: FadeInImage.memoryNetwork(
              placeholder: kTransparentImage, image: imageUrl,width: double.infinity,fit: BoxFit.cover,),
        ),
        Positioned(
          bottom: 10,
          left: 10,
          child: Container(
            color: Colors.black54,
            child: Text(
              bannerText,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.white,
              ),
              overflow: TextOverflow.fade,
              softWrap: true,
            ),
          ),
        ),
        ],
      ),
    ),)
    ,
    )
    );
  }
}
