import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vassanou/Authentification/Signup.dart';
import 'package:vassanou/Component/Bottombar.dart';
import 'package:vassanou/Pages/AjoutProduit.dart';
import 'package:vassanou/Services/firebase/Auth.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() {
    return LoginState();
  }
}

class LoginState extends State<Login> {
  final emailOrPhone = TextEditingController();
  final password = TextEditingController();
  bool showPassword = false;
  bool isRememberMeChecked = false;
  final formKey = GlobalKey<FormState>();
  bool isPhoneNumber = false;
  bool isLoading = false;

  // verification si c'est un numero ou pas
  void checkUserEntry(String value) {
    final phoneRegex = RegExp(r'^(9[0-9]{7}|6[0-9]{7}|5[0-9]{7}|4[0-9]{7})$');
    if (phoneRegex.hasMatch(value)) {
      setState(() {
        isPhoneNumber = true;
      });
    } else {
      setState(() {
        isPhoneNumber = false;
      });
    }
  }

  // verification email et numero tel
  String? validateEmailOrPhone(String? value) {
    final phoneRegex = RegExp(r'^(9[0-9]{7}|6[0-9]{7}|5[0-9]{7}|4[0-9]{7})$');
    if (value == null || value.isEmpty) {
      return "Ce champ est obligtoire";
    }
    if (isPhoneNumber) {
      if (!phoneRegex.hasMatch(value)) {
        return "Format de numéro béninois invalide";
      }
      return null;
    }

    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);
    if (value.isNotEmpty && !regex.hasMatch(value)) {
      return "Entrez un email valide";
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final largeurEcran = MediaQuery.of(context).size.width;
    final hauteurEcran = MediaQuery.of(context).size.height;
    return Scaffold(
      
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Se connecter",
                      style:
                          TextStyle(fontSize: 28, fontWeight: FontWeight.bold,),
                    ),
                    Image.asset(
                      "assets/images/login.png",
                      width: largeurEcran * 0.4,
                      height: hauteurEcran * 0.3,
                    )
                  ],
                ),
              // Champ email ou téléphone
               
                Container(
                  margin: EdgeInsets.all(8),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.teal.shade700,
                        width: 2.0,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      // Préfixe pour le numéro béninois
                      if (isPhoneNumber)
                        Container(
                          margin: EdgeInsets.all(8),
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Text(
                            "+229",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      // Expanded pour permettre au texte field d'occuper tout l'espace disponible
                      Expanded(
                        child: TextFormField(
                          controller: emailOrPhone,
                          keyboardType: isPhoneNumber
                              ? TextInputType.phone
                              : TextInputType.emailAddress,
                          onChanged: (value) {
                            checkUserEntry(value);
                          },
                          validator: validateEmailOrPhone,
                          decoration: InputDecoration(
                              icon: Icon(
                                  isPhoneNumber ? Icons.phone : Icons.email),
                              border: InputBorder.none,
                              hintText: "Email ou Numero de telephone"
                                  ),
                        ),
                      ),

                      // Bouton d'envoi de code si c'est un numéro de téléphone
                      if (isPhoneNumber)
                        TextButton(
                          onPressed: () {
                            // Logique pour envoyer le code de vérification
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    "Code envoyé au +229 ${emailOrPhone.text}"),
                              ),
                            );
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.teal.shade700,// foregroung pour donner la couleur des lements au premier plan
                          ),
                          child: const Text("Envoyer le code"),
                        ),
                    ],
                  ),
                ),

                // Champ pour le code OTP (apparaît seulement si c'est un numéro de téléphone)
                if (isPhoneNumber)
                  Container(
                    margin: const EdgeInsets.all(8),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.teal.shade700,
                          width: 2.0,
                        ),
                      ),
                    ),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      maxLength: 6,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.sms),
                        border: InputBorder.none,
                        hintText: "Code de vérification",
                        
                      ),
                    ),
                  ),

              // Champ mot de passe
              Container(
                margin: EdgeInsets.all(8),
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.teal.shade700,
                      width: 2.0,
                    ),
                  ),
                ),
                child: TextFormField(
                  controller: password,
                  obscureText: !showPassword,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Mot de passe obligatoire";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    icon: Icon(Icons.lock),
                    border: InputBorder.none,
                    hintText: "Password",
                    suffixIcon: IconButton(
                      onPressed: () => setState(() {
                        showPassword = !showPassword;
                      }),
                      icon: Icon(
                          showPassword ? Icons.visibility : Icons.visibility_off),
                    ),
                  ),
                ),
              ),

              // Case "Se souvenir de moi"
              Row(
                children: [
                  Checkbox(
                    checkColor: Colors.white,
                    activeColor: Colors.teal.shade700,
                    value: isRememberMeChecked,
                    onChanged: (value) {
                      setState(() {
                        isRememberMeChecked = value!;
                      });
                    },
                  ),
                  Text("Se souvenir de moi"),
                ],
              ),

              // Bouton connexion
              Container(
                width: largeurEcran * 0.9,
                height: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.teal.shade700,
                ),
                child: TextButton(
                  onPressed:isLoading ?null: () async {
                    setState(() {
                      isLoading = true;
                    });
                    if (formKey.currentState!.validate()) {
                      // Logique de connexion
                      try{
                        await Auth().loginWithEmailAndPassword(
                          emailOrPhone.text,password.text
                        );
                        setState(() {
                      isLoading = false;
                    });
                      }on FirebaseAuthException catch(e){
                        setState(() {
                      isLoading = false;
                    });
                        // message d'erreur
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("${e.message}"),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Color(0xffE9494F),
                          showCloseIcon: true,
                          ),
                          
                        );
                      }
                      // naviguer vers la page de connexion
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> const AjoutProduit()));
                    }
                  },
                  child: isLoading ? const CircularProgressIndicator():
                  Text(
                    "Se connecter",
                    style: TextStyle(
                        fontSize: largeurEcran * 0.04, color: Colors.white),
                  ),
                ),
              ),
               Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Pas utilisateur?"),
                    TextButton(
                      child: Text("S'inscrire",style: TextStyle(color: Colors.teal.shade700),),
                      onPressed: () => setState(() {
                        // naviguer vers la page d'inscription
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> const Signup()));
                      }),
                    )
                  ],
                ),
              // mot de passe oublié
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Mot de passe oublié?"),
                    TextButton(
                      child: Text("Réinitialiser",style: TextStyle(color: Colors.teal.shade700),),
                      onPressed: () => setState(() {
                        // naviguer vers la page de connexion
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> const AnimatedBarExample()));
                      }),
                    )
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
