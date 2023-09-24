// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:linkedin_login/linkedin_login.dart';

import '../../../core/enums/enums.dart';

import '../controller/auth_controller.dart';

class SocialButton extends ConsumerWidget {
  final String iconPath;
  final String label;
  final double horizontalPadding;
  final double verticalPadding;
  final SocialButtonType socialButtonType;
  final BuildContext ctx;
  const SocialButton(
      {Key? key,
      required this.ctx,
      required this.iconPath,
      required this.label,
      required this.socialButtonType,
      this.horizontalPadding = 10,
      this.verticalPadding = 10})
      : super(key: key);

//Google sign-in
  void signInWithGoogle(WidgetRef ref, BuildContext context) {
    ref.read(authControllerProvider.notifier).signInWithGoogle(context);
  }

//facebook sign-in
  void signInWithFacebook(WidgetRef ref, BuildContext context) {
    ref.read(authControllerProvider.notifier).signInWithFacebook(context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      iconSize: 30,
      onPressed: () {
        socialButtonType == SocialButtonType.facebook
            ? signInWithFacebook(ref, context)
            : socialButtonType == SocialButtonType.google
                ? signInWithGoogle(ref, context)
                : null;
      },
      icon: Image.asset(
        iconPath,
      ),
    );
  }
}


//LinkedIn Example code
// class MyApp extends StatelessWidget {
//   const MyApp({final Key? key}) : super(key: key);

//   // This widget is the root of your application.
//   @override
//   Widget build(final BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter LinkedIn demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: DefaultTabController(
//         length: 2,
//         child: Scaffold(
//           appBar: AppBar(
//             bottom: const TabBar(
//               tabs: [
//                 Tab(
//                   icon: Icon(Icons.person),
//                   text: 'Profile',
//                 ),
//                 Tab(icon: Icon(Icons.text_fields), text: 'Auth code')
//               ],
//             ),
//             title: const Text('LinkedIn Authorization'),
//           ),
//           body: const TabBarView(
//             children: [
//               LinkedInProfileExamplePage(),
//               LinkedInAuthCodeExamplePage(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class LinkedInProfileExamplePage extends StatefulWidget {
//   const LinkedInProfileExamplePage({final Key? key}) : super(key: key);

//   @override
//   State createState() => _LinkedInProfileExamplePageState();
// }

// class _LinkedInProfileExamplePageState
//     extends State<LinkedInProfileExamplePage> {
//   UserObject? user;
//   bool logoutUser = false;

//   @override
//   Widget build(final BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: <Widget>[
//             LinkedInButtonStandardWidget(
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute<void>(
//                     builder: (final BuildContext context) => LinkedInUserWidget(
//                       appBar: AppBar(
//                         title: const Text('OAuth User'),
//                       ),
//                       destroySession: logoutUser,
//                       redirectUrl: linkedinRedirectURL,
//                       clientId: linkedinClientID,
//                       clientSecret: linkedinClientSecret,
//                       projection: const [
//                         ProjectionParameters.id,
//                         ProjectionParameters.localizedFirstName,
//                         ProjectionParameters.localizedLastName,
//                         ProjectionParameters.firstName,
//                         ProjectionParameters.lastName,
//                         ProjectionParameters.profilePicture,
//                       ],
//                       onError: (final UserFailedAction e) {
//                         print('Error: ${e.toString()}');
//                         print('Error: ${e.stackTrace.toString()}');
//                       },
//                       onGetUserProfile: (final UserSucceededAction linkedInUser) {
//                         print(
//                           'Access token ${linkedInUser.user.token.accessToken}',
//                         );
    
//                         print('User id: ${linkedInUser.user.userId}');
    
//                         user = UserObject(
//                           firstName:
//                               linkedInUser.user.firstName?.localized?.label ?? "",
//                           lastName:
//                               linkedInUser.user.lastName?.localized?.label ?? "",
//                           email: linkedInUser.user.email?.elements![0].handleDeep
//                                   ?.emailAddress ??
//                               "",
//                           profileImageUrl: linkedInUser
//                                   .user
//                                   .profilePicture
//                                   ?.displayImageContent
//                                   ?.elements![0]
//                                   .identifiers![0]
//                                   .identifier ??
//                               "",
//                         );
    
//                         setState(() {
//                           logoutUser = false;
//                         });
    
//                         Navigator.pop(context);
//                       },
//                     ),
//                     fullscreenDialog: true,
//                   ),
//                 );
//               },
//             ),
//             LinkedInButtonStandardWidget(
//               onTap: () {
//                 setState(() {
//                   user = null;
//                   logoutUser = true;
//                 });
//               },
//               buttonText: 'Logout',
//             ),
//             Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 Text('First: ${user?.firstName} '),
//                 Text('Last: ${user?.lastName} '),
//                 Text('Email: ${user?.email}'),
//                 Text('Profile image: ${user?.profileImageUrl}'),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class LinkedInAuthCodeExamplePage extends StatefulWidget {
//   const LinkedInAuthCodeExamplePage({final Key? key}) : super(key: key);

//   @override
//   State createState() => _LinkedInAuthCodeExamplePageState();
// }

// class _LinkedInAuthCodeExamplePageState
//     extends State<LinkedInAuthCodeExamplePage> {
//   AuthCodeObject? authorizationCode;
//   bool logoutUser = false;

//   @override
//   Widget build(final BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: <Widget>[
//         LinkedInButtonStandardWidget(
//           onTap: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute<void>(
//                 builder: (final BuildContext context) => LinkedInAuthCodeWidget(
//                   destroySession: logoutUser,
//                   redirectUrl: linkedinRedirectURL,
//                   clientId: linkedinClientID,
//                   onError: (final AuthorizationFailedAction e) {
//                     print('Error: ${e.toString()}');
//                     print('Error: ${e.stackTrace.toString()}');
//                   },
//                   onGetAuthCode: (final AuthorizationSucceededAction response) {
//                     print('Auth code ${response.codeResponse.code}');

//                     print('State: ${response.codeResponse.state}');

//                     authorizationCode = AuthCodeObject(
//                       code: response.codeResponse.code.toString(),
//                       state: response.codeResponse.state.toString(),
//                     );
//                     setState(() {});

//                     Navigator.pop(context);
//                   },
//                 ),
//                 fullscreenDialog: true,
//               ),
//             );
//           },
//         ),
//         LinkedInButtonStandardWidget(
//           onTap: () {
//             setState(() {
//               authorizationCode = null;
//               logoutUser = true;
//             });
//           },
//           buttonText: 'Logout user',
//         ),
//         Container(
//           margin: const EdgeInsets.symmetric(horizontal: 16),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Text('Auth code: ${authorizationCode?.code} '),
//               Text('State: ${authorizationCode?.state} '),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }



// class AuthCodeObject {
//   AuthCodeObject({required this.code, required this.state});

//   final String code;
//   final String state;
// }

// class UserObject {
//   UserObject({
//     required this.firstName,
//     required this.lastName,
//     required this.email,
//     required this.profileImageUrl,
//   });

//   final String firstName;
//   final String lastName;
//   final String email;
//   final String profileImageUrl;
// }
