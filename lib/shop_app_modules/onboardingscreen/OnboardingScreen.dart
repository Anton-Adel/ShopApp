

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../shared/components/component.dart';
import '../../shared/network/local/cashHelper.dart';
import 'Login/shop_login_screen.dart';

class OnboardingModel {
  String Image;
  String Title;
  String Body;
  OnboardingModel({
    required this.Image,
    required this.Title,
    required this.Body,
});
}
class OnboardingScreen extends StatefulWidget {

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  var boardController=PageController();



  List<OnboardingModel> onboarding=[
    OnboardingModel(
      Image:'assets/images/onboarding.jpg',
      Body: 'On Boarding 1 Body',
      Title: 'On Boarding 1 Title'

    ),
    OnboardingModel(
        Image:'assets/images/onboarding.jpg',
        Body: 'On Boarding 2 Body',
        Title: 'On Boarding 2 Title'

    ),
    OnboardingModel(
        Image:'assets/images/onboarding.jpg',
        Body: 'On Boarding 3 Body',
        Title: 'On Boarding 3 Title'

    )
  ];

  bool last=false;
  void submit (){
    {    CashHelper.SetData(key: 'onboarding', value: true).then((value) {
        if(value)
          print("anton");
        print(CashHelper.getData('onboarding'));
        navigate_replace(context, Shop_Login_Screen());
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(onPressed: (){

            {
             submit();
            }
          }, child: Text("Skip",
          style: TextStyle(
            fontSize: 15,
            color: Colors.black
          ),
          ))
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(30.0),

        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: boardController,
          physics: BouncingScrollPhysics()
          ,itemBuilder: (context,index)=>Onboarding(onboarding[index]),
              itemCount: onboarding.length,
                onPageChanged: (index){
                  if(index==onboarding.length-1)
                    {
                      setState(() {
                        last=true;

                      });
                    }
                  else{
                    setState(() {
                      last=false;

                    });
                  }
                },
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                    controller: boardController,
                    effect: ExpandingDotsEffect(
                      dotColor: Colors.black,
                      activeDotColor: Colors.grey,
                    ),
                    count: onboarding.length),
                Spacer(),
                FloatingActionButton(onPressed: (){
                  boardController.nextPage(duration: Duration(
                    milliseconds: 1000,
                  ), curve: Curves.easeInOutCubicEmphasized);
                  if(last==true)
                   {
                     submit();
                   }

                },
                child: Icon(Icons.arrow_forward_ios),
                )
              ],
            )
          ],
        ),
      )
    );
  }

  Widget Onboarding(OnboardingModel model)=> Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(child: Image(image: AssetImage("${model.Image}"))),
      SizedBox(
        height: 15,
      ),
      Text('${model.Title}',
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(
        height: 15,
      ),
      Text('${model.Body}',
        style: TextStyle(
          fontSize: 16,

        ),
      )
    ],
  );
}
