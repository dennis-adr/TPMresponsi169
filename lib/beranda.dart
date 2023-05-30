import 'package:flutter/material.dart';
import 'package:responsi169/daerah.dart';
import 'package:responsi169/internasional.dart';
import 'package:responsi169/islam.dart';
import 'package:responsi169/terbaru.dart';

class Beranda extends StatefulWidget {
  const Beranda({super.key});

  @override
  State<Beranda> createState() => _BerandaState();
}

class _BerandaState extends State<Beranda> {
  List<String> buttonTexts = ['TERBARU', 'DAERAH', 'INTERNASIONAL', 'ISLAM'];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(18),
          height: size.height,
          width: size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: size.width,
                height: size.height * 0.35,
                child: Image.network(
                  'https://static.republika.co.id/files/images/logo.png',
                ),
              ),
              const SizedBox(height: 100),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 6,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: 4,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    width: 80,
                    height: 40,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.teal),
                      ),
                      onPressed: () {
                        print('Button $index pressed.');
                        if (index == 0) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => pageTerbaru()),
                          );
                        } else if (index == 1) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => pageDaerah()),
                          );
                        } else if (index == 2) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => pageInternasional()),
                          );
                        } else if (index == 3) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => pageIslam()),
                          );
                        }
                      },
                      child: Text(buttonTexts[index]),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
