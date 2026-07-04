import 'package:flutter/material.dart';

class OrderHistory extends StatefulWidget {
  const OrderHistory({super.key});

  @override
  State<OrderHistory> createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(7, 40, 37, 1),
      body: ListView.builder(
        itemCount: 9,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: orderWidget(),
          );
        },
      ),
    );
  }

  Widget orderWidget() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(
                  "Order Date",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "26/10/2026",
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              ],
            ),

            Column(
              children: [
                Text(
                  "Order Amount",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "500 \$",
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              ],
            ),
          ],
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(20),
          ),
          child: ExpansionTile(
            initiallyExpanded: true,
            trailing: SizedBox.shrink(),
            title: Row(
              children: [
                Icon(Icons.coffee),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "Order Amount",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "500 \$",
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                    ],
                  ),
                ),

                Text(
                  "500 \$",
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              ],
            ),
            children: [
              SizedBox(
                height: 150,
                child: ListView.builder(
                  itemCount: 4,
                  itemBuilder: (context, index) => detailsRow(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget detailsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          "S",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text("4", style: TextStyle(fontSize: 20, color: Colors.amber)),
        Text(
          "X2",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text("50 \$", style: TextStyle(fontSize: 20, color: Colors.amber)),
      ],
    );
  }
}
