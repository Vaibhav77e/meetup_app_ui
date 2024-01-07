import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Meetup extends StatelessWidget {
   Meetup({super.key});
  final controller = PageController();


ImageProvider<Object> _getAvatarImage(int index) {
  switch (index) {
    case 1:
      return AssetImage('assests/image1.jpg');
    case 2:
      return AssetImage('assests/image2.jpg');
    case 3:
      return AssetImage('assests/image3.jpg');
    case 4:
      return AssetImage('assests/image4.jpg');
    case 5:
      return AssetImage('assests/image5.jpg');
    default:
      return AssetImage('assests/image1.jpg');
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(onPressed: (){}, icon: const Icon(Icons.arrow_back_ios)),
        title: const Text('Individual Meetup',style: TextStyle(fontWeight: FontWeight.w600),),
        elevation: 1,
        shadowColor: Colors.grey,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Container(
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.black)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: SizedBox(
                          height: 30,
                          child: Image.asset('assests/loupe.png')),
                      ),
                  const Text('Search',style: TextStyle(color: Colors.grey),),
                    ],
                  ),
                  
                  Padding(
                    padding: const EdgeInsets.only(right:8.0),
                    child: SizedBox(
                      height: 30,
                      child: Image.asset('assests/microphone.png')),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 220,
              child: PageView(children: rowImages(),controller: controller,)),
            SizedBox(height: 10,
            child: SmoothPageIndicator(count: 3,
            controller: controller,
             effect: WormEffect(),),
            
            ),
            const SizedBox(height: 50,),
            const Text('Trending Popular People',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
            const SizedBox(height: 20,),
            SingleChildScrollView(
           scrollDirection: Axis.horizontal,
           child: Row(
            children: scrollableCards(),
          ),
        ),
          ]),
        ),
      ),
      
    );
  }


    List<Widget> rowImages() {
    List<String> imagePaths = [
      'assests/meeting.jpg',
      'assests/meeting.jpg',
      'assests/meeting.jpg',
    ];

    return imagePaths.map((String imagePath) {
      return Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          width: 500,
          height: 200,
          
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(20)
          ),
          child: ClipRRect(
             borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover, 
            ),
          ),
        ),
      );
    }).toList();
  }


    List<Widget> scrollableCards() {
    List<String> titles = ['Author','Publishers', 'Distributors', 'Contributors', 'Donators'];

    return titles.map((String title) {
      return Container(
        width: 320,
        height: 230,
        margin: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          //color: Colors.blue,
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle( fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              Text('1,208 Meetups',style: TextStyle(color: Colors.grey),),
              Divider(thickness: 0.5,),
              Expanded(
                child: Stack(
                  children: List.generate(
                    5,
                    (index) => Positioned(
                      left: index * 45.0,
                      child: ClipRRect(
                        child: CircleAvatar(
                          radius: 30,
                          backgroundImage: _getAvatarImage(index+1)
                        ),
                      ),
                    ),
                  ),
                )
              ),
             Row(
              mainAxisAlignment: MainAxisAlignment.end,
               children: [
                 Container(
                  decoration: BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 15),
                    child: Text('See more',style: TextStyle(color:Colors.white),),
                  ),
                 ),
               ],
             )
            ],
          ),
        ),
      );
    }).toList();
  }
}