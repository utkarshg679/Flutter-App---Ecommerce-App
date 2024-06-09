import 'package:ecommerce_app/global_variables.dart';
import 'package:ecommerce_app/widgets/product_card.dart';
import 'package:ecommerce_app/pages/product_details_page.dart';
import 'package:flutter/material.dart';

class ProductList extends StatefulWidget {

  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final List<String> filters = const ["All", "Adibas", "Nickey", "Pumba","Goldstar"];
  late String selectedFilter ;

  @override
  void initState(){
    super.initState();
    selectedFilter = filters[0];
  }
  @override
  Widget build(BuildContext context) {
    const  border =  OutlineInputBorder( borderRadius: BorderRadius.only(topLeft: Radius.circular(100), bottomLeft: Radius.circular(100)));

    return SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                                "Shoes\nCollection",
                                style: Theme.of(context).textTheme.titleLarge
                                ),
                ),
              const Expanded(
                child: TextField(
                  decoration: InputDecoration(prefixIcon: Icon(Icons.search),hintText: 'Search',border:border, enabledBorder: border),  
                ),
              ),
              
              ],
            ),

            SizedBox(
              height:120,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: filters.length,
                  itemBuilder: (context, index){
                    final filter = filters[index];
                    return Container(
                      margin: const EdgeInsets.only(left: 2),
                      padding:const  EdgeInsets.all(10),
                      child: GestureDetector(
                        onTap: (){
                          setState(() {
                            selectedFilter = filter;
                          });
                        },
                        child: Chip(
                          label: Text(filter, style: const TextStyle(fontWeight: FontWeight.bold),),
                          labelStyle: const TextStyle(fontSize: 16),
                          backgroundColor: selectedFilter == filter?Theme.of(context).colorScheme.primary :Colors.grey.shade200,
                          padding:const  EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30) ),
                          side: const BorderSide(color: Colors.white70),
                          ),
                      ),
                    );
                  },
                  ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index){
                  final product = products[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context){
                        return ProductDetailsPage(product: product);
                      }));
                    },
                    child: (selectedFilter== "All" || selectedFilter==product["company"])  ? ProductCard(
                      imageUrl: product["imageUrl"] as String, 
                      name: product["name"] as String, 
                      price: product["price"] as double, 
                      backgroundColor: index.isEven ? const Color.fromARGB(255, 182, 243, 243) : Theme.of(context).colorScheme.secondary,
                      ) : const SizedBox(),
                  );
                }),
            ),
            
            ],
            ),
      );
  }
}