import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/models/guides.dart';
import '../../utils/constants/assets.dart';
import '../../views/guide/guide_detail.dart';
import '../../widgets/container/custom_container.dart';
import '../../widgets/text/text_widget.dart';

class GuideWidget extends StatelessWidget {
  const GuideWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final List<Guide> guides = [
      Guide(
        title: "Reducing Stress",
        imageUrl: AppAssets.reduceStress,
        description:
            "A guide to reducing stress for better health and fitness.",
        points: [
          {
            'title': '1. Prioritize Quality Sleep',
            'description':
                'Why it matters: Poor sleep increases cortisol, reduces recovery, and impairs cognitive function.\nHow to prevent it: Maintain a consistent sleep schedule, limit blue light before bed, and create a relaxing bedtime routine.',
          },
          {
            'title': '2. Optimize Nutrition',
            'description':
                'Why it matters: Processed foods and poor nutrition can spike stress hormones and lead to energy crashes.\nHow to prevent it: Eat whole foods rich in magnesium, omega-3s, and B vitamins while limiting caffeine and sugar.',
          },
          {
            'title': '3. Incorporate Mindful Practices',
            'description':
                'Why it matters: Chronic stress overstimulates the nervous system, leading to anxiety and fatigue.\nHow to prevent it: Practice deep breathing, meditation, and gratitude journaling daily.',
          },
          {
            'title': '4. Engage in Regular Physical Activity',
            'description':
                'Why it matters: Exercise reduces stress hormones and boosts mood-enhancing endorphins.\nHow to prevent it: Engage in at least 30 minutes of enjoyable physical activity daily.',
          },
          {
            'title': '5. Support with Adaptogens & Supplements',
            'description':
                'Why it matters: Adaptogens help regulate cortisol and improve stress resilience.\nHow to prevent it: Use ashwagandha, rhodiola, and magnesium to naturally balance stress.',
          },
          {
            'title': '6. Reduce Caffeine and Alcohol Intake',
            'description':
                'Why it matters: Excessive caffeine and alcohol can disrupt sleep and increase anxiety.\nHow to prevent it: Limit intake, especially in the afternoon and evening.',
          },
          {
            'title': '7. Build a Strong Social Support System',
            'description':
                'Why it matters: Connecting with others helps reduce feelings of loneliness and stress.\nHow to prevent it: Engage with friends, family, or support groups regularly.',
          },
          {
            'title': '8. Set Boundaries with Work and Personal Life',
            'description':
                'Why it matters: Overworking leads to burnout and heightened stress levels.\nHow to prevent it: Set clear work-life boundaries and take regular breaks.',
          },
          {
            'title': '9. Spend Time in Nature',
            'description':
                'Why it matters: Exposure to green spaces reduces stress and promotes relaxation.\nHow to prevent it: Take walks in parks, hike, or simply sit outdoors daily.',
          },
          {
            'title': '10. Practice Gratitude',
            'description':
                'Why it matters: Gratitude shifts focus from stressors to positive aspects of life.\nHow to prevent it: Write down three things you’re grateful for daily.',
          },
          {
            'title': '11. Listen to Relaxing Music',
            'description':
                'Why it matters: Music can lower blood pressure and reduce stress.\nHow to prevent it: Listen to calming playlists or nature sounds.',
          },
          {
            'title': '12. Take Breaks from Technology',
            'description':
                'Why it matters: Constant screen time increases stress and overstimulation.\nHow to prevent it: Unplug from devices for a few hours each day.',
          },
          {
            'title': '13. Engage in a Creative Hobby',
            'description':
                'Why it matters: Creativity helps lower stress levels and boost mood.\nHow to prevent it: Try painting, writing, or playing an instrument.',
          },
          {
            'title': '14. Laugh More',
            'description':
                'Why it matters: Laughter releases endorphins and lowers stress hormones.\nHow to prevent it: Watch comedies, joke with friends, or engage in playful activities.',
          },
          {
            'title': '15. Seek Professional Help if Needed',
            'description':
                'Why it matters: Chronic stress can lead to mental health issues.\nHow to prevent it: Consult a therapist or counselor if stress becomes overwhelming.',
          },
        ],
      ),
      Guide(
        title: "Enhancing Muscle Function",
        imageUrl: AppAssets.coverImage,
        description:
            "Learn how to effectively increase muscle mass and function.",
        points: [
          {
            'title': '1. Prioritize Protein Intake',
            'description':
                'Why it matters: Protein is essential for muscle repair and growth.\nHow to prevent it: Eat protein-rich foods and distribute intake evenly throughout the day.',
          },
          {
            'title': '2. Strength Train Efficiently',
            'description':
                'Why it matters: Proper strength training promotes hypertrophy and prevents muscle loss.\nHow to prevent it: Focus on compound movements and progressive overload.',
          },
          {
            'title': '3. Optimize Hydration & Electrolytes',
            'description':
                'Why it matters: Dehydration leads to muscle cramps, fatigue, and poor performance.\nHow to prevent it: Drink water regularly and replenish electrolytes like sodium and potassium.',
          },
          {
            'title': '4. Leverage Key Supplements',
            'description':
                'Why it matters: Certain supplements can enhance strength, endurance, and recovery.\nHow to prevent it: Use creatine, beta-alanine, and BCAAs to support muscle function.',
          },
          {
            'title': '5. Improve Mobility & Recovery',
            'description':
                'Why it matters: Poor mobility increases injury risk and limits performance.\nHow to prevent it: Stretch daily, foam roll, and incorporate yoga or mobility exercises.',
          },
          {
            'title': '6. Maintain Proper Form',
            'description':
                'Why it matters: Incorrect form can lead to injuries and muscle imbalances.\nHow to prevent it: Learn proper technique and use a spotter when needed.',
          },
          {
            'title': '7. Get Enough Healthy Fats',
            'description':
                'Why it matters: Healthy fats support hormone production and muscle recovery.\nHow to prevent it: Include avocados, nuts, and olive oil in your diet.',
          },
          {
            'title': '8. Avoid Overtraining',
            'description':
                'Why it matters: Overtraining can lead to muscle breakdown and burnout.\nHow to prevent it: Listen to your body and take adequate rest days.',
          },
          {
            'title': '9. Perform Warm-Ups and Cool-Downs',
            'description':
                'Why it matters: Warming up prepares muscles and cooling down aids recovery.\nHow to prevent it: Spend 5-10 minutes stretching and performing light movements before and after workouts.',
          },
          {
            'title': '10. Focus on Mind-Muscle Connection',
            'description':
                'Why it matters: Engaging the correct muscles ensures better performance and muscle activation.\nHow to prevent it: Concentrate on each rep and use controlled movements.',
          },
          {
            'title': '11. Incorporate Periodization Training',
            'description':
                'Why it matters: Periodization prevents plateaus and optimizes muscle gains.\nHow to prevent it: Vary intensity and volume over time.',
          },
          {
            'title': '12. Support Recovery with Sleep',
            'description':
                'Why it matters: Muscle repair happens during deep sleep.\nHow to prevent it: Aim for 7-9 hours of quality sleep per night.',
          },
          {
            'title': '13. Use Resistance Bands for Stability Training',
            'description':
                'Why it matters: Stability training improves muscle control and prevents injuries.\nHow to prevent it: Add resistance bands to warm-ups and accessory movements.',
          },
          {
            'title': '14. Stay Consistent',
            'description':
                'Why it matters: Long-term progress requires consistency.\nHow to prevent it: Stick to a structured workout plan and track progress.',
          },
          {
            'title': '15. Monitor Progress and Adjust Accordingly',
            'description':
                'Why it matters: Tracking progress ensures continuous improvements.\nHow to prevent it: Log workouts and adjust intensity, reps, or weights as needed.',
          },
        ],
      ),
      Guide(
        title: "Supporting Recovery",
        imageUrl: AppAssets.sleep,
        description: "Strategies to enhance recovery after workouts.",
        points: [
          {
            'title': '1. Get Enough Sleep',
            'description':
                'Why it matters: Deep sleep is when most muscle recovery occurs.\nHow to prevent it: Maintain a consistent bedtime routine and aim for 7-9 hours of sleep.',
          },
          {
            'title': '2. Stay Hydrated',
            'description':
                'Why it matters: Water supports nutrient transport and muscle repair.\nHow to prevent it: Drink at least 2-3 liters of water daily.',
          },
          {
            'title': '3. Consume Post-Workout Nutrition',
            'description':
                'Why it matters: Protein and carbs replenish energy and repair tissue.\nHow to prevent it: Eat a balanced meal within 30-60 minutes post-exercise.',
          },
          {
            'title': '4. Use Active Recovery',
            'description':
                'Why it matters: Light movement aids blood flow and reduces soreness.\nHow to prevent it: Incorporate activities like walking, yoga, or mobility drills on rest days.',
          },
          {
            'title': '5. Stretch and Foam Roll',
            'description':
                'Why it matters: Helps reduce muscle tightness and improve flexibility.\nHow to prevent it: Spend 10-15 minutes daily on stretching and foam rolling.',
          },
          {
            'title': '6. Manage Stress Levels',
            'description':
                'Why it matters: Chronic stress can slow down muscle repair and increase fatigue.\nHow to prevent it: Practice meditation, deep breathing, and relaxation techniques.',
          },
          {
            'title': '7. Take Rest Days',
            'description':
                'Why it matters: Muscles need time to recover and grow stronger.\nHow to prevent it: Schedule at least one or two rest days per week.',
          },
          {
            'title': '8. Optimize Micronutrient Intake',
            'description':
                'Why it matters: Vitamins and minerals play key roles in recovery.\nHow to prevent it: Consume a variety of fruits, vegetables, and whole foods.',
          },
          {
            'title': '9. Use Ice Baths or Contrast Therapy',
            'description':
                'Why it matters: Helps reduce inflammation and speed up recovery.\nHow to prevent it: Use ice baths or alternate hot and cold therapy after intense workouts.',
          },
          {
            'title': '10. Avoid Overtraining',
            'description':
                'Why it matters: Overworking muscles can lead to burnout and injury.\nHow to prevent it: Listen to your body and adjust your training volume accordingly.',
          },
          {
            'title': '11. Support Recovery with Supplements',
            'description':
                'Why it matters: Certain supplements can aid muscle repair and reduce soreness.\nHow to prevent it: Consider using BCAAs, glutamine, and magnesium.',
          },
          {
            'title': '12. Get Regular Massages',
            'description':
                'Why it matters: Helps release muscle tension and improve circulation.\nHow to prevent it: Schedule deep tissue massages or use a massage gun.',
          },
          {
            'title': '13. Prioritize Good Sleep Hygiene',
            'description':
                'Why it matters: Poor sleep quality can delay muscle repair.\nHow to prevent it: Avoid screens before bed, keep a cool room temperature, and maintain a bedtime routine.',
          },
          {
            'title': '14. Eat Enough Calories',
            'description':
                'Why it matters: Under-eating can slow recovery and hinder muscle growth.\nHow to prevent it: Ensure you consume enough calories to support your activity level.',
          },
          {
            'title': '15. Listen to Your Body',
            'description':
                'Why it matters: Ignoring pain or fatigue can lead to injuries and setbacks.\nHow to prevent it: Pay attention to soreness, adjust workouts as needed, and seek medical advice if necessary.',
          },
        ],
      ),
    ];

    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: ListView.separated(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemCount: guides.length,
        itemBuilder: (context, index) {
          final guide = guides[index];
          return CustomContainer(
            onTap: () {
              Get.to(() => GuideDetail(guide: guide));
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(2),
                  child: SizedBox(
                    width: double.infinity,
                    height: 180, // ✅ fixed height for all images
                    child: Image.asset(
                      guide.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                TextWidget(
                  title: guide.title,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                Text(
                  guide.description,
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          );
        },
        separatorBuilder: (context, index) => SizedBox(height: 16),
      ),
    );
  }
}
