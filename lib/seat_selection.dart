import 'package:flutter/material.dart';
import 'homepage.dart';
import 'payment.dart';

class SeatSelectionScreen extends StatefulWidget {
  final String title; // To pass "Preschool" or "Primary" from previous page
  const SeatSelectionScreen({super.key, required this.title});

  @override
  _SeatSelectionScreenState createState() => _SeatSelectionScreenState();
}

class _SeatSelectionScreenState extends State<SeatSelectionScreen> {
  static const int seatPrice = 50000;
  List<List<bool>> seatStatus = List.generate(10, (index) => List.generate(10, (index) => true)); // All seats initially available (true)
  Set<String> selectedSeats = {}; // Store selected seats

  int totalSeatsSelected = 0;

  // Add category-specific date and time logic
  String getDateBasedOnCategory() {
    return 'April 25, 2024';
  }

  String getTimeBasedOnCategory() {
    return widget.title == 'Preschool' ? '10:00 AM' : '5:00 PM';
  }

  @override
  void initState() {
    super.initState();
    // Set the first row as not available
    for (int col = 0; col < 10; col++) {
      seatStatus[0][col] = false; // Marking the first row as not available
    }
  }

  void toggleSeat(int row, int col) {
    setState(() {
      if (seatStatus[row][col]) { // If seat is available
        String seatId = 'Row ${String.fromCharCode(65 + row)}, Seat ${col + 1}'; // Change row to A, B, C, etc.
        if (selectedSeats.contains(seatId)) {
          selectedSeats.remove(seatId); // Deselect
          totalSeatsSelected--;
        } else {
          selectedSeats.add(seatId); // Select seat
          totalSeatsSelected++;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: const Color(0xFF00C9B7), // Navbar color
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          const Text(
            'Select Your Seat',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          const SizedBox(height: 10),

          // Seat Grid (10x10)
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0), // Reduced vertical padding
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 10,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
              ),
              itemCount: 100, // 10x10 seats
              itemBuilder: (context, index) {
                int row = index ~/ 10;
                int col = index % 10;
                bool isSelected = selectedSeats.contains('Row ${String.fromCharCode(65 + row)}, Seat ${col + 1}');

                return GestureDetector(
                  onTap: () => toggleSeat(row, col),
                  child: Container(
                    decoration: BoxDecoration(
                      color: seatStatus[row][col]
                          ? (isSelected ? const Color(0xFF00C9B7) : Colors.black)
                          : Colors.grey, // Grey for unavailable, black for available, bluish for selected
                      borderRadius: BorderRadius.circular(5),
                    ),
                    margin: const EdgeInsets.all(2),
                    child: Center(
                      child: Icon(
                        Icons.event_seat,
                        color: seatStatus[row][col]
                            ? (isSelected ? Colors.white : Colors.black) // Seat icon color changes based on status
                            : Colors.grey,
                        size: 24, // Adjust icon size as needed
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Seat Legends
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildLegend('Available', Colors.black),
                _buildLegend('Not Available', Colors.grey),
                _buildLegend('Selected', const Color(0xFF00C9B7)),
              ],
            ),
          ),

          // Detail Information
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Date and Time
                Text(getDateBasedOnCategory(), style: const TextStyle(fontSize: 16, color: Colors.black)),
                Text(getTimeBasedOnCategory(), style: const TextStyle(fontSize: 16, color: Colors.black)),

                // Row and Seat Info
                if (selectedSeats.isNotEmpty)
                  Container(
                    alignment: Alignment.centerRight, // Align to the right
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end, // Align individual seats to the end
                      children: selectedSeats.map((seat) {
                        if (seat.isEmpty){
                          print('Empty seat ID encountered');
                          return const Text('');
                        }
                        return Text(seat, style: const TextStyle(color: Colors.black));
                      }).toList(),
                    ),
                  ),

                const SizedBox(height: 10),

                // Total Payment
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Payment: IDR ${totalSeatsSelected * seatPrice}',
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Handle payment action here
                        if (totalSeatsSelected > 0) {
                          // Calculate total amount
                          int totalAmount = totalSeatsSelected * seatPrice;

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PaymentScreen(
                                  totalAmount: totalAmount,
                                  selectedSeats: selectedSeats,
                                  category: widget.title,
                                  date: getDateBasedOnCategory(),
                                  time: getTimeBasedOnCategory(),
                                  seatStatus: seatStatus,
                                  onSeatsUpdated: _updateSeatStatusAfterPayment,
                                ),
                              ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Please select at least one seat.')),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF00C9B7), // Button color
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      ),
                      child: Row(
                        children: const [
                          Text('Pay Now', style: TextStyle(color: Colors.white)),
                          SizedBox(width: 5),
                          Icon(Icons.arrow_forward, color: Colors.white),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
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

  // Callback to update seat status after payment
  void _updateSeatStatusAfterPayment(Set<String> purchasedSeats) {
    setState(() {
      for (String seat in purchasedSeats) {
        List<String> parts = seat.split(' ');
        if (parts.length == 4 && parts[0] == 'Row' && parts[2] == 'Seat') {
          int row = parts[1].codeUnitAt(0) - 65; // Convert 'A' to 0, 'B' to 1, etc.
          int col = int.parse(parts[3]) - 1;
          seatStatus[row][col] = false; // Mark seat as unavailable
        }
      }
    });
  }

  Widget _buildLegend(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(5)),
        ),
        const SizedBox(width: 5),
        Text(label, style: const TextStyle(color: Colors.black)), // Set legend text color to black
      ],
    );
  }
}
