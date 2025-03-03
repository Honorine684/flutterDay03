import 'package:ahigan/dafaults/defaults.dart';
import 'package:flutter/material.dart';

class Produit extends StatefulWidget {
  const Produit({super.key});

  @override
  State<Produit> createState() => _ProduitState();

}
var indexClicked=0;
var indexClickedPade=0;



class _ProduitState extends State<Produit>  {
  

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      padding: EdgeInsets.all(17),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Produits',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(width: 160),
              Container(
                height: 35,
                width: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.transparent,
                ),
                child: Center(
                  child: Text(
                    'Ajouter',
                    style: TextStyle(
                      color:
                          indexClicked == 0
                              ? Defaults.drawerItemSelectedColor
                              : Defaults.inactivetext,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             SizedBox(width: 1,),
              Center(child: Container(
                height: 40,
                width: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8), border: Border.all(color: Color(0xFF9fd5cd)),
                  color: Colors.white,
                ),

                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                    setState(() {
                      indexClicked=0;
                    
                    });
            

                    },
                      child: Container(
                      height: 30,
                      width: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color:
                            indexClicked == 0
                                ? Defaults.selectbuton
                                : Defaults.ianctivebuton,
                      ),

                      child: Center(
                        child: Text(
                          'Tout',
                          style: TextStyle(
                            color:
                                indexClicked == 0
                                    ? Defaults.drawerItemSelectedColor
                                    : Defaults.inactivetext,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    ),
                    GestureDetector(
                      onTap: () {
                    setState(() {
                      indexClicked=1;
                    
                    });
          

                    },
                      child: Container(
                      height: 30,
                      width: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color:
                            indexClicked == 1
                                ? Defaults.selectbuton
                                : Defaults.ianctivebuton,
                      ),

                      child: Center(
                        child: Text(
                          'Publier',
                          style: TextStyle(
                            color:
                                indexClicked == 1
                                    ? Defaults.drawerItemSelectedColor
                                    : Defaults.inactivetext,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    ),
                    GestureDetector(
                      onTap: () {
                    setState(() {
                      indexClicked=2;
                    
                    });
          

                    },
                      child: Container(
                      height: 30,
                      width: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color:
                            indexClicked == 2
                                ? Defaults.selectbuton
                                : Defaults.ianctivebuton,
                      ),
                      child: Center(
                        child: Text(
                          'Attente',
                          style: TextStyle(
                            color:
                                indexClicked == 2
                                    ? Defaults.drawerItemSelectedColor
                                    : Defaults.inactivetext,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    )
                  ],
                ),
              ),
              )
            ],
          ),


          SizedBox(height: 20,),

          Row(
            children: [
              Container(
                height: 50,
                width: 320,
                
                decoration: BoxDecoration(border: Border.all(color: Color(0xFF9fd5cd)),color: Colors.white, ),
                child: Row(
                  children: [
                  Text('Produit',style: TextStyle(fontWeight: FontWeight.bold),),
                  SizedBox(width: 30,),
                  Text('Catégorie',style: TextStyle(fontWeight: FontWeight.bold),),
                  SizedBox(width: 20,),
                  Text('Prix',style: TextStyle(fontWeight: FontWeight.bold),),
                  SizedBox(width: 17,),
                  Text('Statut',style: TextStyle(fontWeight: FontWeight.bold),),
                  SizedBox(width: 30,),
                  Text('Action',style: TextStyle(fontWeight: FontWeight.bold),),
                  
                  
                  
                  ],
                ),


              )
            ],


          ),


          Row(
            children: [
              Container(
                height: 50,
                width: 320,
                
                decoration: BoxDecoration(color: const Color.fromARGB(153, 255, 255, 255), ),
                child: Row(
                  children: [
                  Text('Tomate'),
                  SizedBox(width: 35,),
                  Text('Fruit'),
                  SizedBox(width: 53,),
                  Text('\$3'),
                  SizedBox(width: 22,),
                  Text('Publier'),
                  SizedBox(width: 10,),
                  Icon(Icons.mode_edit,size: 20,),
                  Icon(Icons.delete, size: 20,),
                  Icon(Icons.visibility,size: 20,),
                  
                  ],
                ),
                


              )
            ],


          ),
          Row(
            children: [
              Container(
                height: 50,
                width: 320,
                
                decoration: BoxDecoration(color: Colors.white ),
                child: Row(
                  children: [
                  Text('Piment'),
                  SizedBox(width: 35,),
                  Text('Fruit'),
                  SizedBox(width: 53,),
                  Text('\$3'),
                  SizedBox(width: 22,),
                  Text('Attente'),
                  SizedBox(width: 10,),
                  Icon(Icons.mode_edit,size: 20,),
                  Icon(Icons.delete, size: 20,),
                  Icon(Icons.visibility,size: 20,),
                  
                  ],
                ),
                


              )
            ],


          ),
          Row(
            children: [
              Container(
                height: 50,
                width: 320,
                
                decoration: BoxDecoration(color: const Color.fromARGB(153, 255, 255, 255), ),
                child: Row(
                  children: [
                  Text('Oignon'),
                  SizedBox(width: 35,),
                  Text('Fruit'),
                  SizedBox(width: 53,),
                  Text('\$3'),
                  SizedBox(width: 22,),
                  Text('Publier'),
                  SizedBox(width: 10,),
                  Icon(Icons.mode_edit,size: 20,),
                  Icon(Icons.delete, size: 20,),
                  Icon(Icons.visibility,size: 20,),
                  
                  ],
                ),
                


              )
            ],


          ),
          Row(
            children: [
              Container(
                height: 50,
                width: 320,
                
                decoration: BoxDecoration(color: Colors.white, ),
                child: Row(
                  children: [
                  Text('Carotte'),
                  SizedBox(width: 35,),
                  Text('Fruit'),
                  SizedBox(width: 53,),
                  Text('\$3'),
                  SizedBox(width: 22,),
                  Text('Publier'),
                  SizedBox(width: 10,),
                  Icon(Icons.mode_edit,size: 20,),
                  Icon(Icons.delete, size: 20,),
                  Icon(Icons.visibility,size: 20,),
                  
                  ],
                ),
                


              )
            ],


          ),
          Row(
            children: [
              Container(
                height: 50,
                width: 320,
                
                decoration: BoxDecoration(color: const Color.fromARGB(153, 255, 255, 255), ),
                child: Row(
                  children: [
                  Text('Orange'),
                  SizedBox(width: 35,),
                  Text('Fruit'),
                  SizedBox(width: 53,),
                  Text('\$3'),
                  SizedBox(width: 22,),
                  Text('Publier'),
                  SizedBox(width: 10,),
                  Icon(Icons.mode_edit,size: 20,),
                  Icon(Icons.delete, size: 20,),
                  Icon(Icons.visibility,size: 20,),
                  
                  ],
                ),
                


              )
            ],


          ),
          Row(
            children: [
              Container(
                height: 50,
                width: 320,
                
                decoration: BoxDecoration(color: Colors.white ),
                child: Row(
                  children: [
                  Text('Tomate'),
                  SizedBox(width: 35,),
                  Text('Fruit'),
                  SizedBox(width: 53,),
                  Text('\$3'),
                  SizedBox(width: 22,),
                  Text('Publier'),
                  SizedBox(width: 10,),
                  Icon(Icons.mode_edit,size: 20,),
                  Icon(Icons.delete, size: 20,),
                  Icon(Icons.visibility,size: 20,),
                  
                  ],
                ),
                


              )
            ],


          ),
          Row(
            children: [
              Container(
                height: 50,
                width: 320,
                
                decoration: BoxDecoration(color: const Color.fromARGB(153, 255, 255, 255), ),
                child: Row(
                  children: [
                  Text('Tomate'),
                  SizedBox(width: 35,),
                  Text('Fruit'),
                  SizedBox(width: 53,),
                  Text('\$3'),
                  SizedBox(width: 22,),
                  Text('Publier'),
                  SizedBox(width: 10,),
                  Icon(Icons.mode_edit,size: 20,),
                  Icon(Icons.delete, size: 20,),
                  Icon(Icons.visibility,size: 20,),
                  
                  ],
                ),
                


              )
            ],


          ),
          Row(
            children: [
              Container(
                height: 50,
                width: 320,
                
                decoration: BoxDecoration(color: Colors.white ),
                child: Row(
                  children: [
                  Text('Tomate'),
                  SizedBox(width: 35,),
                  Text('Fruit'),
                  SizedBox(width: 53,),
                  Text('\$3'),
                  SizedBox(width: 22,),
                  Text('Publier'),
                  SizedBox(width: 10,),
                  Icon(Icons.mode_edit,size: 20,),
                  Icon(Icons.delete, size: 20,),
                  Icon(Icons.visibility,size: 20,),
                  
                  ],
                ),
                


              )
            ],


          ),

          SizedBox(height: 13),
          Row(
            
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 30,),
              Center(
                child: Container(
                
                height: 30,
                width: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8), border: Border.all(color: Color(0xFF9fd5cd)),
                  color: Colors.white,
                ),

                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                    setState(() {
                      indexClickedPade=0;
                    
                    });
            

                    },
                      child: Container(
                      height: 20,
                      width: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color:
                            indexClickedPade == 0
                                ? Defaults.selectbuton
                                : Defaults.ianctivebuton,
                      ),

                      child: Center(
                        child: Text(
                          '1',
                          style: TextStyle(
                            color:
                                indexClickedPade == 0
                                    ? Defaults.drawerItemSelectedColor
                                    : Defaults.inactivetext,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    ),
                    GestureDetector(
                      onTap: () {
                    setState(() {
                      indexClickedPade=1;
                    
                    });
          

                    },
                      child: Container(
                      height: 20,
                      width: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color:
                            indexClickedPade == 1
                                ? Defaults.selectbuton
                                : Defaults.ianctivebuton,
                      ),

                      child: Center(
                        child: Text(
                          '2',
                          style: TextStyle(
                            color:
                                indexClickedPade == 1
                                    ? Defaults.drawerItemSelectedColor
                                    : Defaults.inactivetext,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    ),
                    GestureDetector(
                      onTap: () {
                    setState(() {
                      indexClickedPade=2;
                    
                    });
          

                    },
                      child: Container(
                      height: 20,
                      width: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color:
                            indexClickedPade == 2
                                ? Defaults.selectbuton
                                : Defaults.ianctivebuton,
                      ),
                      child: Center(
                        child: Text(
                          '3',
                          style: TextStyle(
                            color:
                                indexClickedPade == 2
                                    ? Defaults.drawerItemSelectedColor
                                    : Defaults.inactivetext,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    )
                  ],
                ),
              ),
              )
            ],
          ),

          
        
      
          
      

      ]
              ),
              

          
    );
    
  }
}

