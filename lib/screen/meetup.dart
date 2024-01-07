import 'package:flutter/material.dart';

class Meetup extends StatelessWidget {
  const Meetup({super.key});

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
          child: Column(children: [
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
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: rowImages(),
              ),
            )
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
      return Container(
        width: 500,
        height: 200,
        margin: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
        ),
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover, // Change this to the desired BoxFit
        ),
      );
    }).toList();
  }
}