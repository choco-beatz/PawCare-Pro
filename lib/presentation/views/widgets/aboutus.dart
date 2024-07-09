import 'package:flutter/material.dart';
import 'package:pawcare_pro/constant/button.dart';
import 'package:pawcare_pro/constant/colors.dart';
import 'package:pawcare_pro/constant/sizedbox.dart';
import 'package:pawcare_pro/constant/style.dart';
import 'package:pawcare_pro/presentation/views/addpet/widgets/field_style.dart';
import 'package:pawcare_pro/presentation/views/addpet/widgets/lable.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainBG,
      appBar: AppBar(
        backgroundColor: mainBG,
        foregroundColor: white,
        title: const Text(
          'User Profile',
          style: TextStyle(fontSize: 18),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              space,
              space,
              heading3('About us'),
              space,
              space,
              space,
              label('Welcome to PawCare Pro!'),
              space,
              subject2(
                  "Hello! My name is Gayathri Rejeesh, an aspiring Flutter developer, and I am thrilled to introduce you to PawCare Pro, a comprehensive application designed to help you manage your pet's details with ease and efficiency."),
              line,
              space,
              space,
              space,
              label('Our Story'),
              space,
              subject2(
                  "The inspiration behind PawCare Pro comes from my unconditional love for animals. I wanted to create a tool that would make it easier for pet owners to keep track of their furry friends' important information and activities. With the guidance of YouTube tutorials, pub.dev documentation, and insightful articles from Medium and Geeks for Geeks, I embarked on this journey to develop PawCare Pro."),
              line,
              space,
              space,
              space,
              label('Features'),
              space,
              subject2(
                  '''Pet Profile Management: Create and manage detailed profiles for your pets, including their name, appearance, breed, weight, gender, birthday, and adoption day.

Document Storage: Upload and store your pet's documents, including their issue and expiry dates.

Health Management: Keep track of health-related details like vaccines and certificates.

Recipe Creation: Create and store nutritious pet food recipes.

Event Calendar: Add and manage events such as grooming, check-ups, and activities for your pet.

Multiple Pet Management: Manage details for multiple pets seamlessly.

Database: Uses Hive as the database for efficient and reliable data storage.'''),
              line,
              space,
              space,
              space,
              label('Why PawCare Pro?'),
              space,
              subject2(
                  "PawCare Pro is more than just an app; it's a reflection of my passion for animals and technology. I aimed to create a user-friendly platform that caters to the diverse needs of pet owners, ensuring that every pet receives the care and attention they deserve."),
              line,
              space,
              space,
              space,
              label('Get in Touch'),
              space,
              subject2(
                  '''I would love to hear from you! Whether you have feedback, questions, or simply want to connect, feel free to reach out to me through any of the following channels:
          
Email: gaya3guava@gmail.com
Contact No: +91 7902893398
Instagram: mystic_odile
LinkedIn: Gayathri Rejeesh

Thank you for choosing PawCare Pro. Together, let's make pet care simpler and more organized!'''),
              sizedBox,
              FilledButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: mainButton,
                child: const Text('Done'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
