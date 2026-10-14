// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:ok_ok/main.dart';
// import 'package:ok_ok/modal/service_item.dart';
// import 'package:ok_ok/providers/language_provider.dart';
// import 'package:ok_ok/screens/service_detail.dart';
// import 'package:ok_ok/utils/formatters.dart';
// import 'package:ok_ok/utils/responsive.dart';

// class ListingsScreen extends ConsumerStatefulWidget {
//   const ListingsScreen({super.key});

//   @override
//   ConsumerState<ListingsScreen> createState() => _ListingsScreenState();
// }

// class _ListingsScreenState extends ConsumerState<ListingsScreen> {
//   final _formKey = GlobalKey<FormState>();
//   var _destinationStart = '';
//   var _destinationEnd = '';

//   // void _goToDetails(BuildContext context, ServiceItem data) {
//   //   Navigator.of(context).push(
//   //     MaterialPageRoute(
//   //       builder: (ctx) => ServiceDetailScreen(serviceItem: data),
//   //     ),
//   //   );
//   // }

//   @override
//   Widget build(BuildContext context) {
//     final lang = ref.read(languageProvider.notifier);
//     ref.watch(languageProvider);
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           lang.translate('tabListings'),
//           style: TextStyle(
//             fontSize: context.sp(25),
//             fontWeight: FontWeight.bold,
//             height: 1.2,
//           ),
//         ),
//         const SizedBox(height: 8),
//         Text(
//           'Pronadji ili objavi oglas za prevoz robe',
//           textWidthBasis: TextWidthBasis.longestLine,
//           style: TextStyle(
//             fontSize: context.sp(14),
//             fontWeight: FontWeight.bold,
//             color: AppColors.textSecondary,
//           ),
//         ),
//         const SizedBox(height: 15),
//         Container(
//           decoration: BoxDecoration(
//             color: AppColors.surface,
//             borderRadius: BorderRadius.circular(12),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withValues(alpha: 0.1),
//                 blurRadius: 10,
//                 offset: Offset(0, 4),
//               ),
//             ],
//           ),
//           padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   lang.translate('from'),
//                   style: TextStyle(
//                     fontSize: context.sp(14),
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 5),
//                 TextFormField(
//                   decoration: InputDecoration(
//                     filled: true,
//                     fillColor: AppColors.mainColor,
//                     label: Text(
//                       lang.translate('inputStartLocation'),
//                       style: TextStyle(
//                         fontSize: context.sp(14),
//                         color: AppColors.textSecondary,
//                       ),
//                     ),
//                     prefixIcon: Icon(
//                       Icons.place_outlined,
//                       size: context.w(20),
//                       color: AppColors.primary,
//                     ),
//                     contentPadding: EdgeInsets.symmetric(
//                       horizontal: context.w(15),
//                       vertical: context.h(12),
//                     ),
//                   ),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return lang.translate('inputNullError');
//                     }
//                     return null;
//                   },
//                   onSaved: (value) {
//                     _destinationStart = value!;
//                   },
//                 ),
//                 const SizedBox(height: 10),
//                 Text(
//                   lang.translate("to"),
//                   style: TextStyle(
//                     fontSize: context.sp(14),
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 5),
//                 TextFormField(
//                   decoration: InputDecoration(
//                     filled: true,
//                     fillColor: AppColors.mainColor,
//                     label: Text(
//                       lang.translate('inputEndLocation'),
//                       style: TextStyle(
//                         fontSize: context.sp(14),
//                         color: AppColors.textSecondary,
//                       ),
//                     ),
//                     prefixIcon: Icon(
//                       Icons.gps_fixed_outlined,
//                       size: context.w(20),
//                       color: AppColors.primary,
//                     ),
//                     contentPadding: EdgeInsets.symmetric(
//                       horizontal: context.w(12),
//                       vertical: context.h(12),
//                     ),
//                   ),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return lang.translate('inputNullError');
//                     }
//                     return null;
//                   },
//                   onSaved: (value) {
//                     _destinationEnd = value!;
//                   },
//                 ),
//                 const SizedBox(height: 15),
//                 ElevatedButton(
//                   onPressed: () {},
//                   style: ElevatedButton.styleFrom(
//                     padding: EdgeInsets.symmetric(vertical: context.h(10)),
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(Icons.search, size: context.w(20)),
//                       const SizedBox(width: 10),
//                       Text(
//                         lang.translate('searchButton'),
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: context.sp(15),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         const SizedBox(height: 20),
//         Text(
//           'Moji aktivni oglasi',
//           style: TextStyle(
//             fontSize: context.sp(14),
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         const SizedBox(height: 5),
//         Text(
//           'Oglase koje ste objavili',
//           style: TextStyle(
//             fontSize: context.sp(14),
//             color: AppColors.textSecondary,
//           ),
//         ),
//         const SizedBox(height: 20),
//         Expanded(
//           child: ListView.builder(
//             itemCount: userFakeData[0].listing.length,
//             itemBuilder: (ctx, index) {
//               final dateInfo = getDateTime(
//                 userFakeData[0].listing[index].departureTime,
//               );
//               var dayMonth = dateInfo.dayMonth.split(".");
//               var departureDate = dayMonth[0];
//               var departureMonth = dayMonth[1];

//               return Card(
//                 margin: const EdgeInsets.only(bottom: 15),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10),
//                   side: BorderSide(color: AppColors.border),
//                 ),
//                 color: AppColors.background,
//                 clipBehavior: Clip.hardEdge,
//                 child: InkWell(
//                   onTap: () {},
//                   child: Padding(
//                     padding: const EdgeInsets.all(15),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.stretch,
//                       children: [
//                         Row(
//                           children: [
//                             Text(
//                               userFakeData[0]
//                                   .listing[index]
//                                   .destinationStart
//                                   .city,
//                               style: TextStyle(
//                                 fontSize: context.sp(16),
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             const SizedBox(width: 5),
//                             Icon(
//                               Icons.arrow_forward_sharp,
//                               size: 15,
//                               color: AppColors.primary,
//                             ),
//                             const SizedBox(width: 5),
//                             Flexible(
//                               child: Text(
//                                 userFakeData[0]
//                                     .listing[index]
//                                     .destinationEnd
//                                     .city,
//                                 overflow: TextOverflow.ellipsis,
//                                 maxLines: 2,
//                                 style: TextStyle(
//                                   fontSize: context.sp(16),
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 10),
//                         Row(
//                           children: [
//                             Icon(
//                               Icons.calendar_month_outlined,
//                               size: 20,
//                               color: AppColors.primary,
//                             ),
//                             const SizedBox(width: 5),
//                             Text(
//                               'do $departureDate. ${lang.translate(departureMonth.trim())}',
//                               style: TextStyle(fontSize: context.sp(14)),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 10),
//                         Text(
//                           'Prevoz paketa tezine oko ${userFakeData[0].listing[index].maxWeight}kg',
//                           style: TextStyle(
//                             fontSize: context.sp(14),
//                             color: AppColors.textSecondary,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }
