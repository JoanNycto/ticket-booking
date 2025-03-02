import 'package:flutter/material.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'homepage.dart';

class TicketInfoScreen extends StatelessWidget {
  final Set<String> selectedSeats;
  final String category;
  final String date;
  final String time;

  const TicketInfoScreen({
    Key? key,
    required this.selectedSeats,
    required this.category,
    required this.date,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Concatenate seat and time information for the barcode content
    String barcodeContent = 'Seats: ${selectedSeats.join(", ")} | Time: $time';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Ticket Information'),
        backgroundColor: const Color(0xFF00C9B7),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,  // Align content to the top
            children: [
              // Ticket Container
              Container(
                padding: const EdgeInsets.all(16.0),
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min, // Adjust container size to fit content
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top Event Banner with image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        'assets/images/tk.png',
                        fit: BoxFit.cover,
                        height: 150,
                        width: double.infinity,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Event title
                    const Text(
                      "BIM's ART FESTIVAL",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,  // Change text color to black
                      ),
                    ),
                    const SizedBox(height: 5),

                    // Category
                    Text(
                      category,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black,  // Change text color to black
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Event Information (Date, Venue)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.calendar_today, size: 16, color: Colors.black),
                                const SizedBox(width: 5),
                                Text(
                                  'Date: $date',
                                  style: const TextStyle(fontSize: 16, color: Colors.black),  // Black text
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                const Icon(Icons.access_time, size: 16, color: Colors.black),
                                const SizedBox(width: 5),
                                Text(
                                  'Time: $time',
                                  style: const TextStyle(fontSize: 16, color: Colors.black),  // Black text
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              children: const [
                                Icon(Icons.location_on, size: 16, color: Colors.black),
                                SizedBox(width: 5),
                                Text(
                                  'Studio ABC',
                                  style: TextStyle(fontSize: 16, color: Colors.black),  // Black text
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: const [
                                Icon(Icons.location_city, size: 16, color: Colors.black),
                                SizedBox(width: 5),
                                Text(
                                  'Jl ABC',
                                  style: TextStyle(fontSize: 16, color: Colors.black),  // Black text
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Selected Seats
                    const Text(
                      'Selected Seats:',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),  // Black text
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      children: selectedSeats
                          .map((seat) => Container(
                        margin: const EdgeInsets.only(right: 10, bottom: 5),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.lightBlue[100],
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(seat, style: const TextStyle(fontSize: 16, color: Colors.black)),
                      ))
                          .toList(),
                    ),
                    const SizedBox(height: 30),

                    // Barcode section
                    BarcodeWidget(
                      data: barcodeContent,
                      barcode: Barcode.code128(), // Choose your preferred barcode type
                      width: double.infinity,
                      height: 100,
                      drawText: false, // If you want to hide the text below the barcode
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF00C9B7),
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.white,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            label: 'Events',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.confirmation_number),
            label: 'Ticket',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifs',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.help),
            label: 'Help',
          ),
        ],
        currentIndex: 2,
        onTap: (index) {
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          }
        },
      ),
    );
  }
}

