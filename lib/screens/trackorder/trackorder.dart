// import 'dart:async'; // Add this import for Timer
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import '../../theme/app_theme.dart';

// class TrackOrderScreen extends StatefulWidget {
//   const TrackOrderScreen({super.key});

//   @override
//   State<TrackOrderScreen> createState() => _TrackOrderScreenState();
// }

// class _TrackOrderScreenState extends State<TrackOrderScreen> {
//   static const CameraPosition _initialPosition = CameraPosition(
//     target: LatLng(37.7749, -122.4194),
//     zoom: 14.5,
//   );

//   GoogleMapController? _mapController;
//   bool _isMapLoading = true;
//   double _deliveryProgress = 0.75; // 75% complete
//   Timer? _progressTimer;

//   final Set<Marker> _markers = {
//     Marker(
//       markerId: const MarkerId('restaurant'),
//       position: const LatLng(37.7749, -122.4194),
//       infoWindow: const InfoWindow(title: 'Gourmet Kitchen'),
//       icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
//       zIndexInt: 1,
//     ),
//     Marker(
//       markerId: const MarkerId('delivery'),
//       position: const LatLng(37.7833, -122.4080),
//       infoWindow: const InfoWindow(title: 'John - Your Driver'),
//       icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
//       rotation: 45.0,
//       zIndexInt: 2,
//     ),
//     Marker(
//       markerId: const MarkerId('home'),
//       position: const LatLng(37.7917, -122.3992),
//       infoWindow: const InfoWindow(title: 'Your Location'),
//       icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
//       zIndexInt: 1,
//     ),
//   };

//   final Set<Polyline> _polylines = {
//     Polyline(
//       polylineId: const PolylineId('route'),
//       color: AppTheme.primaryGreen,
//       width: 5,
//       points: const [
//         LatLng(37.7749, -122.4194),
//         LatLng(37.7765, -122.4178),
//         LatLng(37.7782, -122.4161),
//         LatLng(37.7800, -122.4140),
//         LatLng(37.7815, -122.4118),
//         LatLng(37.7833, -122.4080),
//         LatLng(37.7850, -122.4055),
//         LatLng(37.7872, -122.4028),
//         LatLng(37.7890, -122.4005),
//         LatLng(37.7917, -122.3992),
//       ],
//       patterns: [PatternItem.dash(10), PatternItem.gap(5)],
//     ),
//   };

//   final List<Map<String, dynamic>> _statusData = [
//     {
//       'status': 'Order Placed',
//       'time': '2:30 PM',
//       'completed': true,
//       'icon': Icons.shopping_bag_outlined,
//     },
//     {
//       'status': 'Preparing',
//       'time': '2:35 PM',
//       'completed': true,
//       'icon': Icons.restaurant_outlined,
//     },
//     {
//       'status': 'Out for Delivery',
//       'time': '2:45 PM',
//       'completed': true,
//       'icon': Icons.delivery_dining_outlined,
//     },
//     {
//       'status': 'Delivered',
//       'time': '3:00 PM',
//       'completed': false,
//       'icon': Icons.home_outlined,
//     },
//   ];

//   final List<Map<String, dynamic>> _orderDetails = [
//     // Changed to dynamic
//     {
//       'label': 'Order ID',
//       'value': '#FD-789456',
//       'icon': Icons.receipt_long_outlined,
//     },
//     {
//       'label': 'Restaurant',
//       'value': 'Gourmet Kitchen',
//       'icon': Icons.storefront_outlined,
//     },
//     {
//       'label': 'Items',
//       'value': 'Pasta Carbonara, Quinoa Salad',
//       'icon': Icons.fastfood_outlined,
//     },
//     {
//       'label': 'Total Amount',
//       'value': '\$45.99',
//       'icon': Icons.attach_money_outlined,
//     },
//     {
//       'label': 'Payment',
//       'value': '•••• 4242',
//       'icon': Icons.credit_card_outlined,
//     },
//     {
//       'label': 'Delivery Address',
//       'value': '123 Main St, San Francisco',
//       'icon': Icons.location_on_outlined,
//     },
//     {'label': 'ETA', 'value': '8 minutes', 'icon': Icons.timer_outlined},
//     {
//       'label': 'Delivery Agent',
//       'value': 'John Doe',
//       'icon': Icons.person_outline,
//       'rating': '4.9 ⭐',
//     },
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _initializeMap();
//     _startProgressAnimation();
//   }

