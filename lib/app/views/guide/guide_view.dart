import '../../utils/constants/assets.dart';
import '../../utils/helpers/app_size.dart';
import '../../widgets/container/custom_app_bar.dart';
import '../../widgets/text/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/models/guides.dart';
import '../../routes/app_routes.dart';
import '../../widgets/container/custom_container.dart';
import 'guide_detail.dart';

class GuideView extends StatelessWidget {
   GuideView({super.key});
  final List<Guide> guides = [
    Guide(
      title: "Increase Muscle Growth",
      imageUrl: AppAssets.coverImage,
      description: "Learn how to effectively increase muscle mass.",
      points: [
        {
          'title': '1. Prioritize Protein Intake',
          'description': 'Why it matters: Protein is essential for muscle repair and growth.\nHow to do it: Eat protein-rich foods and distribute intake evenly throughout the day.',
        },
        {
          'title': '2. Strength Train Efficiently',
          'description': 'Why it matters: Promotes hypertrophy and prevents muscle loss.\nHow to do it: Focus on compound movements and progressive overload.',
        },
        {
          'title': '3. Optimize Hydration & Electrolytes',
          'description': 'Why it matters: Dehydration leads to cramps and fatigue.\nHow to do it: Drink water regularly and replenish electrolytes like sodium and potassium.',
        },
        {
          'title': '4. Leverage Key Supplements',
          'description': 'Why it matters: Enhance strength and recovery.\nHow to do it: Use creatine, beta-alanine, and BCAAs.',
        },
        {
          'title': '5. Improve Mobility & Recovery',
          'description': 'Why it matters: Poor mobility increases injury risk.\nHow to do it: Stretch, foam roll, and practice yoga.',
        },
        {
          'title': '6. Maintain Proper Form',
          'description': 'Why it matters: Prevents injuries and imbalances.\nHow to do it: Learn technique and use a spotter.',
        },
        {
          'title': '7. Get Enough Healthy Fats',
          'description': 'Why it matters: Supports hormone production and recovery.\nHow to do it: Include avocados, nuts, olive oil.',
        },
        {
          'title': '8. Avoid Overtraining',
          'description': 'Why it matters: Overtraining leads to muscle breakdown.\nHow to do it: Take rest days and listen to your body.',
        },
        {
          'title': '9. Perform Warm-Ups and Cool-Downs',
          'description': 'Why it matters: Prepares muscles and aids recovery.\nHow to do it: Spend 5–10 mins before and after workouts.',
        },
        {
          'title': '10. Focus on Mind-Muscle Connection',
          'description': 'Why it matters: Better performance and activation.\nHow to do it: Concentrate on each rep with control.',
        },
        {
          'title': '11. Incorporate Periodization Training',
          'description': 'Why it matters: Prevents plateaus and optimizes gains.\nHow to do it: Vary intensity and volume regularly.',
        },
        {
          'title': '12. Support Recovery with Sleep',
          'description': 'Why it matters: Muscles repair during sleep.\nHow to do it: Get 7–9 hours of quality sleep nightly.',
        },
        {
          'title': '13. Use Resistance Bands for Stability',
          'description': 'Why it matters: Improves control and prevents injury.\nHow to do it: Add bands to warm-ups and accessories.',
        },
        {
          'title': '14. Stay Consistent',
          'description': 'Why it matters: Long-term progress needs consistency.\nHow to do it: Stick to a structured workout plan.',
        },
        {
          'title': '15. Monitor Progress and Adjust Accordingly',
          'description': 'Why it matters: Ensures continuous improvement.\nHow to do it: Log workouts, adjust reps/weights.',
        },
      ],
    ),
    Guide(
      title: "Reduce Stress",
      imageUrl: AppAssets.coverImage,
      description: "A guide to reducing stress for better health and fitness.",
      points: [
        {
          'title': '1. Practice Mindfulness',
          'description': 'Reduces anxiety and enhances clarity.\nUse breathing techniques or guided meditations.',
        },
        {
          'title': '2. Exercise Regularly',
          'description': 'Releases endorphins and reduces tension.\nEngage in cardio, yoga, or strength training.',
        },
        {
          'title': '3. Prioritize Sleep',
          'description': 'Poor sleep increases cortisol.\nEstablish a calming bedtime routine.',
        },
        {
          'title': '4. Connect with Supportive People',
          'description': 'Talking reduces stress.\nReach out to friends, family, or professionals.',
        },
        {
          'title': '5. Limit Stimulants & Alcohol',
          'description': 'Caffeine and alcohol affect mood.\nOpt for water or herbal teas instead.',
        },
        {
          'title': '6. Establish Boundaries',
          'description': 'Avoid burnout from overcommitment.\nLearn to say no and take breaks.',
        },
        {
          'title': '7. Practice Gratitude',
          'description': 'Focusing on positives boosts mindset.\nJournal three things you’re thankful for.',
        },
        {
          'title': '8. Spend Time in Nature',
          'description': 'Nature promotes relaxation.\nTake a walk in a park or hike outdoors.',
        },
        {
          'title': '9. Listen to Calming Music',
          'description': 'Music reduces cortisol.\nCreate a stress-relief playlist.',
        },
      ],
    ),
    Guide(
      title: "Nutrition for Fitness",
      imageUrl: AppAssets.coverImage,
      description: "Understanding the right nutrition for your fitness goals.",
      points: [
        {
          'title': '1. Eat Whole, Nutrient-Dense Foods',
          'description': 'Provide vitamins and minerals for recovery.\nChoose fruits, vegetables, lean proteins, and whole grains.',
        },
        {
          'title': '2. Balance Macronutrients',
          'description': 'Fuel your body efficiently.\nAdjust protein, fats, and carbs to your goals.',
        },
        {
          'title': '3. Time Your Meals',
          'description': 'Support energy and recovery.\nEat carbs pre-workout and protein post-workout.',
        },
        {
          'title': '4. Stay Hydrated',
          'description': 'Hydration affects performance.\nDrink water throughout the day.',
        },
        {
          'title': '5. Avoid Processed Foods',
          'description': 'They add empty calories.\nChoose natural, minimally processed items.',
        },
        {
          'title': '6. Consider Supplementation',
          'description': 'Fill gaps if needed.\nExamples: protein powder, omega-3s, multivitamins.',
        },
        {
          'title': '7. Track Your Intake',
          'description': 'Awareness helps progress.\nUse apps to log meals and macros.',
        },
        {
          'title': '8. Be Consistent, Not Perfect',
          'description': 'Adherence over time matters.\nAllow flexibility with a mostly clean diet.',
        },
      ],
    ),
    Guide(
      title: "Strength Training Basics",
      imageUrl: AppAssets.coverImage,
      description: "Beginner's guide to strength training and weightlifting.",
      points: [
        {
          'title': '1. Learn Proper Technique',
          'description': 'Avoid injuries.\nStart with bodyweight movements and use mirrors or a coach.',
        },
        {
          'title': '2. Start with Compound Exercises',
          'description': 'Build strength efficiently.\nFocus on squats, deadlifts, presses, and rows.',
        },
        {
          'title': '3. Train Major Muscle Groups',
          'description': 'Balanced development.\nWork legs, back, chest, core, and shoulders.',
        },
        {
          'title': '4. Begin with Low Weights',
          'description': 'Focus on control.\nIncrease gradually as you get stronger.',
        },
        {
          'title': '5. Use a Structured Program',
          'description': 'Stay on track.\nFollow beginner plans like 5x5 or full-body splits.',
        },
        {
          'title': '6. Rest Between Sets',
          'description': 'Allows recovery.\nRest 60–90 seconds between sets.',
        },
        {
          'title': '7. Prioritize Recovery',
          'description': 'Muscles grow while resting.\nSleep well and avoid overtraining.',
        },
        {
          'title': '8. Track Your Progress',
          'description': 'Measure improvement.\nKeep a workout log or use an app.',
        },
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: "Guides"),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: ListView.separated(
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
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(guide.imageUrl, fit: BoxFit.cover),
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
      ),
    );
  }
}
