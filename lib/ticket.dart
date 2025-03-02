import 'package:flutter/material.dart';
import 'seat_selection.dart';
import 'homepage.dart';

class TicketScreen extends StatelessWidget {
  const TicketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Choose Schedule'),
        backgroundColor: const Color(0xFF00C9B7),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Preschool Button
          Center( // Center widget added here
            child: Container(
              width: 200, // Set fixed width for the button
              height: 60, // Set fixed height for the button
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00C9B7),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                ),
                onPressed: () {
                  // Navigate to Seat Selection Screen with "Preschool" title
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SeatSelectionScreen(title: 'Preschool'),
                    ),
                  );
                },
                child: const Text(
                  'Preschool',
                  style: TextStyle(fontSize: 20, color: Colors.black), // Set text color to black
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Primary Button
          Center( // Center widget added here
            child: Container(
              width: 200, // Set fixed width for the button
              height: 60, // Set fixed height for the button
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00C9B7),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                ),
                onPressed: () {
                  // Navigate to Seat Selection Screen with "Primary" title
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SeatSelectionScreen(title: 'Primary'),
                    ),
                  );
                },
                child: const Text(
                  'Primary',
                  style: TextStyle(fontSize: 20, color: Colors.black), // Set text color to black
                ),
              ),
            ),
          ),
        ],
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
        currentIndex: 1,
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
