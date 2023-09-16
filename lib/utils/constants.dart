import 'package:jawline_fitness/models/exercise.dart';

class Constants {
  static final level = [
    [
      exercises[0],
      exercises[1],
      exercises[2],
      exercises[3],
      exercises[4],
      exercises[5]
    ],
    [
      exercises[1],
      exercises[3],
      exercises[5],
      exercises[6],
      exercises[7],
      exercises[8]
    ],
    [
      exercises[0],
      exercises[0],
      exercises[0],
      exercises[0],
      exercises[0],
      exercises[0]
    ],
    [
      exercises[0],
      exercises[1],
      exercises[2],
      exercises[3],
      exercises[4],
      exercises[5]
    ],
    [
      exercises[0],
      exercises[1],
      exercises[2],
      exercises[3],
      exercises[4],
      exercises[5]
    ],
    [
      exercises[0],
      exercises[1],
      exercises[2],
      exercises[3],
      exercises[4],
      exercises[5]
    ]
  ];

  static final exercises = [
    Exercise(
      title: "Up & Down Nods",
      description:
          "The Up & Down Nods exercise is designed to enhance neck flexibility and reduce tension in the neck muscles. This exercise is particularly beneficial for individuals who spend prolonged periods in sedentary positions, such as sitting at a desk or using a computer. To perform this exercise, begin by assuming an upright seated or standing posture with your spine aligned. Slowly nod your head forward, lowering your chin towards your chest. Maintain this position for a few seconds, allowing a gentle stretch to develop along the back of your neck. Gradually return your head to the starting position and repeat this up-and-down nodding motion for the specified duration. This exercise helps alleviate neck strain and contributes to better neck mobility.",
      steps: [
        "Start by standing or sitting up straight with your back aligned.",
        "Gently lower your head by nodding it forward, bringing your chin closer to your chest.",
        "Hold this position for a count of 5-10 seconds, feeling a gentle stretch in the back of your neck.",
        "Slowly return your head to the neutral position.",
        "Repeat the nodding motion for the specified duration, aiming for a smooth and controlled movement."
      ],
      duration: 60,
    ),
    Exercise(
      title: "Chin Tucks",
      description:
          "Chin Tucks are an excellent exercise for strengthening the muscles of the neck and improving overall posture. This exercise is especially valuable for individuals who spend extended periods sitting at a desk or using digital devices. The Chin Tucks exercise begins with you sitting or standing in an upright position with your spine correctly aligned. Initiate the exercise by looking straight ahead and gently tucking your chin towards your chest, without tilting your head. Hold this position for a few seconds, experiencing a stretch in the front of your neck. Gradually return your head to its neutral position. To gain the maximum benefit, repeat this movement for the recommended duration. Consistent practice of Chin Tucks can help strengthen the neck muscles and promote better posture.",
      steps: [
        "Sit or stand with your back straight and shoulders relaxed.",
        "Begin by looking straight ahead, maintaining a neutral head position.",
        "Slowly and gently tuck your chin towards your chest, ensuring that your head remains level.",
        "Hold the tucked position for a count of 5-10 seconds, feeling a mild stretch in the front of your neck.",
        "Slowly return your head to the neutral position, keeping the movement controlled and deliberate.",
        "Repeat the Chin Tucks motion for the specified duration, aiming for smooth and controlled repetitions."
      ],
      duration: 60,
    ),
    Exercise(
      title: "Upward Chewing",
      description:
          "Upward Chewing is a valuable exercise to enhance jaw mobility and alleviate tension in the jaw area. Whether you experience jaw discomfort or simply wish to enhance your jaw's range of motion, this exercise can be beneficial. To perform Upward Chewing, sit or stand comfortably with your mouth closed. Begin by slowly moving your lower jaw upward as though you are chewing with your mouth closed. Hold this upward position for a few seconds, sensing a gentle stretch in your jaw. Gradually lower your jaw to its resting position. To reap the full advantages, repeat this chewing action for the recommended duration. Upward Chewing is an effective way to improve jaw mobility and alleviate jaw tension, particularly if you spend prolonged periods speaking or chewing throughout the day.",
      steps: [
        "Sit or stand in a comfortable position with your mouth closed.",
        "Initiate the exercise by gently moving your lower jaw upward as though you are chewing with your mouth closed.",
        "Hold the upward chewing position for a count of 5-10 seconds, feeling a gentle stretch in your jaw muscles.",
        "Slowly lower your jaw back to its resting position.",
        "Repeat the upward chewing motion for the specified duration, focusing on smooth and controlled movements."
      ],
      duration: 60,
    ),
    Exercise(
      title: "Extend Your Tongue",
      description:
          "The Extend Your Tongue exercise is designed to strengthen tongue muscles and enhance tongue mobility. This exercise can be particularly beneficial for individuals looking to improve their tongue control or address speech-related concerns. To perform this exercise, sit with your back straight and shoulders relaxed. Open your mouth comfortably and extend your tongue as far as you can out of your mouth. Hold this extended position for a count of 5-10 seconds, then gently return your tongue to the inside of your mouth. To maximize the benefits, repeat this extension movement for the recommended duration. Regular practice of Extend Your Tongue can help enhance tongue strength and control.",
      steps: [
        "Sit with your back straight and shoulders relaxed.",
        "Open your mouth comfortably.",
        "Extend your tongue as far as possible out of your mouth.",
        "Hold this extended position for a count of 5-10 seconds, feeling a gentle stretch and contraction in your tongue muscles.",
        "Slowly and gently return your tongue to the inside of your mouth.",
        "Repeat the tongue extension motion for the specified duration, aiming for smooth and controlled movements."
      ],
      duration: 60,
    ),
    Exercise(
      title: "Open Mouth Widely",
      description:
          "Open Mouth Widely is a simple yet effective exercise to enhance jaw flexibility and mobility. Whether you experience jaw stiffness or want to maintain optimal jaw function, this exercise can be valuable. To perform Open Mouth Widely, sit or stand with your back straight. Open your mouth as wide as possible without causing discomfort. Hold this wide-open position for a count of 5-10 seconds, then slowly close your mouth back to the starting position. To gain the most from this exercise, repeat the wide opening movement for the recommended duration. Regular practice of Open Mouth Widely can contribute to improved jaw mobility and comfort.",
      steps: [
        "Sit or stand with your back straight.",
        "Initiate the exercise by opening your mouth as wide as you can, without causing any discomfort or pain.",
        "Hold the wide-open position for a count of 5-10 seconds, feeling a stretch in your jaw muscles.",
        "Slowly and gently close your mouth back to the starting position.",
        "Repeat the wide opening movement for the specified duration, focusing on smooth and controlled movements."
      ],
      duration: 60,
    ),
    Exercise(
      title: "Massage Your Face",
      description:
          "Face Massage is a relaxing exercise that can alleviate tension in facial muscles and promote overall facial comfort. It's an excellent practice for individuals experiencing facial stiffness or simply seeking a soothing facial routine. To perform this exercise, use your fingertips to gently massage your forehead in circular motions. Continue by moving your fingertips to your temples and massaging in circular motions. Extend the massage to your cheeks, jawline, and neck, applying light to moderate pressure as needed. Perform the massage for the recommended duration, enjoying the relaxation and relief it provides. Regular Face Massage can be a beneficial addition to your daily self-care routine.",
      steps: [
        "Using your fingertips, gently massage your forehead in circular motions, starting from the center and moving outward.",
        "Continue by moving your fingertips to your temples and massaging in circular motions.",
        "Extend the massage to your cheeks, applying gentle circular motions to alleviate tension.",
        "Move your fingertips down to your jawline and continue with circular motions.",
        "Finish by massaging your neck, applying light to moderate pressure as needed.",
        "Perform the face massage for the specified duration, focusing on relaxation and comfort."
      ],
      duration: 60,
    ),
    Exercise(
      title: "Mouthwash Exercise",
      description:
          "The Mouthwash Exercise involves mouth movements that can help improve oral muscle coordination and comfort. Whether you're looking to enhance your oral muscle control or simply relax your facial muscles, this exercise is beneficial. To perform the Mouthwash Exercise, sit or stand comfortably with your back straight. Imagine you have mouthwash in your mouth and gently swish the imaginary mouthwash around your mouth for the recommended duration. Ensure that your cheeks, lips, and tongue are actively involved in the swishing motion. Regular practice of the Mouthwash Exercise can contribute to improved oral muscle coordination.",
      steps: [
        "Sit or stand comfortably with your back straight.",
        "Imagine you have mouthwash in your mouth.",
        "Initiate the exercise by gently swishing the imaginary mouthwash around your mouth.",
        "Ensure that your cheeks, lips, and tongue are actively involved in the swishing motion.",
        "Perform the swishing motion for the specified duration, focusing on coordinated and controlled movements."
      ],
      duration: 60,
    ),
    Exercise(
      title: "Tilt your Head Left & Right",
      description:
          "Tilting your Head Left & Right is a neck exercise that promotes neck flexibility and mobility. This exercise is particularly beneficial for individuals seeking to reduce neck stiffness and enhance neck range of motion. To perform this exercise, stand or sit with your spine properly aligned. Begin by slowly tilting your head to the left side, bringing your left ear towards your left shoulder. Hold this position for a count of 5-10 seconds, feeling a gentle stretch on the right side of your neck. Gradually return your head to the upright position. Next, tilt your head to the right side, bringing your right ear towards your right shoulder. Hold this position for a count of 5-10 seconds. To experience the full benefits, repeat this left and right tilting motion for the recommended duration. Consistent practice can help alleviate neck discomfort and enhance neck mobility.",
      steps: [
        "Stand or sit with your spine aligned.",
        "Start by slowly tilting your head to the left side, bringing your left ear toward your left shoulder.",
        "Hold the tilted position for a count of 5-10 seconds, feeling a gentle stretch on the right side of your neck.",
        "Slowly return your head to the upright position.",
        "Next, tilt your head to the right side, bringing your right ear toward your right shoulder.",
        "Hold the tilted position for a count of 5-10 seconds, experiencing a gentle stretch on the left side of your neck.",
        "Repeat the left and right tilting motion for the specified duration, focusing on controlled and deliberate movements."
      ],
      duration: 60,
    ),
    Exercise(
      title: "Pushing The Tongue Outward",
      description:
          "Pushing the Tongue Outward is an exercise designed to strengthen tongue muscles and improve tongue control. This exercise is particularly useful for individuals looking to enhance their tongue's range of motion and control, which can have various benefits, including improved speech and swallowing. To perform this exercise, sit or stand comfortably with your mouth closed. Gently push your tongue against the roof of your mouth, pushing it outward as far as possible. Hold this outward position for a count of 5-10 seconds, feeling a mild contraction in your tongue muscles. Slowly and gently return your tongue to the inside of your mouth. To maximize the benefits, repeat this outward tongue-pushing movement for the recommended duration. Consistent practice of Pushing the Tongue Outward can help improve tongue strength and control, contributing to better oral function.",
      steps: [
        "Sit or stand comfortably with your mouth closed.",
        "Initiate the exercise by gently pushing your tongue against the roof of your mouth, pushing it outward as far as possible.",
        "Hold the outward position for a count of 5-10 seconds, feeling a mild contraction in your tongue muscles.",
        "Slowly and gently return your tongue to the inside of your mouth.",
        "Repeat the outward tongue-pushing movement for the specified duration, focusing on smooth and controlled motions."
      ],
      duration: 60,
    ),
  ];
  static const steps = [
    {
      "heading": "Welcome",
      "description":
          "Tell us about yourself for a more personalised exercise plan",
    },
    {
      "heading": "Gender",
      "description": "Helps in customising a plan",
    },
    {
      "heading": "Name",
      "description": "Preferably a nick name",
    },
    {
      "heading": "Age",
      "description": "Helps in adjusting exercise intensity",
    },
    {
      "heading": "Reminder",
      "description": "Achievement comes with discipline",
    },
  ];
}
