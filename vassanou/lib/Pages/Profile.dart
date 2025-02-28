import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vassanou/Services/firebase/Auth.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() {
    return ProfileState();
  }
}

class ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final User? user = Auth().currentUser;
    final largeurEcran = MediaQuery.of(context).size.width;
    //final hauteurEcran = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        actions: [Icon(Icons.settings)],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Center(
                child: Text(
              "My profile",
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            )),
            SizedBox(
              height: 20,
            ),
            Row(
              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage("assets/images/login.png"),
                          fit: BoxFit.cover)),
                ),
                SizedBox(
                  width: 60,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Maman yabo",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      user?.email ?? "User email",
                      style: TextStyle(fontSize: 13),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: 100,
                      height: 35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.teal.shade700,
                      ),
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          "Modifier profil",
                          style: TextStyle(fontSize: 10, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                Icon(Icons.sell,color: Color(0xffE9494F),),
                Text(
                  "Vendu",
                  style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),
                  
                ),
                SizedBox(width: 190,),
                IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back_ios_new_rounded))
              ],
            ),
            Divider(thickness: 2, color: Colors.grey.withOpacity(0.5)),
            SizedBox(height: 10,),
            Row(
              children: [
                Icon(Icons.task_alt,color: Color(0xffE9494F),),
                Text(
                  "Parler au chef",
                  style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),
                  
                ),
                SizedBox(width: 130,),
                IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back_ios_new_rounded))
              ],
            ),
            Divider(thickness: 2, color: Colors.grey.withOpacity(0.5)),
            SizedBox(height: 10,),
            Row(
              children: [
                IconButton(
                  onPressed: ()=>
                  Auth().logout(), 
                  icon: Icon(Icons.logout,color: Color(0xffE9494F),),),
                
                Text(
                  "Déconnexion",
                  style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),
                  
                ),
                SizedBox(width: 110,),
                IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back_ios_new_rounded))
              ],
            ),
            Divider(thickness: 2, color: Colors.grey.withOpacity(0.5)),
            Image.asset("assets/images/user.jpg",width: largeurEcran*0.7,height: 200,)
          ],
        ),
      ),
    );
  }
}
