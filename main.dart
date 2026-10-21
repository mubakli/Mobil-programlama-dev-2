import 'dart:io';

class Product {
  String name;
  double price;

  Product(this.name, this.price);
}

class ShoppingCart {
  List<Product> products = [];
  double total = 0;

  void addProduct(Product product) {
    products.add(product);
    calculateTotal();
  }

  double calculateTotal() {
    total = 0;
    for (Product product in products) {
      total += product.price;
    }
    return total;
  }
}

void main() {
  stdout.write('Yaşınız: ');
  int age = int.parse(stdin.readLineSync()!);

  stdout.write('Müşteri numaranız: ');
  String customerNumber = stdin.readLineSync()!;

  double totalAmount = 0;
  ShoppingCart cart = ShoppingCart();

  double discountRate;
  if (age < 18) {
    discountRate = 0.10;
  } else if (age <= 60) {
    discountRate = 0.05;
  } else {
    discountRate = 0.15;
  }

  while (true) {
    stdout.write('\nÜrün adı (bitirmek için q): ');
    String? name = stdin.readLineSync();
    if (name == null || name == 'q') {
      break;
    }

    stdout.write('Ürün fiyatı: ');
    double? price = double.tryParse(
      (stdin.readLineSync() ?? '').replaceAll(',', '.'),
    );
    if (name.trim().isEmpty || price == null || !price.isFinite || price < 0) {
      print('Geçerli bir ürün adı ve fiyat giriniz.');
      continue;
    }

    cart.addProduct(Product(name, price));
    totalAmount = cart.calculateTotal();

    print('\nSepetiniz:');
    for (Product product in cart.products) {
      print('- ${product.name}: ${product.price.toStringAsFixed(2)} TL');
    }
    print('Toplam: ${totalAmount.toStringAsFixed(2)} TL');
  }

  double discountedTotal = totalAmount * (1 - discountRate);
  print('\nMüşteri numarası: $customerNumber');
  print('Toplam tutar: ${totalAmount.toStringAsFixed(2)} TL');
  print('İndirim oranı: %${(discountRate * 100).toInt()}');
  print('Ödenecek tutar: ${discountedTotal.toStringAsFixed(2)} TL');
}
