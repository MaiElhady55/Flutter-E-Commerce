import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/screens/LogIn_Screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../consts/AppColors.dart';

class OnBoardingModel {
  final String image;
  final String title;
  final String body;

  OnBoardingModel({
    required this.image,
    required this.title,
    required this.body,
  });
}

class OnBoardingScreen extends StatefulWidget {
  OnBoardingScreen({Key? key}) : super(key: key);
  static const String routeName = 'onBoarding';
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override

  var boardController = PageController();
  bool isLast = false;

  List<OnBoardingModel> boarding = [
    OnBoardingModel(
        image: 'assets/images/ec1.png',
        title: 'Online Shopping',
        body: 'Best Way to Shop and Get The Best Deals'),
    OnBoardingModel(
        image: 'assets/images/ec2.png',
        title: 'Hurry Up Right',
        body: 'Now Until It\'s Too Late'),
    OnBoardingModel(
        image: 'assets/images/ec3.jpg',
        title: 'Order Online',
        body: 'Make an Order Sitting on a Sofa Pay and Choose Online'),
  ];

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          TextButton(
            style: ButtonStyle(foregroundColor: MaterialStateProperty.all(Color.fromRGBO(255, 107, 107, 1))),
            onPressed: (){
              Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
            },
            child: Text('Skip'),),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
                child: PageView.builder(
                    controller: boardController,
                    physics: BouncingScrollPhysics(),
                    itemCount: boarding.length,
                    onPageChanged: (index) {
                      if (index == boarding.length - 1) {
                        print('last');
                        setState(() {
                          isLast = true;
                        });
                      } else {
                        print('Not last');
                        setState(() {
                          isLast = false;
                        });
                      }
                    },
                    itemBuilder: (context, index) =>
                        BuildBoardingItem(boarding[index]))),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  count: boarding.length,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: AppColors.deep_orange,
                    dotHeight: 10,
                    dotWidth: 10,
                    expansionFactor: 4,
                    spacing: 4,
                  ),
                ),
                Spacer(),
                FloatingActionButton(
                  backgroundColor: AppColors.deep_orange,
                  onPressed: () {
                    if (isLast == true) {
                      Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
                    }
                    else{
                      boardController.nextPage(
                        duration: Duration(milliseconds: 750),
                        curve: Curves.fastLinearToSlowEaseIn);
                    }
                  },
                  child: Icon(Icons.arrow_forward_ios),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget BuildBoardingItem(OnBoardingModel boarding) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Image(image: AssetImage(boarding.image))),
          SizedBox(height: 30),
          Text(boarding.title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              )),
          SizedBox(height: 15),
          Text(boarding.body,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              )),
          SizedBox(height: 30),
        ],
      );
}
