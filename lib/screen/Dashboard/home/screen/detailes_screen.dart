import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../utils/colors.dart';

class DetailesScreen extends StatelessWidget {
  var imag;
  var imag2;
  var imag3;
  var recipee_name;
  var personimage;
  var name;
  var description;
  var cooktime;
  var server;
  var ing2;
  var ing1;
  var email;
  var step2;
  var step3;
  var step4;

  DetailesScreen({Key? key,
    required this.imag,
    required this.imag2,
    required this.imag3,
    required this.name,
    required this.description,
    required this.recipee_name,
    required this.personimage,
    required this.cooktime,
    required this.server,
    required this.ing2,
    required this.ing1,
    required this.step2,
    required this.step3,
    required this.step4,
    required this.email,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           Container(
             height: 300,
             width: double.infinity,
             decoration: BoxDecoration(
               image: DecorationImage(
                 image: NetworkImage(imag),
                 fit: BoxFit.fill
               )
             ),
             child: InkWell(
               onTap: (){
                 Get.back();
               },
               child: Align(
                   alignment: Alignment.topLeft,
                   child: Padding(
                     padding: const EdgeInsets.only(top: 40,left: 10),
                     child: Icon(Icons.keyboard_arrow_left,color: Color(0xffEAF6F7),size: 40,),
                   )),
             ),
           ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(recipee_name,style: GoogleFonts.poppins(
                    fontSize: 20,fontWeight: FontWeight.w600
                  ),),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(personimage),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(name,style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            color: AppColor.blackColor,
                          ),),
                          Text(email,style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w300,
                            fontSize: 12,
                            color: AppColor.blackColor,
                          ),),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(description,style: GoogleFonts.poppins(
                      fontSize: 15,fontWeight: FontWeight.w400
                  ),),
                  Divider(
                    thickness: 1,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.person_outline),
                          SizedBox(
                            width: 5,
                          ),
                          Text(server,style: GoogleFonts.poppins(
                              fontSize: 15,fontWeight: FontWeight.w400
                          ),),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.watch_later_outlined),
                          SizedBox(
                            width: 5,
                          ),
                          Text("${cooktime} minuts",style: GoogleFonts.poppins(
                              fontSize: 15,fontWeight: FontWeight.w400
                          ),),
                        ],
                      ),

                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text("Ingredients",style: GoogleFonts.poppins(
                        fontSize: 20,fontWeight: FontWeight.w500
                    ),),
                  ),

                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(ing1,style: GoogleFonts.poppins(
                          fontSize: 19,fontWeight: FontWeight.w500
                      ),),
                      Text(ing2,style: GoogleFonts.poppins(
                          fontSize: 18,fontWeight: FontWeight.w500
                      ),),
                    ],
                  ),
                  Divider(
                    thickness: 1,
                  ),

                  SizedBox(
                    height: 20,
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  Text("Steps",style: GoogleFonts.poppins(
                      fontSize: 22,fontWeight: FontWeight.w500
                  ),),
                  SizedBox(height: 5,),
                  Container(
                    height:20,
                    width: 20,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: Center(child: Text("1",style: TextStyle(color: Colors.white,fontSize: 16),)),
                  ),
                  SizedBox(height: 5,),
                  Image.network(imag2,
                    height: 270,width: MediaQuery.of(context).size.width ,
                    fit: BoxFit.fill,
                  ),
                  SizedBox(height: 10,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height:20,
                        width: 20,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(20)
                        ),
                        child: Center(child: Text("2",style: TextStyle(color: Colors.white,fontSize: 16),)),
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        child: Text(step2,style: GoogleFonts.poppins(
                            fontSize: 18,fontWeight: FontWeight.w400
                        ),),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height:20,
                        width: 20,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(20)
                        ),
                        child: Center(child: Text("3",style: TextStyle(color: Colors.white,fontSize: 16),)),
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        child: Text(step3,style: GoogleFonts.poppins(
                            fontSize: 18,fontWeight: FontWeight.w400
                        ),),
                      ),

                    ],
                  ),
                  Image.network(imag3,
                    height: 270,width: MediaQuery.of(context).size.width ,
                    fit: BoxFit.fill,
                  ),
                  SizedBox(height: 10,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height:20,
                        width: 20,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(20)
                        ),
                        child: Center(child: Text("4",style: TextStyle(color: Colors.white,fontSize: 16),)),
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        child: Text(step4,style: GoogleFonts.poppins(
                            fontSize: 18,fontWeight: FontWeight.w400
                        ),),
                      ),

                    ],
                  ),

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
