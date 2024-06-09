import 'package:ecommerce_app/providers/cart_provider.dart'; // Added import
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>().cart;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Your Cart'),
      ),
      body:cart.isNotEmpty ? ListView.builder(
        itemCount: cart.length, // Changed to use cart from CartProvider
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: Image.asset(cart[index]["imageUrl"] as String),
              title: Text(cart[index]["name"] as String, style: Theme.of(context).textTheme.bodyLarge,),
              subtitle: Text('Size : ${cart[index]["size"] as int}  Price: ${cart[index]["price"] as double}'),
              tileColor: (cart[index]["id"]as int).isEven ? const Color.fromARGB(255, 182, 243, 243) : Theme.of(context).colorScheme.secondary, // Replace with actual size if available
              trailing: IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                     builder: (context) {
                       return AlertDialog(
                        title: Text("Delete Product",style: Theme.of(context).textTheme.titleMedium,),
                        content: const Text("Are you sure you want to delete this Item from the Cart?"),
                        actions: [
                          TextButton(
                            onPressed: (){
                              Navigator.of(context).pop();
                            },
                             child: const Text(
                              "No",
                              style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                             ), ),
                          TextButton(
                            onPressed: (){
                              context.read<CartProvider>().removeProduct(cart[index]);
                              Navigator.of(context).pop();

                            },
                             child:const Text("Yes", 
                             style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),))
                        ],
                       );
                     },);
                },
                icon:  const Icon(Icons.delete, color: Colors.red,),
                
              ),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20), side: const BorderSide(color:Colors.black)),
              style: ListTileStyle.list,

            ),
          );
        },
      ) : const Center(child: Text("Your cart is Empty,\nFill it up!", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),) ,
    );
  }
}
