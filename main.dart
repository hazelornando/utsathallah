import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyShop Mini - Toko Jersey Bola',
      theme: ThemeData(primarySwatch: Colors.green),
      home: HomeScreen(),
    );
  }
}

// ===================== MODEL =========================

class Category {
  final int id;
  final String name;
  final IconData icon;

  Category({
    required this.id,
    required this.name,
    required this.icon,
  });
}

class Product {
  final int id;
  final int categoryId;
  final String name;
  final int price;
  final String image;

  Product({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.price,
    required this.image,
  });
}

// ===================== SAMPLE DATA =========================

final List<Category> sampleCategories = [
  Category(id: 1, name: 'Premier League', icon: Icons.sports_soccer),
  Category(id: 2, name: 'La Liga', icon: Icons.shield),
  Category(id: 3, name: 'Serie A', icon: Icons.emoji_events),
];

final List<Product> sampleProducts = [
  Product(
      id: 1,
      categoryId: 1,
      name: 'Liverpool Home 24/25',
      price: 250000,
      image: 'assets/ipul.jpg'),
  Product(
      id: 2,
      categoryId: 1,
      name: 'Manchester City Home 24/25',
      price: 270000,
      image: 'assets/siti.jpg'),
  Product(
      id: 3,
      categoryId: 1,
      name: 'Manchester United Home 24/25',
      price: 260000,
      image: 'assets/mu.jpg'),
  Product(
      id: 4,
      categoryId: 2,
      name: 'Barcelona Home 24/25',
      price: 280000,
      image: 'assets/bc.jpg'),
  Product(
      id: 5,
      categoryId: 2,
      name: 'Real Madrid Home 24/25',
      price: 300000,
      image: 'assets/rm.jpg'),
  Product(
      id: 6,
      categoryId: 2,
      name: 'Atletico Madrid Home 24/25',
      price: 260000,
      image: 'assets/atm.jpg'),
  Product(
      id: 7,
      categoryId: 3,
      name: 'Inter Milan Home 24/25',
      price: 270000,
      image: 'assets/inter.png'),
  Product(
      id: 8,
      categoryId: 3,
      name: 'AC Milan Home 24/25',
      price: 260000,
      image: 'assets/milan.jpg'),
  Product(
      id: 9,
      categoryId: 3,
      name: 'Juventus Home 24/25',
      price: 280000,
      image: 'assets/juve.jpg'),
];

String formatRupiah(int amount) {
  return "Rp ${amount.toString().replaceAllMapped(RegExp(r'(\\d)(?=(\\d{3})+(?!\\d))'), (Match m) => '${m[1]}.')}";
}

// ===================== HOME SCREEN =========================

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MyShop Mini - Toko Jersey Bola"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Kategori",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 12),

              // Row 3 kategori
              Row(
                children: sampleCategories.map((cat) {
                  return Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) =>
                                  ProductListScreen(category: cat)),
                        );
                      },
                      child: Card(
                        elevation: 3,
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Column(
                            children: [
                              Icon(cat.icon, size: 36),
                              SizedBox(height: 8),
                              Text(cat.name),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),

              SizedBox(height: 20),
              Text("Produk Unggulan",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),

              Container(
                height: 170,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: sampleProducts.take(6).map((p) {
                      return Container(
                        width: 150,
                        margin: EdgeInsets.only(right: 12),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) =>
                                      ProductDetailScreen(product: p)),
                            );
                          },
                          child: Card(
                            child: Padding(
                              padding: EdgeInsets.all(8),
                              child: Column(
                                children: [
                                  Image.asset(p.image, height: 70),
                                  SizedBox(height: 8),
                                  Text(
                                    p.name,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 5),
                                  Text(formatRupiah(p.price)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// ===================== PRODUCT LIST =========================

class ProductListScreen extends StatelessWidget {
  final Category category;
  ProductListScreen({required this.category});

  @override
  Widget build(BuildContext context) {
    final products = sampleProducts
        .where((p) => p.categoryId == category.id)
        .toList();

    return Scaffold(
      appBar: AppBar(title: Text(category.name)),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(category.name,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 12),

            // Grid produk
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: products.map((prod) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) =>
                                ProductDetailScreen(product: prod)),
                      );
                    },
                    child: Card(
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Column(
                          children: [
                            Image.asset(prod.image, height: 80),
                            SizedBox(height: 8),
                            Text(
                              prod.name,
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 4),
                            Text(formatRupiah(prod.price)),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ===================== DETAIL SCREEN =========================

class ProductDetailScreen extends StatelessWidget {
  final Product product;
  ProductDetailScreen({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.name)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(product.image, height: 200),
            SizedBox(height: 20),
            Text(product.name,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text(formatRupiah(product.price),
                style: TextStyle(fontSize: 22)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Kembali"),
            )
          ],
        ),
      ),
    );
  }
}