//   void _initializeMap() {
//     Future.delayed(const Duration(milliseconds: 500), () {
//       if (mounted) {
//         setState(() {
//           _isMapLoading = false;
//         });
//       }
//     });
//   }

//   void _startProgressAnimation() {
//     _progressTimer = Timer.periodic(const Duration(seconds: 2), (timer) {
//       if (mounted && _deliveryProgress < 1.0) {
//         setState(() {
//           _deliveryProgress += 0.05;
//           if (_deliveryProgress > 1.0) _deliveryProgress = 1.0;
//         });
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _progressTimer?.cancel();
//     _mapController?.dispose();
//     super.dispose();
//   }

//   void _onMapCreated(GoogleMapController controller) {
//     _mapController = controller;

//     // Fit map to show all markers with padding
//     Future.delayed(const Duration(milliseconds: 800), () {
//       _mapController?.animateCamera(
//         CameraUpdate.newLatLngBounds(
//           LatLngBounds(
//             southwest: const LatLng(37.773, -122.423),
//             northeast: const LatLng(37.793, -122.397),
//           ),
//           80.0, // Padding
//         ),
//       );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[50],
//       body: CustomScrollView(
//         slivers: [
//           SliverAppBar(
//             backgroundColor: Colors.white,
//             elevation: 0,
//             pinned: true,
//             leading: Padding(
//               padding: const EdgeInsets.only(left: 8),
//               child: IconButton(
//                 icon: Container(
//                   width: 40,
//                   height: 40,
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     shape: BoxShape.circle,
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withValues(alpha: 0.1),
//                         blurRadius: 10,
//                         offset: const Offset(0, 2),
//                       ),
//                     ],
//                   ),
//                   child: const Icon(
//                     Icons.arrow_back_ios_new_rounded,
//                     color: Colors.black87,
//                     size: 18,
//                   ),
//                 ),
//                 onPressed: () => Navigator.pop(context),
//               ),
//             ),
//             title: const Text(
//               'Track Order',
//               style: TextStyle(
//                 color: Colors.black87,
//                 fontSize: 20,
//                 fontWeight: FontWeight.w800,
//                 letterSpacing: -0.5,
//               ),
//             ),
//             centerTitle: true,
//             actions: [
//               Padding(
//                 padding: const EdgeInsets.only(right: 8),
//                 child: IconButton(
//                   icon: Container(
//                     width: 40,
//                     height: 40,
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       shape: BoxShape.circle,
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withValues(alpha: 0.1),
//                           blurRadius: 10,
//                           offset: const Offset(0, 2),
//                         ),
//                       ],
//                     ),
//                     child: const Icon(
//                       Icons.more_vert_rounded,
//                       color: Colors.black54,
//                       size: 20,
//                     ),
//                   ),
//                   onPressed: () {},
//                 ),
//               ),
//             ],
//           ),

//           SliverList(
//             delegate: SliverChildListDelegate([
//               // Delivery Progress Card
//               _buildProgressCard(),

//               // Map Section
//               _buildMapSection(),

//               // Order Status Timeline
//               _buildStatusSection(),

//               // Order Details
//               _buildOrderDetails(),

//               const SizedBox(height: 100),
//             ]),
//           ),
//         ],
//       ),

//       // Fixed Bottom Action Bar
//       bottomSheet: _buildBottomActionBar(),
//     );
//   }

