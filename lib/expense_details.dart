import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

final Color activeColor = Color(0xffFF2E63);
final Color inactiveColor = Color(0xff6C73AE);

class ExpenseDetails extends StatefulWidget {
  @override
  _ExpenseDetailsState createState() => _ExpenseDetailsState();
}

class _ExpenseDetailsState extends State<ExpenseDetails> {
  String selection;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff010A43),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width * 0.4,
              decoration: BoxDecoration(
                color: Color(0xff0E164C),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(100),
                ),
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(
                    top: 10,
                    left: 20,
                    right: 20,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "< Back",
                        style: TextStyle(
                          color: activeColor,
                          fontSize: 20,
                        ),
                      ),
                      CircleAvatar(
                        backgroundColor: Color(0xff0E164C),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.asset("assets/images/user.jpg"),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: Swiper(
                    itemBuilder: (ctx, idx) => Card(
                      index: idx,
                    ),
                    curve: Curves.ease,
                    pagination: new SwiperPagination(
                      builder: SwiperPagination.rect,
                    ),
                    itemCount: cardList.length,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(20),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Color(0xff0E164C),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          height: 5,
                          width: 100,
                          color: Colors.white,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Transactions",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  "Sort By",
                                  style: TextStyle(
                                    color: inactiveColor,
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(width: 10),
                                DropdownButton(
                                  value: selection,
                                  hint: Text(
                                    "Choose",
                                    style: TextStyle(
                                      color: activeColor.withOpacity(0.5),
                                      fontSize: 17,
                                    ),
                                  ),
                                  dropdownColor: Color(0xff010A43),
                                  iconEnabledColor: activeColor,
                                  style: TextStyle(
                                    color: activeColor,
                                    fontSize: 17,
                                  ),
                                  items: listItems.map((e) {
                                    return DropdownMenuItem(
                                      value: e,
                                      child: Text(e),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      selection = value;
                                    });
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemBuilder: (ctx, i) => TransactionTile(
                              amount: transactions[i].price,
                              imageUrl: transactions[i].image,
                              name: transactions[i].name,
                              paid: transactions[i].paid,
                            ),
                            itemCount: transactions.length,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class Cards {
  String image;
  String name;
  double amount;
  int cardNumber;

  Cards({this.amount, this.cardNumber, this.image, this.name});
}

List<Cards> cardList = [
  Cards(
    image: "assets/images/card1.png",
    amount: 4500.87,
    cardNumber: 4536,
    name: "Master Card",
  ),
  Cards(
    image: "assets/images/card2.png",
    amount: 532.71,
    cardNumber: 8137,
    name: "Visa Card",
  ),
];

class Card extends StatelessWidget {
  int index;

  Card({this.index});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 20,
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Image.asset(
              cardList[index].image,
              fit: BoxFit.fill,
            ),
          ),
          Container(
            padding: EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cardList[index].name,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.more_horiz,
                      size: 60,
                    ),
                    Text(
                      cardList[index].cardNumber.toString(),
                      style: TextStyle(
                        fontSize: 23,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "\$${cardList[index].amount}",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 30,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

List<String> listItems = ["Recent", "Amount", "Ascending", "Descending"];

class Transaction {
  String image;
  String name;
  bool paid;
  double price;

  Transaction({this.image, this.name, this.paid, this.price});
}

List<Transaction> transactions = [
  Transaction(
    image: "assets/images/friend1.jpg",
    name: "Ayush gupta",
    paid: true,
    price: 750,
  ),
  Transaction(
    image: "assets/images/friend5.png",
    name: "Alena Lopez",
    paid: false,
    price: 50,
  ),
  Transaction(
    image: "assets/images/friend2.jfif",
    name: "Sheldon Cooper",
    paid: false,
    price: 430,
  ),
  Transaction(
    image: "assets/images/friend6.png",
    name: "Mia .......",
    paid: true,
    price: 150,
  ),
  Transaction(
    image: "assets/images/friend3.jfif",
    name: "Bennedict Holmes",
    paid: false,
    price: 72,
  ),
];

class TransactionTile extends StatelessWidget {
  final String imageUrl, name;
  final double amount;
  final bool paid;

  TransactionTile({this.amount, this.imageUrl, this.name, this.paid});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(10),
      leading: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Image.asset(imageUrl),
        ),
      ),
      title: Text(
        name,
        style: TextStyle(
          color: inactiveColor,
          fontSize: 18,
        ),
      ),
      subtitle: Status(
        status: paid,
      ),
      trailing: Text(
        "\$$amount",
        style: TextStyle(
          fontSize: 24,
          color: Colors.white,
        ),
      ),
    );
  }
}

class Status extends StatelessWidget {
  bool status;
  Status({this.status});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 5,
        right: 75,
      ),
      height: 28,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: status ? Colors.red : Colors.teal,
      ),
      child: Row(
        children: [
          SizedBox(width: 3),
          Icon(
            Icons.check_circle,
            color: Colors.white,
          ),
          SizedBox(width: 5),
          Text(
            status ? "Paid" : "Recieved",
            style: TextStyle(
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
