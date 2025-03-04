/*import 'package:flutter/material.dart';
import 'package:vassanou/Authentification/Login.dart';
import 'package:vassanou/Component/Bottombar.dart';
import 'package:vassanou/JsonModel/CategorieCommerce.dart';
import 'package:vassanou/JsonModel/Stand.dart';
import 'package:vassanou/Services/firebase/Auth.dart';
import 'package:vassanou/Services/firebase/FirestoreServices.dart';

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
  final otp = TextEditingController();
  bool showPassword = false;
  bool showConfirmPassword = false;
  bool isPhoneNumber = false;
  final formKey = GlobalKey<FormState>();
  int signCurrentStep = 0;

  @override
  void initState() {
    super.initState();
    loadCategories();
    
  }

  List<Categoriecommerce> categorieCommerce = [];
  Categoriecommerce? selectedCategory;
  String? selectedCategoryId;
  void loadCategories() {
    print("Démarrage du chargement des catégories...");
    Firestoreservices().getCategorieCommerce().listen((snapshot) {
      print("Données reçues: ${snapshot.docs.length} documents");
      List<Categoriecommerce> categories = [];

      for (var doc in snapshot.docs) {
        try {
          String categoryName = doc.get('libcat');
          String categoryId = doc.id; 

          print("Catégorie trouvée: $categoryName (ID: $categoryId)");
          categories
              .add(Categoriecommerce(id: categoryId, libelle: categoryName));
        } catch (e) {
          print("Erreur sur un document: $e");
        }
      }

      setState(() {
        categorieCommerce = categories;
        print("Catégories chargées: ${categories.length}");
        if (categories.isNotEmpty && selectedCategory == null) {
          selectedCategory = categories[0];
          print("Catégorie par défaut: ${selectedCategory?.libelle}");
        }
      });
    }, onError: (error) {
      print("Erreur lors du chargement des catégories: $error");
    });
  }

  List<Stand> standList = [];
  Stand? selectedStand;
  Future<void>loadStand(String idCat) async{
    print("Démarrage du chargement des stands...");
    Firestoreservices().getStandsWithCategorie().listen((snapshot) {
      print("Données reçues: ${snapshot.docs.length} documents");
      List<Stand> stands = [];

      for (var doc in snapshot.docs) {
        if(doc.get("categorieId") == idCat){
          try {
          String standId = doc.id;
          String categorieId = doc.get('categorieId');
          String emplacement = doc.get('emplacement');
          String superficie = doc.get('superficie');
          String numeroStand = doc.get('numeroStand');
          String disponibilite = doc.get('disponibilite');

          print("Stand trouvée: $numeroStand (ID: $standId)");
          stands.add(Stand(
              id: standId,
              categorieId: categorieId,
              emplacement: emplacement,
              superficie: superficie,
              numeroStand: numeroStand,
              disponibilite: disponibilite));
        } catch (e) {
          print("Erreur sur un document: $e");
        }
        }
      }

      setState(() {
        standList = stands;
        print("stands chargées: ${stands.length}");
        if (stands.isNotEmpty && selectedStand == null) {
          selectedStand = stands[0];
          print("stand par défaut: ${selectedStand?.numeroStand}");
        }
      });
    }, onError: (error) {
      print("Erreur lors du chargement des stands: $error");
    });
  }

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

  // verifier si chaque etape est bien rempli
  bool validatesignStep() {
    switch (signCurrentStep) {
      case 0:
        // Validation des informations personnelles
        if (name.text.isEmpty) return false;
        if (emailOrPhone.text.isEmpty) return false;
        if (validateEmailOrPhone(emailOrPhone.text) != null) return false;
        if (password.text.isEmpty || password.text.length < 6) return false;
        if (password.text != confirmPassword.text) return false;
        return true;
      case 1:
        // Validation de la catégorie
        return selectedCategory != null;
      case 2:
        // Validation du stand
        return selectedStand != null;
      case 3:
        // Rien à valider pour la confirmation
        return true;
      default:
        return false;
    }
  }

  // Méthode pour soumettre le formulaire
  void submitForm() {
    // Logique d'inscription
    Auth().createUserWithEmailAndPassword(
      name: name.text,
      email: emailOrPhone.text,
      phoneNumber: emailOrPhone.text,
      password: password.text,
      categorieId: selectedCategory!.id,
      categorieLibelle: selectedCategory!.libelle,
      pseudo: pseudo.text,
      standId: selectedStand!.id,
      numeroStand: selectedStand!.numeroStand,
      //password.text,
    );
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const AnimatedBarExample()),
    );
  }

  // Méthode pour passer à l'étape suivante
  void nextStep() {
    if (validatesignStep()) {
      setState(() {
        if (signCurrentStep < 3) {
          signCurrentStep++;
        } else {
          submitForm();
        }
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Veuillez remplir correctement tous les champs"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

// si on es a une etape autre que la premiere ramene moi sur les precedentes
  void previousStep() {
    setState(() {
      if (signCurrentStep > 0) {
        signCurrentStep--;
      }
    });
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
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            SizedBox(height: hauteurEcran * 0.05),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "S'inscrire",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                Image.asset(
                  "assets/images/sign.jpg",
                  width: largeurEcran * 0.3,
                  height: hauteurEcran * 0.15,
                )
              ],
            ),

            Stepper(
              type: StepperType.vertical,
              currentStep: signCurrentStep,
              onStepTapped: (step) {
                // permettre la navigation uniquement vers une étape précédente
                if (step < signCurrentStep) {
                  setState(() {
                    signCurrentStep = step;
                  });
                }
              },
              controlsBuilder: (context, details) {
                return Row(
                  children: [
                    if (signCurrentStep > 0)
                      ElevatedButton(
                        onPressed: previousStep,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey,
                        ),
                        child: const Text("Précédent",style: TextStyle(color: Colors.white),),
                      ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: nextStep,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal.shade700,
                      ),
                      child: Text(
                        signCurrentStep < 3 ? "Suivant" : "Confirmer",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                );
              },
              steps: [
                // Étape 1: Informations personnelles
                Step(
                  title: const Text("Informations personnelles"),
                  content: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        // Nom complet
                        Container(
                          margin: const EdgeInsets.all(8),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 6),
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
                            decoration: const InputDecoration(
                              icon: Icon(Icons.person),
                              border: InputBorder.none,
                              hintText: "Nom complet",
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Le nom complet est obligatoire";
                              }
                              return null;
                            },
                          ),
                        ),

                        // Email ou téléphone
                        Container(
                          margin: const EdgeInsets.all(8),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 6),
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
                                  margin: const EdgeInsets.all(8),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 6),
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
                                    icon: Icon(isPhoneNumber
                                        ? Icons.phone
                                        : Icons.email),
                                    border: InputBorder.none,
                                    hintText: "Email ou Phone",
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
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.teal.shade700,
                                  width: 2.0,
                                ),
                              ),
                            ),
                            child: TextFormField(
                              controller: otp,
                              keyboardType: TextInputType.number,
                              maxLength: 6,
                              decoration: const InputDecoration(
                                icon: Icon(Icons.sms),
                                border: InputBorder.none,
                                hintText: "Code de vérification",
                              ),
                            ),
                          ),

                        // Mot de passe
                        Container(
                          margin: const EdgeInsets.all(8),
                          padding: const EdgeInsets.symmetric(horizontal: 10),
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
                              if (value!.isEmpty) {
                                return "Mot de passe obligatoire";
                              } else if ((password.text).length < 6) {
                                return "Le mot de passe doit contenir plus de 6 caractères";
                              } else if (!RegExp(r'[a-zA-Z]')
                                  .hasMatch(password.text)) {
                                return "Le mot de passe doit contenir des lettres";
                              } else if (!RegExp(r'\d')
                                  .hasMatch(password.text)) {
                                return "Le mot de passe doit contenir des nombres";
                              } else if ((password.text).contains(' ')) {
                                return "Le mot de passe ne peut contenir d'espace";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              icon: const Icon(Icons.lock),
                              border: InputBorder.none,
                              hintText: "Password",
                              suffixIcon: IconButton(
                                onPressed: () => setState(() {
                                  showPassword = !showPassword;
                                }),
                                icon: Icon(showPassword
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                              ),
                            ),
                          ),
                        ),

                        // Confirmation du mot de passe
                        Container(
                          margin: const EdgeInsets.all(8),
                          padding: const EdgeInsets.symmetric(horizontal: 10),
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
                            obscureText: !showConfirmPassword,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Confirm password";
                              } else if (password.text !=
                                  confirmPassword.text) {
                                return "Les mots de passe ne correspondent pas";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              icon: const Icon(Icons.lock),
                              border: InputBorder.none,
                              hintText: "Confirm password",
                              suffixIcon: IconButton(
                                onPressed: () => setState(() {
                                  showConfirmPassword = !showConfirmPassword;
                                }),
                                icon: Icon(showConfirmPassword
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                  isActive: signCurrentStep >= 0,
                  state: signCurrentStep > 0
                      ? StepState.complete
                      : StepState.indexed,
                ),
                // Étape 2: Sélection de la catégorie
                Step(
                  title: const Text("Catégorie de commerce"),
                  content: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(8),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.teal.shade700,
                              width: 2.0,
                            ),
                          ),
                        ),
                        child: DropdownButtonFormField<Categoriecommerce>(
                          decoration: const InputDecoration(
                            icon: Icon(Icons.store),
                            border: InputBorder.none,
                            hintText: "Sélectionnez une categorie",
                          ),
                          value: selectedCategory,
                          isExpanded: true,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          items: categorieCommerce.map((categorie) {
                            return DropdownMenuItem<Categoriecommerce>(
                              value: categorie,
                              child: Text(categorie.libelle),
                            );
                          }).toList(),
                          onChanged: (Categoriecommerce? newValue) async{
                            setState(() {
                              selectedCategory = newValue;
                              selectedCategoryId = selectedCategory!.id;
                              
                            });
                            print("loading stand .........");
                            await loadStand(selectedCategoryId!);
                            print("end stand loading.........");
                          },
                        ),
                      ),

                      // Champ pour le pseudo
                      Container(
                        margin: const EdgeInsets.all(8),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6),
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
                          decoration: const InputDecoration(
                            icon: Icon(Icons.near_me),
                            border: InputBorder.none,
                            hintText: "Pseudo (optionnel)",
                          ),
                        ),
                      ),
                    ],
                  ),
                  isActive: signCurrentStep >= 1,
                  state: signCurrentStep > 1
                      ? StepState.complete
                      : signCurrentStep == 1
                          ? StepState.editing
                          : StepState.indexed,
                ),
                // Étape 3: Sélection du stand
                Step(
                  title: const Text("Sélection du stand"),
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Stands disponibles dans la catégorie ${selectedCategory?.libelle}:",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        margin: const EdgeInsets.all(8),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.teal.shade700,
                              width: 2.0,
                            ),
                          ),
                        ),
                        child: DropdownButtonFormField<Stand>(
                          decoration: const InputDecoration(
                            icon: Icon(Icons.store),
                            border: InputBorder.none,
                            hintText: "Sélectionnez un stand",
                          ),
                          value: selectedStand,
                          isExpanded: true,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          items: standList.map((stand) {
                            return DropdownMenuItem<Stand>(
                              value: stand,
                              child: Text(stand.numeroStand),
                            );
                          }).toList(),
                          onChanged: (Stand? newValue) {
                            setState(() {
                              selectedStand = newValue;
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 15),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Informations sur le stand: ${selectedStand?.numeroStand}",
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 5),
                            Text(
                                "• Emplacement: ${selectedStand?.emplacement}"),
                            Text("• Superficie: ${selectedStand?.superficie}"),
                            Text(
                                "• Disponibilité: ${selectedStand?.disponibilite}"),
                          ],
                        ),
                      )
                    ],
                  ),
                  isActive: signCurrentStep >= 2,
                  state: signCurrentStep > 2
                      ? StepState.complete
                      : signCurrentStep == 2
                          ? StepState.editing
                          : StepState.indexed,
                ),

                // Étape 4: Confirmation
                Step(
                  title: const Text("Confirmation"),
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Récapitulatif de votre inscription",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Column(
                          children: [
                            _buildInfoRow("Nom complet", name.text),
                            _buildInfoRow(
                                "Contact",
                                isPhoneNumber
                                    ? "+229 ${emailOrPhone.text}"
                                    : emailOrPhone.text),
                            if (pseudo.text.isNotEmpty)
                              _buildInfoRow("Pseudo", pseudo.text),
                            _buildInfoRow(
                                "Catégorie",
                                selectedCategory?.libelle ??
                                    "Aucune catégorie"),
                            _buildInfoRow("Stand",
                                selectedStand?.numeroStand ?? "Aucun stand"),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "En cliquant sur Confirmer, vous acceptez nos conditions d'utilisation et notre politique de confidentialité.",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  isActive: signCurrentStep >= 3,
                  state: signCurrentStep == 3
                      ? StepState.editing
                      : StepState.indexed,
                ),
              ],
            ),

            // Lien pour se connecter
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Vous êtes déjà utilisateur?"),
                TextButton(
                  child: Text(
                    "Se connecter",
                    style: TextStyle(color: Colors.teal.shade700),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Login()),
                    );
                  },
                )
              ],
            ),
            const SizedBox(height: 100)
          ],
        ),
      ),
    );
  }
}

// Widget pour afficher une ligne d'information
Widget _buildInfoRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120,
          child: Text(
            "$label:",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: Text(value),
        ),
      ],
    ),
  );
}*/
