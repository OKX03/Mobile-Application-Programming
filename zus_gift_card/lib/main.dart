import 'package:flutter/material.dart';

void main() => runApp(ZusGiftCardApp());

class ZusGiftCardApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey[200], 
        fontFamily: 'Roboto', // Optional: set consistent font
      ),
      title: 'ZUS Balance Gift Card',
      home: GiftCardHomePage(),
    );
  }
}

class GiftCardHomePage extends StatefulWidget {
  @override
  _GiftCardHomePageState createState() => _GiftCardHomePageState();
}

class _GiftCardHomePageState extends State<GiftCardHomePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'ZUS Balance Gift Card',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF003366),
          ),
        ),
        bottom: TabBar(
          labelColor: Color(0xFF003366), // Selected tab color
          unselectedLabelColor: Colors.grey, // Unselected tab color
          labelStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: 16,
          ),
          indicator: UnderlineTabIndicator(
            borderSide: BorderSide(width: 3.0, color: Color(0xFF003366)), // Deep blue underline
            insets: EdgeInsets.symmetric(horizontal: 0), // Full-width underline
          ),
          indicatorSize: TabBarIndicatorSize.tab,
          controller: _tabController,
          tabs: [
            Tab(text: 'Send a Gift Card'),
            Tab(text: 'Redeem'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [

          SendGiftCardPage(),
          RedeemGiftCardPage(),
        ],
      ),
    );
  }
}

class SendGiftCardPage extends StatefulWidget {
  @override
  _SendGiftCardPageState createState() => _SendGiftCardPageState();
}

const String send_via_phone = 'phone';
const String send_via_email = 'email';

class _SendGiftCardPageState extends State<SendGiftCardPage> {
  int selectedCardIndex = 1; // Default selected card image index

  final TextEditingController _amountController = TextEditingController();
  String formattedAmount = '0.00';
  String? amountError;

  void _onAmountChanged(String value) {
    String digitsOnly = value.replaceAll(RegExp(r'[^0-9]'), '');

    if (digitsOnly.isEmpty) {
      setState(() {
        formattedAmount = '0.00';
      });
      return;
    }

    int number = int.parse(digitsOnly);
    String formatted = (number).toStringAsFixed(2);

    setState(() {
      formattedAmount = formatted;
    });
  }

  void _validateAmount() {
    if (formattedAmount == '0.00') {
      setState(() {
        amountError = 'Please enter an amount.';
      });
    } else {
      setState(() {
        amountError = null;
      });
      // Proceed to checkout
    }
  }

  String sender = 'OH KAI XUAN';
  late TextEditingController senderController;

  @override
  void initState() {
    super.initState();
    senderController = TextEditingController(text: sender);
  }

  @override
  void dispose() {
    senderController.dispose();
    super.dispose();
  }



  String _selectedMethod = send_via_phone;
  bool isPhoneSelected() => _selectedMethod == send_via_phone;
  final TextEditingController recipientNameController = TextEditingController();
  final TextEditingController recipientPhoneController = TextEditingController();
  final TextEditingController recipientEmailController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      //wrap the whole image section into a container with white backgrounf
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 10.0),
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    'images/card_$selectedCardIndex.jpg',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 180,
                  ),
                ),
                SizedBox(height: 12),
                SizedBox(
                  height: 60,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: List.generate(4, (index) {
                      final isSelected = index == selectedCardIndex;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedCardIndex = index;
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 4),
                          padding: EdgeInsets.all(isSelected ? 2 : 0),
                          decoration: BoxDecoration(
                            border: isSelected
                                ? Border.all(color: Colors.blueAccent, width: 2)
                                : null,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              'images/card_$index.jpg',
                              width: 80,
                              height: 40,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
          
          Container(
            margin: EdgeInsets.only(top: 10.0),
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Gift Amount',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF003366),
                  ),
                ),
                Text(
                  'Enter the whole amount between RM10 and RM300',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF003366),
                  ),
                ),
                SizedBox(height: 8),
                Stack(
                  children: [
                    TextField(
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                      onChanged: _onAmountChanged,
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.transparent, // Hide real input
                      ),
                      cursorColor: Color(0xFF003366),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 40, top: 30),
                        errorText: amountError,
                      ),
                    ),
                    // Always-visible "RM" on top-left
                    Positioned(
                      left: 12,
                      top: 12,
                      child: Text(
                        'RM',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF003366),
                        ),
                      ),
                    ),
                    // The visible, formatted amount text (e.g., "123.00")
                    Positioned.fill(
                      child: IgnorePointer(
                        child: Padding(
                          padding: EdgeInsets.only(left: 40, top: 12),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              formattedAmount,
                              style: TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF003366),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Text(
                  "Sender's name",
                   style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF003366),
                  ),
                ),
                TextField(
                  controller: senderController,
                  decoration: InputDecoration(
                    isCollapsed: true,
                    contentPadding: EdgeInsets.only(bottom: 8),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF003366)),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF003366), width: 2),
                    ),
                  ),
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF003366),
                  ),
                ),
                SizedBox(height: 16),
                Text("Send Via"),
Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    SizedBox(
      width: (MediaQuery.of(context).size.width - 48) * 0.45,
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            _selectedMethod = send_via_phone;
          });
        },
        child: Text(
          "Phone Number",
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFF003366),
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: _selectedMethod == send_via_phone ? Colors.grey[50] : Colors.white,
          side: BorderSide(
            color: _selectedMethod == send_via_phone ? Color(0xFF003366) : Colors.grey,
            width: 2,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    ),
    SizedBox(width: (MediaQuery.of(context).size.width - 48) * 0.05), // Spacer
    SizedBox(
      width: (MediaQuery.of(context).size.width - 48) * 0.45,
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            _selectedMethod = send_via_email;
          });
        },
        child: Text("Email"),
        style: ElevatedButton.styleFrom(
          backgroundColor: _selectedMethod == send_via_email ? Colors.grey : Colors.white,
          side: BorderSide(
            color: _selectedMethod == send_via_email ? Color(0xFF003366) : Colors.grey,
            width: 2,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    ),
  ],
),


                SizedBox(height: 16),
                Text("Recipient's Name"),
                TextField(
                  controller: recipientNameController,
                ),
                SizedBox(height: 16),

                if (_selectedMethod == send_via_phone) ...[
                  Text("Recipient's Phone Number"),
                  TextField(
                    controller: recipientPhoneController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(prefixText: '+60 '),
                  ),
                ] else ...[
                  Text("Recipient's Email"),
                  TextField(
                    controller: recipientEmailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(hintText: 'example@email.com'),
                  ),
                ],
                SizedBox(height: 16),
                Text("Add Message"),
                TextField(
                  controller: messageController,
                  maxLength: 300,
                  maxLines: null,
                  decoration: InputDecoration(
                    hintText: 'Add your message here...',
                  ),
                ),
                SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    // Handle checkout logic here
                  },
                  child: Text('Checkout'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 48),
                    backgroundColor: Colors.grey.shade400, // Change to match UI
                    foregroundColor: Colors.black,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class RedeemGiftCardPage extends StatelessWidget {
  final TextEditingController codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Have a gift code to redeem?'),
          TextField(
            controller: codeController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: 'E.g.: 0123456789',
            ),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {},
            child: Text('Redeem'),
          ),
        ],
      ),
    );
  }
}
