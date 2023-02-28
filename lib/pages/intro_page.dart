import 'package:flutter/material.dart';
import 'package:intro_app_ui/pages/home_page.dart';

import '../utils/strings.dart';

class IntroPage extends StatefulWidget {
  static final String id = "intro_page";

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  late PageController _pageController;
  int currentIndex = 0;

  @override
  void initState() {
    _pageController = PageController(
      initialPage: 0
    );
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView(
            onPageChanged: (int page){
              setState(() {
                currentIndex = page;
              });
            },
            controller: _pageController,
            children: [
              makePage(
                image: "assets/images/image_1.png",
                title: Strings.stepOneTitle,
                content: Strings.stepOneContent
              ),
              makePage(
                  image: "assets/images/image_2.png",
                  title: Strings.stepTwoTitle,
                  content: Strings.stepTwoContent
              ),
              makePage(
                  image: "assets/images/image_3.png",
                  title: Strings.stepThreeTitle,
                  content: Strings.stepThreeContent
              )
            ],
          ),

          Container(
            margin: EdgeInsets.only(bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _buildIndicator(),
            ),
          ),

         Visibility(
           visible: currentIndex == 2,
           child: Container(
             height: double.infinity,
             width: double.infinity,
             alignment: Alignment.bottomRight,
             child:  Container(
               child: TextButton(
                   child: Text("Skip", style: TextStyle(color: Colors.red, fontSize: 18),),
                   onPressed: () {
                     Navigator.pushReplacementNamed(context, HomePage.id);
                   }
               ),
             ),
           ),
         )
        ],
      )
    );
  }

  Widget makePage({image, title, content}){
    return Container(
      padding: EdgeInsets.only(left: 50, right: 50, bottom: 50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Text(title, style: TextStyle(color: Colors.red, fontSize: 30, fontWeight: FontWeight.bold),),
              SizedBox(height: 30,),
              Text(content, style: TextStyle(color: Colors.grey.shade700, fontSize: 20), textAlign: TextAlign.center,),
              SizedBox(height: 30,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Image.asset(image),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _indicator(bool isActive){
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: 6,
      width: isActive ? 30:6,
      margin: EdgeInsets.only(right: 7),
      decoration: BoxDecoration(
        color: Colors.redAccent,
        borderRadius: BorderRadius.circular(5)
      ),
    );
  }

  List<Widget> _buildIndicator(){
    List<Widget> indicators = [];
    for(int i = 0; i < 3; i++){
      if(currentIndex == i){
        indicators.add(_indicator(true));
      }else{
        indicators.add(_indicator(false));
      }
    }
    return indicators;
  }
}
