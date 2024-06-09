import 'package:ecommerce_app/pages/cart_page.dart';
import 'package:ecommerce_app/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailsPage extends StatefulWidget {
  final Map<String, Object> product ;
  const ProductDetailsPage({super.key, required this.product});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  int selectedSize = 0;
  void onTap(){
    if (selectedSize != 0){
      Provider.of<CartProvider>(context, listen: false).addProduct({
        'id': widget.product['id'],
        'name': widget.product['name'],
        'price': widget.product['price'],
        'imageUrl': widget.product['imageUrl'],
        'company': widget.product['company'],
        'size': selectedSize,
    },);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Product Added Successfully!'))
    );
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please Select a Size'))
      );
    }
    }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        actions: [IconButton(
          icon: const Icon(Icons.shopping_cart_checkout),
          onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context){
              return  const CartPage();
            }));
          },
        )],
        title: const Center(
          child:  Text("Details", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500))),
      ),
      body: Column(
        children: [
          Text(widget.product["name"] as String, style: Theme.of(context).textTheme.titleLarge,),
          const Spacer(),
          Image.asset(widget.product["imageUrl"] as String),
          const Spacer(flex: 2,),
          Container(
            height: 250,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color.fromRGBO(245, 247, 249, 1),
              borderRadius: BorderRadius.circular(40),
            ),
            child: Column(
              children: [
              Center(child: Text('\$${widget.product["price"]}', style: Theme.of(context).textTheme.titleLarge,)),
              Container(
                height: 50,
                margin: const EdgeInsets.all(10),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: (widget.product["sizes"] as List).length,
                  itemBuilder: (context, index){
                    final size = (widget.product["sizes"] as List)[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: (){
                          setState(() {
                            selectedSize = size;
                          });
                        },
                        child: Chip(
                          label: Text('$size'),
                          backgroundColor: selectedSize == size ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.secondary,
                          ),
                      ),
                    );
                  }),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ElevatedButton.icon(
                  label:const Text('Add to Cart', style: TextStyle(color: Colors.black, fontSize: 18)),
                  onPressed:onTap,
                  icon: const Icon(Icons.shopping_cart, color: Colors.black,),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    minimumSize: const Size(double.infinity, 50)
                ),
                  
              )
            )],),
          )
        ],
      ),
    );
  }
}