//   Widget _buildProgressCard() {
//     return Container(
//       margin: const EdgeInsets.fromLTRB(20, 16, 20, 16),
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//           colors: [
//             AppTheme.primaryGreen.withValues(alpha: 0.9),
//             AppTheme.primaryGreen.withValues(alpha: 0.7),
//           ],
//         ),
//         borderRadius: BorderRadius.circular(24),
//         boxShadow: [
//           BoxShadow(
//             color: AppTheme.primaryGreen.withValues(alpha: 0.3),
//             blurRadius: 20,
//             offset: const Offset(0, 10),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Container(
//                 padding: const EdgeInsets.all(8),
//                 decoration: BoxDecoration(
//                   color: Colors.white.withValues(alpha: 0.2),
//                   shape: BoxShape.circle,
//                 ),
//                 child: const Icon(
//                   Icons.delivery_dining,
//                   color: Colors.white,
//                   size: 24,
//                 ),
//               ),
//               const SizedBox(width: 12),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text(
//                       'Delivery in Progress',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 18,
//                         fontWeight: FontWeight.w700,
//                       ),
//                     ),
//                     Text(
//                       'Estimated arrival: 8 minutes',
//                       style: TextStyle(
//                         color: Colors.white.withValues(alpha: 0.9),
//                         fontSize: 14,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 16),

//           // Progress Bar
//           Stack(
//             children: [
//               Container(
//                 height: 8,
//                 decoration: BoxDecoration(
//                   color: Colors.white.withValues(alpha: 0.3),
//                   borderRadius: BorderRadius.circular(4),
//                 ),
//               ),
//               AnimatedContainer(
//                 duration: const Duration(milliseconds: 500),
//                 curve: Curves.easeInOut,
//                 height: 8,
//                 width:
//                     MediaQuery.of(context).size.width *
//                     0.85 *
//                     _deliveryProgress,
//                 decoration: BoxDecoration(
//                   gradient: const LinearGradient(
//                     colors: [Colors.white, Color(0xFFD4F8E8)],
//                   ),
//                   borderRadius: BorderRadius.circular(4),
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 8),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 'Restaurant',
//                 style: TextStyle(
//                   color: Colors.white.withValues(alpha: 0.9),
//                   fontSize: 12,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//               Text(
//                 '${(_deliveryProgress * 100).toInt()}%',
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontSize: 14,
//                   fontWeight: FontWeight.w700,
//                 ),
//               ),
//               Text(
//                 'Your Location',
//                 style: TextStyle(
//                   color: Colors.white.withValues(alpha: 0.9),
//                   fontSize: 12,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildMapSection() {
//     return Container(
//       height: 320,
//       margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(24),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withValues(alpha: 0.1),
//             blurRadius: 20,
//             offset: const Offset(0, 10),
//           ),
//         ],
//       ),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(24),
//         child: Stack(
//           children: [
//             // Map
//             _isMapLoading
//                 ? Container(
//                     color: Colors.grey[100],
//                     child: Center(
//                       child: CircularProgressIndicator(
//                         valueColor: AlwaysStoppedAnimation<Color>(
//                           AppTheme.primaryGreen,
//                         ),
//                       ),
//                     ),
//                   )
//                 : GoogleMap(
//                     onMapCreated: _onMapCreated,
//                     initialCameraPosition: _initialPosition,
//                     markers: _markers,
//                     polylines: _polylines,
//                     mapType: MapType.normal,
//                     myLocationEnabled: true,
//                     myLocationButtonEnabled: false,
//                     compassEnabled: false,
//                     zoomControlsEnabled: false,
//                     zoomGesturesEnabled: true,
//                     scrollGesturesEnabled: true,
//                     rotateGesturesEnabled: false,
//                     tiltGesturesEnabled: false,
//                     minMaxZoomPreference: const MinMaxZoomPreference(10, 18),
//                   ),

