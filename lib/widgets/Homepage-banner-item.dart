import 'package:flutter/material.dart';
import 'package:mobile_programming_project/widgets/Homepage-banner-item.dart';
import 'package:mobile_programming_project/widgets/list-of-movies.dart';
class HomepageBannerItem extends StatelessWidget {
  final String imageUrl;
  final String bannerText;
  final bool isLandscape;

  const HomepageBannerItem(
    this.isLandscape,
    this.imageUrl,
    this.bannerText,
  );


  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(topfive.routeName);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 9.0,
            horizontal: 17.0,
          ),
          child: Container(
            height: isLandscape ? (MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top)  * 0.70 : (MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top)  * 0.30,
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
                    child: Image.network(
                      imageUrl,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: 15,
                    left: 15,
                    child: Text(
                      bannerText,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white),
                    ),
                  ),
                  Ink(
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
