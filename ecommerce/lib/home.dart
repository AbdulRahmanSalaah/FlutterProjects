import 'package:flutter/material.dart';

import 'details.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List categories = [
    {
      "iconname": Icons.laptop,
      "title": "Electronics",
    },
    {
      "iconname": Icons.tv,
      "title": "Appliances",
    },
    {
      "iconname": Icons.phone_android,
      "title": "Mobiles",
    },
    {
      "iconname": Icons.videogame_asset,
      "title": "Gaming",
    },
    {
      "iconname": Icons.card_giftcard,
      "title": "Gifts",
    },
  ];

  List products = [
    {
      "image":
          "https://resource.logitech.com/w_692,c_lpad,ar_4:3,q_auto,f_auto,dpr_1.0/d_transparent.gif/content/dam/logitech/en/products/headsets/zone-900/gallery/logitech-zone-900-gallery-1.png?v=1",
      "name": "Logitech ZONE 900",
      'subtitle': 'Wireless Headphones',
      "price": "\$350",
    },
    {
      "image":
          "https://www.themodestman.com/wp-content/uploads/2020/02/Fitbit-Inspire-3-Smartwatch.jpg",
      "name": "Xiaomi mi Band 6",
      'subtitle': 'Smart Watch',
      "price": "\$100",
    },
    {
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRLstgpi72P-Lc-DF-nOed2OYzWScNXsNwcjw&s",
      "name": "Iphone 15 Pro Max",
      'subtitle': 'Smartphone',
      "price": "\$1500",
    },
    {
      "image": "https://m.media-amazon.com/images/I/71uAzbHt-hL._AC_SX625_.jpg",
      "name": "Mintra Men's Cai Slip On Shoes",
      'subtitle': 'Casual Shoes',
      "price": "\$100",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 30,
        selectedItemColor: Colors.orange,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: '*',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outlined),
            label: 'Profile',
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(25.0),
        child: ListView(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Search',
                      border: InputBorder.none,
                      fillColor: Colors.grey[200],
                      filled: true,
                      prefixIcon: const Icon(Icons.search),
                    ),
                  ),
                ),
                // ignore: prefer_const_constructors
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: const Icon(
                    Icons.menu,
                    size: 35,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            const Text(
              'Categories',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 150,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (BuildContext context, int i) {
                  return Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(100),
                        ),
                        padding: const EdgeInsets.all(15),
                        child: Icon(categories[i]['iconname'], size: 40),
                      ),
                      Text(
                        categories[i]['title'],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            const Text(
              'Best Selling ',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.6,
              ),
              itemCount: products.length,
              itemBuilder: (BuildContext context, int i) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ItemDetails(
                              data: products[i],
                            )));
                    // Pass the product
                  },
                  child: Card(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start, // Align content to start

                      children: [
                        Container(
                            color: Colors.grey[200],
                            height: 150,
                            width: double.infinity,
                            child: Image.network(
                              products[i]['image'],
                              fit: BoxFit.fill,
                            )),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          products[i]['name'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          products[i]['subtitle'],
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          products[i]['price'],
                          style: const TextStyle(
                            color: Colors.orange,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
