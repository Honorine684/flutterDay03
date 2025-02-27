import 'package:flutter/material.dart';
import 'package:vassanou/Authentification/Login.dart';
import 'package:vassanou/Pages/Home.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() {
    return SignupState();
  }
}

class SignupState extends State<Signup> {
  final emailOrPhone = TextEditingController();
  final name = TextEditingController();
  final pseudo = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  bool showPassword = false;
  bool showConfirmPassword = false;
  bool isPhoneNumber = false;
  final formKey = GlobalKey<FormState>();
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
                      "S'inscrire",
                      style:
                          TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                    Image.asset(
                      "assets/images/sign.jpg",
                      width: largeurEcran * 0.5,
                      height: hauteurEcran * 0.3,
                    )
                  ],
                ),
                // nom complet
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
                  child: TextFormField(
                    controller: name,

                    // pour verifier si le champ est bien rempli
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Le nom complet es obligatoire";
                      }

                      return null;
                    },
                    decoration: InputDecoration(
                        icon: Icon(Icons.person),
                        border: InputBorder.none,
                        hintText: "Nom complet"),
                  ),
                ),
                // pseudo
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
                  child: TextFormField(
                    controller: pseudo,
                    decoration: InputDecoration(
                        icon: Icon(Icons.near_me),
                        border: InputBorder.none,
                        hintText: "Pseudo"),
                  ),
                ),
                // email ou tel
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
                            foregroundColor: Colors.teal.shade700,
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
                        //counterText: "",
                      ),
                    ),
                  ),

                //password
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
                    // pour verifier si le champ est bien rempli
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Mot de passe obligatoire";
                      } else if ((password.text).length < 6) {
                        return "Le mot de passe doit contenir plus de 6 caractères";
                      } else if (!RegExp(r'[a-zA-Z]').hasMatch(password.text)) {
                        return "Le mot de passe doit contenir des lettres";
                      } else if (!RegExp(r'\d').hasMatch(password.text)) {
                        return "Le mot de passe doit contenir des nombres";
                      } else if ((password.text).contains(' ')) {
                        return "Le mot de passe ne peut contenir d'espace";
                      }
                      return null;
                    },
                    obscureText: !showPassword,
                    decoration: InputDecoration(
                        icon: Icon(Icons.lock),
                        border: InputBorder.none,
                        hintText: "Password",
                        suffixIcon: IconButton(
                          onPressed: () => setState(() {
                            showPassword = !showPassword;
                          }),
                          icon: Icon(showPassword
                              ? Icons.visibility
                              : Icons.visibility_off),
                        )),
                  ),
                ),
                // confirm password
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
                    controller: confirmPassword,
                    // pour verifier si le champ est bien rempli
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Confirmer votre mot de passe";
                      } else if (password.text != confirmPassword.text) {
                        return "Les mots de passe ne correspondent pas";
                      }
                      return null;
                    },
                    obscureText: !showConfirmPassword,
                    decoration: InputDecoration(
                        icon: Icon(Icons.lock),
                        border: InputBorder.none,
                        hintText: "confirm Password",
                        suffixIcon: IconButton(
                          onPressed: () => setState(() {
                            showConfirmPassword = !showConfirmPassword;
                          }),
                          icon: Icon(showConfirmPassword
                              ? Icons.visibility
                              : Icons.visibility_off),
                        )),
                  ),
                ),
                SizedBox(
                  height: hauteurEcran * 0.02,
                ),
                // bouton d'inscription
                Container(
                  width: largeurEcran * 0.9,
                  height: 45,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.teal.shade700),
                  child: TextButton(
                    onPressed: () => setState(
                      () {
                        if (formKey.currentState!.validate()) {
                          //methode d'inscription
                          //signup();
                          // naviguer vers la page de home
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> const Home()));
                        }
                      },
                    ),
                    child: Text(
                      "S'inscrire",
                      style: TextStyle(
                          fontSize: largeurEcran * 0.04, color: Colors.white),
                    ),
                  ),
                ),
                //bouton de connexion

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Vous êtes utilisateur?"),
                    TextButton(
                      child: Text("Se connecter",style: TextStyle(color: Colors.teal.shade700),),
                      onPressed: () => setState(() {
                        // naviguer vers la page de connexion
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> const Login()));
                      }),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                )
              ],
            )),
      ),
    );
  }
}