//             // Map Controls
//             Positioned(
//               right: 16,
//               bottom: 16,
//               child: Column(
//                 children: [
//                   _buildMapControlButton(
//                     icon: Icons.my_location,
//                     onTap: () {
//                       _mapController?.animateCamera(
//                         CameraUpdate.newLatLng(
//                           const LatLng(37.7917, -122.3992),
//                         ),
//                       );
//                     },
//                   ),
//                   const SizedBox(height: 8),
//                   _buildMapControlButton(
//                     icon: Icons.zoom_in,
//                     onTap: () {
//                       _mapController?.animateCamera(CameraUpdate.zoomIn());
//                     },
//                   ),
//                   const SizedBox(height: 8),
//                   _buildMapControlButton(
//                     icon: Icons.zoom_out,
//                     onTap: () {
//                       _mapController?.animateCamera(CameraUpdate.zoomOut());
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildMapControlButton({
//     required IconData icon,
//     required VoidCallback onTap,
//   }) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         width: 48,
//         height: 48,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           shape: BoxShape.circle,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withValues(alpha: 0.1),
//               blurRadius: 10,
//               offset: const Offset(0, 4),
//             ),
//           ],
//         ),
//         child: Icon(icon, color: AppTheme.primaryGreen, size: 24),
//       ),
//     );
//   }

//   Widget _buildStatusSection() {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
//       padding: const EdgeInsets.all(24),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(24),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withValues(alpha: 0.05),
//             blurRadius: 20,
//             offset: const Offset(0, 10),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             'Delivery Status',
//             style: TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.w800,
//               color: Colors.black87,
//               letterSpacing: -0.5,
//             ),
//           ),
//           const SizedBox(height: 24),
//           ..._statusData.map((item) {
//             final index = _statusData.indexOf(item);
//             final isLast = index == _statusData.length - 1;

//             return Padding(
//               padding: EdgeInsets.only(bottom: isLast ? 0 : 20),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Status Indicator
//                   Column(
//                     children: [
//                       Container(
//                         width: 48,
//                         height: 48,
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           color: item['completed'] as bool
//                               ? AppTheme.primaryGreen
//                               : Colors.grey[200],
//                           border: Border.all(
//                             color: item['completed'] as bool
//                                 ? AppTheme.primaryGreen
//                                 : Colors.grey[300]!,
//                             width: 2,
//                           ),
//                           boxShadow: item['completed'] as bool
//                               ? [
//                                   BoxShadow(
//                                     color: AppTheme.primaryGreen.withValues(
//                                       alpha: 0.2,
//                                     ),
//                                     blurRadius: 8,
//                                     offset: const Offset(0, 4),
//                                   ),
//                                 ]
//                               : null,
//                         ),
//                         child: Icon(
//                           item['icon'] as IconData,
//                           size: 24,
//                           color: item['completed'] as bool
//                               ? Colors.white
//                               : Colors.grey[400],
//                         ),
//                       ),
//                       if (!isLast)
//                         Container(
//                           width: 2,
//                           height: 28,
//                           margin: const EdgeInsets.only(top: 4),
//                           color: item['completed'] as bool
//                               ? AppTheme.primaryGreen
//                               : Colors.grey[300],
//                         ),
//                     ],
//                   ),
//                   const SizedBox(width: 20),

//                   // Status Details
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           item['status'] as String,
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w600,
//                             color: item['completed'] as bool
//                                 ? Colors.black87
//                                 : Colors.grey[500],
//                           ),
//                         ),
//                         const SizedBox(height: 4),
//                         Row(
//                           children: [
//                             Icon(
//                               Icons.access_time,
//                               size: 14,
//                               color: Colors.grey[400],
//                             ),
//                             const SizedBox(width: 6),
//                             Text(
//                               item['time'] as String,
//                               style: TextStyle(
//                                 fontSize: 14,
//                                 color: Colors.grey[500],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),

//                   // Checkmark for completed
//                   if (item['completed'] as bool)
//                     Container(
//                       width: 32,
//                       height: 32,
//                       decoration: const BoxDecoration(
//                         color: AppTheme.primaryGreen,
//                         shape: BoxShape.circle,
//                       ),
//                       child: const Icon(
//                         Icons.check,
//                         color: Colors.white,
//                         size: 18,
//                       ),
//                     ),
//                 ],
//               ),
//             );
//           }),
//         ],
//       ),
//     );
//   }

//   Widget _buildOrderDetails() {
//     return Container(
//       margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
//       padding: const EdgeInsets.all(24),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(24),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withValues(alpha: 0.05),
//             blurRadius: 20,
//             offset: const Offset(0, 10),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             'Order Details',
//             style: TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.w800,
//               color: Colors.black87,
//               letterSpacing: -0.5,
//             ),
//           ),
//           const SizedBox(height: 24),
//           ..._orderDetails.map(
//             (detail) => _buildDetailItem(
//               icon: detail['icon'] as IconData,
//               label: detail['label'] as String,
//               value: detail['value'] as String,
//               rating: detail['rating'] as String?,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildDetailItem({
//     required IconData icon,
//     required String label,
//     required String value,
//     String? rating,
//   }) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 20),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             width: 40,
//             height: 40,
//             decoration: BoxDecoration(
//               color: AppTheme.primaryGreen.withValues(alpha: 0.1),
//               shape: BoxShape.circle,
//             ),
//             child: Icon(icon, color: AppTheme.primaryGreen, size: 20),
//           ),
//           const SizedBox(width: 16),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   label,
//                   style: TextStyle(
//                     fontSize: 14,
//                     color: Colors.grey[600],
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: Text(
//                         value,
//                         style: const TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w600,
//                           color: Colors.black87,
//                         ),
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ),
//                     if (rating != null) ...[
//                       const SizedBox(width: 8),
//                       Container(
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 8,
//                           vertical: 4,
//                         ),
//                         decoration: BoxDecoration(
//                           color: AppTheme.primaryGreen.withValues(alpha: 0.1),
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child: Text(
//                           rating,
//                           style: TextStyle(
//                             fontSize: 12,
//                             fontWeight: FontWeight.w700,
//                             color: AppTheme.primaryGreen,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildBottomActionBar() {
//     return Container(
//       padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withValues(alpha: 0.1),
//             blurRadius: 30,
//             offset: const Offset(0, -10),
//           ),
//         ],
//         borderRadius: const BorderRadius.only(
//           topLeft: Radius.circular(24),
//           topRight: Radius.circular(24),
//         ),
//       ),
//       child: SafeArea(
//         child: Row(
//           children: [
//             Expanded(
//               child: ElevatedButton.icon(
//                 onPressed: () {
//                   // Call driver
//                 },
//                 icon: const Icon(Icons.phone, size: 20),
//                 label: const Text('Call Driver'),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.white,
//                   foregroundColor: Colors.black87,
//                   padding: const EdgeInsets.symmetric(vertical: 18),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(16),
//                     side: BorderSide(color: Colors.grey[300]!),
//                   ),
//                   elevation: 0,
//                   shadowColor: Colors.transparent,
//                 ),
//               ),
//             ),
//             const SizedBox(width: 16),
//             Expanded(
//               child: ElevatedButton.icon(
//                 onPressed: () {
//                   // Track on full screen
//                 },
//                 icon: const Icon(Icons.fullscreen, size: 20),
//                 label: const Text('Full View'),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: AppTheme.primaryGreen,
//                   foregroundColor: Colors.white,
//                   padding: const EdgeInsets.symmetric(vertical: 18),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                   elevation: 2,
//                   shadowColor: AppTheme.primaryGreen.withValues(alpha: 0.3),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
