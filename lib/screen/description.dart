import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Description extends StatelessWidget {
   Description({super.key});
    final controller = PageController();



    void shareFile(String url) async {
    try {
      final urlFile = Uri.parse(url);
      final response = await http.get(urlFile);
      final bytes = response.bodyBytes;

      final temp = await getTemporaryDirectory();
      final path = '${temp.path}/image.jpg';
      final XFile xFile = XFile(path);
      File(path).writeAsBytesSync(bytes);

      await Share.shareXFiles([xFile],);
    } catch (e) {
      print(e.toString());
    }
  }

  void downloadFile(String url) {
    FileDownloader.downloadFile(url: url.trim());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(onPressed: (){}, icon: const Icon(Icons.arrow_back_ios)),
        title: const Text('Description',style: TextStyle(fontWeight: FontWeight.w600),),
        elevation: 1,
        shadowColor: Colors.grey,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             Container(
            //   decoration: BoxDecoration(
            //   border: Border.all(color: Colors.black),
            //   borderRadius: BorderRadius.circular(20)
            // ),
              height: 340,
              width: 400,
              child: Column(
              children: [
               Expanded(child: PageView(children: rowImages(),controller: controller,)),
               
                ],
              ),
              ),
              Row(
              children: [
                const Icon(Icons.save, color: Colors.blue),
                const Text('1034'),
               const SizedBox(width: 12,),
               const Icon(Icons.favorite_border, color: Colors.blue),
               const Text('1034'),
               const SizedBox(width: 12,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(color: const Color.fromARGB(255, 223, 222, 222),borderRadius: BorderRadius.circular(12)),
                  child: Row(
                    children: List.generate(4, (index) => Icon(Icons.star,color: Colors.blue,)),
                  ),
                ),
               const SizedBox(width: 8,),
               const Text('3.2',style: TextStyle(color: Colors.blue),)
                ],
              ),
              const SizedBox(height: 20,),
              const Text('Actor Name',style: TextStyle(fontSize: 18),),
              const Text('Indian Actress',style: TextStyle(fontSize: 14,color: Colors.grey),),
              
              const SizedBox(height: 15,),
              const Row(children: [ Icon(Icons.access_time_outlined ),SizedBox(width: 5,),
               Text('Duration',style: TextStyle(color: Colors.grey),),
               SizedBox(width: 5,),
              Text('20m',style: TextStyle(color: Colors.grey),)],),
              const SizedBox(height: 15,),
              const Row(children: [ Icon(Icons.account_balance_wallet ),SizedBox(width: 5,),
               Text('Total average Fees',style: TextStyle(color: Colors.grey),),
               SizedBox(width: 5,),
              Text('₹ 9999',style: TextStyle(color: Colors.grey),)],),
              const SizedBox(height: 35,),
              const Text('About',style: TextStyle(fontSize: 18),),
              const SizedBox(height: 15,),
              const Text("India, located in South Asia, stands as the world's second-most populous country and the seventh-largest by land area. Its diverse geography ranges from the towering Himalayan mountains to the expansive Gangetic plains and the Thar Desert. With New Delhi as the capital, India gained independence from British rule on August 15, 1947. The country is celebrated for its cultural richness, hosting various religions like Hinduism, Islam, Christianity, Sikhism, Buddhism, and Jainism. India's vibrant economy, marked by agriculture, manufacturing, and a rapidly growing services sector, positions it as one of the world's fastest-growing major economies.", textAlign: TextAlign.justify,)
            ],
          ),
        ),
      ),
    );
  }

List<Widget> rowImages() {
  List<String> downloadLinks =[
    'https://www.patanjaliayurved.net/assets/product_images/400x300/DIVYAHERBALPEY50GM400300.png',
    'https://www.patanjaliayurved.net/assets/product_images/400x500/1685600846400x500.jpg',
    'https://www.patanjaliayurved.net/assets/product_images/400x500/1665824241400x500.jpg',
    'https://www.patanjaliayurved.net/assets/product_images/400x300/DIVYAHERBALPEY50GM400300.png',
  ];

    return downloadLinks.map((String imagePath) {
      return Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Container(
              width: 500,
              height: 260,
              decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(20)
              ),
              child: ClipRRect(
                 borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  imagePath,
                  fit: BoxFit.cover, 
                ),
              ),
            ),
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
             IconButton(onPressed: (){
              //downloadFile(imagePath);
             }, icon: const Icon(Icons.arrow_downward)),
             IconButton(onPressed: (){}, icon: const Icon(Icons.save)),
             IconButton(onPressed: (){}, icon: const Icon(Icons.favorite_border)),
             IconButton(onPressed: (){}, icon: const Icon(Icons.copy)),
             IconButton(onPressed: (){}, icon: const Icon(Icons.star_border)),
             IconButton(onPressed: (){
              shareFile(imagePath);
             }, icon: const Icon(Icons.share)),
            ],),
          ],
        ),
      );
    }).toList();
  }
}