import 'package:flutter/material.dart';
import 'ticket_info.dart';

class PaymentScreen extends StatelessWidget {
  final int totalAmount;
  final Set<String> selectedSeats;
  final String category;
  final String date;
  final String time;
  final List<List<bool>> seatStatus;
  final Function(Set<String>) onSeatsUpdated;

  const PaymentScreen({
    Key? key,
    required this.totalAmount,
    required this.selectedSeats,
    required this.category,
    required this.date,
    required this.time,
    required this.seatStatus,
    required this.onSeatsUpdated,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Payment'),
        backgroundColor: const Color(0xFF00C9B7),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Category
            Text(
              'Category: $category',
              style: const TextStyle(fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black), // Black text
            ),
            const SizedBox(height: 10),

            // Date and Time
            Text(
              'Date: $date',
              style: const TextStyle(
                  fontSize: 16, color: Colors.black), // Black text
            ),
            const SizedBox(height: 5),
            Text(
              'Time: $time',
              style: const TextStyle(
                  fontSize: 16, color: Colors.black), // Black text
            ),
            const SizedBox(height: 20),

            // Selected Seats Header
            const Text(
              'Selected Seats:',
              style: TextStyle(fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black), // Black text
            ),
            const SizedBox(height: 10),

            // Display selected seats
            ...selectedSeats.map((seat) =>
                Text(seat,
                    style: const TextStyle(fontSize: 16, color: Colors.black))),
            // Black text

            const SizedBox(height: 20),

            // Spacer to push total payment and button to the bottom
            const Spacer(),

            // Total Payment Info
            Text(
              'Total Payment: IDR $totalAmount',
              style: const TextStyle(fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black), // Black text
            ),

            const SizedBox(height: 20),

            // Proceed to Payment Button at the bottom
            Center(
              child: ElevatedButton(
                onPressed: () {
                  _proceedToPayment(context); // Call the payment method
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00C9B7),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 50, vertical: 15),
                ),
                child: const Text('Proceed to Payment',
                    style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ),

            const SizedBox(height: 20),
            // Add space after the button
          ],
        ),
      ),
    );
  }

  void _proceedToPayment(BuildContext context) {
    onSeatsUpdated(selectedSeats);

    // Simulate payment process
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white, // Set background color to white
          title: const Text(
            'Payment Successful',
            style: TextStyle(color: Colors.black),
          ),
          content: const Text(
            'Your payment has been processed. Thank you!',
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Mark selected seats as unavailable
                for (String seat in selectedSeats) {
                  try {
                    // Extract row and col from seat string, e.g., "Row B, Seat 4"
                    List<String> parts = seat.split(' ');
                    if (parts.length == 4 && parts[0] == "Row" && parts[2] == "Seat") {
                      // Extract row: 'A' -> 0, 'B' -> 1, etc.
                      int row = parts[1].codeUnitAt(0) - 65;

                      // Extract column by removing "Seat" and converting to integer
                      int col = int.parse(parts[3]) - 1;

                      // Check boundaries before marking the seat
                      if (row >= 0 && row < seatStatus.length && col >= 0 && col < seatStatus[row].length) {
                        seatStatus[row][col] = false; // Mark seat as unavailable
                      }
                    }
                  } catch (e) {
                    print('Error parsing seat: $seat');
                  }
                }
                Navigator.pop(context);

                // Navigate to Ticket Info screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TicketInfoScreen(
                      selectedSeats: selectedSeats,
                      category: category,
                      date: date,
                      time: time,
                    ),
                  ),
                );
              },
              child: const Text(
                'OK',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        );
      },
    );
  }
}