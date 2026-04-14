import 'package:flutter/material.dart';
import '../models/restaurant.dart';
import '../models/restaurant_item.dart';
import '../models/food_category.dart';
import '../models/post.dart';
import '../models/explore_data.dart';

class MockFitnessService {
  Future<ExploreData> getExploreData() async {
    await Future.delayed(const Duration(milliseconds: 500));

    final gymMemberships = [
      const MembershipPlan(
        name: 'Basic Access',
        price: 29.99,
        description: 'Gym floor and cardio equipment',
        duration: 'Monthly',
        imageUrl:
            'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?w=300&h=300&fit=crop',
      ),
      const MembershipPlan(
        name: 'Premium',
        price: 49.99,
        description: 'Full access + group classes',
        duration: 'Monthly',
        imageUrl:
            'https://images.unsplash.com/photo-1571902943202-507ec2618e8f?w=300&h=300&fit=crop',
      ),
      const MembershipPlan(
        name: 'VIP',
        price: 79.99,
        description: 'All access + personal trainer',
        duration: 'Monthly',
        imageUrl:
            'https://images.unsplash.com/photo-1581009146145-b5ef050c149a?w=300&h=300&fit=crop',
      ),
      const MembershipPlan(
        name: 'Day Pass',
        price: 15.00,
        description: 'Single day full access',
        duration: 'Day',
        imageUrl:
            'https://images.unsplash.com/photo-1540497077202-7c8a3999166f?w=300&h=300&fit=crop',
      ),
      const MembershipPlan(
        name: 'Annual',
        price: 399.99,
        description: 'Best value - save 30%',
        duration: 'Yearly',
        imageUrl:
            'https://images.unsplash.com/photo-1576678927484-cc907957088c?w=300&h=300&fit=crop',
      ),
      const MembershipPlan(
        name: 'Student',
        price: 24.99,
        description: 'Valid student ID required',
        duration: 'Monthly',
        imageUrl:
            'https://images.unsplash.com/photo-1517836357463-d25dfeac3438?w=300&h=300&fit=crop',
      ),
    ];

    final yogaMemberships = [
      const MembershipPlan(
        name: 'Drop-In Class',
        price: 20.00,
        description: 'Single class access',
        duration: 'Per Class',
        imageUrl:
            'https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?w=300&h=300&fit=crop',
      ),
      const MembershipPlan(
        name: 'Unlimited Monthly',
        price: 89.99,
        description: 'Unlimited yoga classes',
        duration: 'Monthly',
        imageUrl:
            'https://images.unsplash.com/photo-1506126613408-eca07ce68773?w=300&h=300&fit=crop',
      ),
      const MembershipPlan(
        name: '10 Class Pack',
        price: 150.00,
        description: 'Valid for 3 months',
        duration: '3 Months',
        imageUrl:
            'https://images.unsplash.com/photo-1575052814086-f385e2e2ad1b?w=300&h=300&fit=crop',
      ),
      const MembershipPlan(
        name: 'Beginner Package',
        price: 59.99,
        description: '4 intro classes + mat rental',
        duration: 'Monthly',
        imageUrl:
            'https://images.unsplash.com/photo-1518611012118-696072aa579a?w=300&h=300&fit=crop',
      ),
      const MembershipPlan(
        name: 'Private Session',
        price: 75.00,
        description: 'One-on-one instruction',
        duration: 'Per Session',
        imageUrl:
            'https://images.unsplash.com/photo-1510894347713-fc3ed6fdf539?w=300&h=300&fit=crop',
      ),
      const MembershipPlan(
        name: 'Couples Yoga',
        price: 45.00,
        description: 'Partner yoga session',
        duration: 'Per Session',
        imageUrl:
            'https://images.unsplash.com/photo-1599901860904-17e6ed7083a0?w=300&h=300&fit=crop',
      ),
    ];

    final cyclingMemberships = [
      const MembershipPlan(
        name: 'Single Ride',
        price: 25.00,
        description: 'One spin class',
        duration: 'Per Class',
        imageUrl:
            'https://images.unsplash.com/photo-1517649763962-0c623066013b?w=300&h=300&fit=crop',
      ),
      const MembershipPlan(
        name: 'Unlimited Rides',
        price: 149.99,
        description: 'Unlimited monthly cycling',
        duration: 'Monthly',
        imageUrl:
            'https://images.unsplash.com/photo-1517649763962-0c623066013b?w=300&h=300&fit=crop',
      ),
      const MembershipPlan(
        name: '20 Ride Pack',
        price: 350.00,
        description: 'Best value for regulars',
        duration: '6 Months',
        imageUrl:
            'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=300&h=300&fit=crop',
      ),
      const MembershipPlan(
        name: 'First Timer',
        price: 15.00,
        description: 'Intro rate for new riders',
        duration: 'First Class',
        imageUrl:
            'https://images.unsplash.com/photo-1520877880798-5ee004e3f11e?w=300&h=300&fit=crop',
      ),
      const MembershipPlan(
        name: 'Premium Member',
        price: 199.99,
        description: 'Priority booking + gear',
        duration: 'Monthly',
        imageUrl:
            'https://images.unsplash.com/photo-1594882645126-14020914d58d?w=300&h=300&fit=crop',
      ),
      const MembershipPlan(
        name: 'Corporate',
        price: 99.99,
        description: 'Group rates available',
        duration: 'Monthly',
        imageUrl:
            'https://images.unsplash.com/photo-1571019614242-c5c5dee9f50b?w=300&h=300&fit=crop',
      ),
    ];

    final boxingMemberships = [
      const MembershipPlan(
        name: 'Trial Class',
        price: 10.00,
        description: 'First class special',
        duration: 'First Class',
        imageUrl:
            'https://images.unsplash.com/photo-1549719386-74dfcbf7dbed?w=300&h=300&fit=crop',
      ),
      const MembershipPlan(
        name: 'Basic Boxing',
        price: 79.99,
        description: 'Group classes + bag work',
        duration: 'Monthly',
        imageUrl:
            'https://images.unsplash.com/photo-1517438322307-e67111335449?w=300&h=300&fit=crop',
      ),
      const MembershipPlan(
        name: 'Fighter Program',
        price: 149.99,
        description: 'Intensive training + sparring',
        duration: 'Monthly',
        imageUrl:
            'https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?w=300&h=300&fit=crop',
      ),
      const MembershipPlan(
        name: 'Personal Training',
        price: 85.00,
        description: 'One-on-one boxing session',
        duration: 'Per Session',
        imageUrl:
            'https://images.unsplash.com/photo-1550259979-ed79b48d2a89?w=300&h=300&fit=crop',
      ),
      const MembershipPlan(
        name: 'Kids Boxing',
        price: 59.99,
        description: 'Ages 8-14, twice weekly',
        duration: 'Monthly',
        imageUrl:
            'https://images.unsplash.com/photo-1517438476312-10d79c077509?w=300&h=300&fit=crop',
      ),
      const MembershipPlan(
        name: 'Women Only',
        price: 69.99,
        description: 'Ladies boxing classes',
        duration: 'Monthly',
        imageUrl:
            'https://images.unsplash.com/photo-1517438476312-10d79c077509?w=300&h=300&fit=crop',
      ),
    ];

    final poolMemberships = [
      const MembershipPlan(
        name: 'Day Swim',
        price: 12.00,
        description: 'Single day pool access',
        duration: 'Day',
        imageUrl:
            'https://images.unsplash.com/photo-1576013551627-0cc20b96c2a7?w=300&h=300&fit=crop',
      ),
      const MembershipPlan(
        name: 'Monthly Swim',
        price: 45.99,
        description: 'Unlimited pool access',
        duration: 'Monthly',
        imageUrl:
            'https://images.unsplash.com/photo-1560090995-01632a28895b?w=300&h=300&fit=crop',
      ),
      const MembershipPlan(
        name: 'Swim Lessons',
        price: 120.00,
        description: '8 group lessons',
        duration: '2 Months',
        imageUrl:
            'https://images.unsplash.com/photo-1530549387789-4c1017266635?w=300&h=300&fit=crop',
      ),
      const MembershipPlan(
        name: 'Aqua Fitness',
        price: 55.99,
        description: 'Water aerobics classes',
        duration: 'Monthly',
        imageUrl:
            'https://images.unsplash.com/photo-1575429198097-0414ec08e8cd?w=300&h=300&fit=crop',
      ),
      const MembershipPlan(
        name: 'Family Pass',
        price: 89.99,
        description: 'Up to 4 family members',
        duration: 'Monthly',
        imageUrl:
            'https://images.unsplash.com/photo-1519315901367-f34ff9154487?w=300&h=300&fit=crop',
      ),
      const MembershipPlan(
        name: 'Private Lane',
        price: 25.00,
        description: 'Reserved lane for 1 hour',
        duration: 'Per Hour',
        imageUrl:
            'https://images.unsplash.com/photo-1576013551627-0cc20b96c2a7?w=300&h=300&fit=crop',
      ),
    ];

    final crossfitMemberships = [
      const MembershipPlan(
        name: 'Intro Month',
        price: 99.00,
        description: 'Foundations + unlimited WODs',
        duration: 'First Month',
        imageUrl:
            'https://images.unsplash.com/photo-1526506118085-60ce8714f8c5?w=300&h=300&fit=crop',
      ),
      const MembershipPlan(
        name: 'Unlimited',
        price: 175.00,
        description: 'All classes, all times',
        duration: 'Monthly',
        imageUrl:
            'https://images.unsplash.com/photo-1534258936925-c58bed479fcb?w=300&h=300&fit=crop',
      ),
      const MembershipPlan(
        name: '3x Week',
        price: 135.00,
        description: '3 classes per week',
        duration: 'Monthly',
        imageUrl:
            'https://images.unsplash.com/photo-1541534741688-6078c6bfb5c5?w=300&h=300&fit=crop',
      ),
      const MembershipPlan(
        name: 'Open Gym',
        price: 75.00,
        description: 'Equipment access only',
        duration: 'Monthly',
        imageUrl:
            'https://images.unsplash.com/photo-1533681904393-9ab6eee7e408?w=300&h=300&fit=crop',
      ),
      const MembershipPlan(
        name: 'Competition',
        price: 225.00,
        description: 'Advanced athletes program',
        duration: 'Monthly',
        imageUrl:
            'https://images.unsplash.com/photo-1526506118085-60ce8714f8c5?w=300&h=300&fit=crop',
      ),
      const MembershipPlan(
        name: 'Drop-In',
        price: 30.00,
        description: 'Single class for visitors',
        duration: 'Per Class',
        imageUrl:
            'https://images.unsplash.com/photo-1534258936925-c58bed479fcb?w=300&h=300&fit=crop',
      ),
    ];

    final fitnessCenters = [
      FitnessCenter(
        name: 'Iron Paradise Gym',
        sportType: 'Gym',
        rating: 4.8,
        openingHours: '5AM - 11PM',
        membershipPrice: '\$29.99/mo',
        isOpen: true,
        imageUrl:
            'https://images.unsplash.com/photo-1517836357463-d25dfeac3438?w=400&h=300&fit=crop',
        address: '123 Fitness Ave, Downtown',
        distance: 1.2,
        memberships: gymMemberships,
      ),
      FitnessCenter(
        name: 'Atlas Performance Club',
        sportType: 'Gym',
        rating: 4.9,
        openingHours: '24/7',
        membershipPrice: '\$39.99/mo',
        isOpen: true,
        imageUrl:
            'https://images.unsplash.com/photo-1534258936925-c58bed479fcb?w=400&h=300&fit=crop',
        address: '18 Summit Street, Financial District',
        distance: 2.4,
        memberships: gymMemberships,
      ),
      FitnessCenter(
        name: 'Pulse District Gym',
        sportType: 'Gym',
        rating: 4.7,
        openingHours: '6AM - 10PM',
        membershipPrice: '\$34.99/mo',
        isOpen: true,
        imageUrl:
            'https://images.unsplash.com/photo-1571902943202-507ec2618e8f?w=400&h=300&fit=crop',
        address: '77 Riverfront Blvd, South Bank',
        distance: 3.1,
        memberships: gymMemberships,
      ),
      FitnessCenter(
        name: 'Zen Yoga Studio',
        sportType: 'Yoga',
        rating: 4.9,
        openingHours: '6AM - 9PM',
        membershipPrice: '\$89.99/mo',
        isOpen: true,
        imageUrl:
            'https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?w=400&h=300&fit=crop',
        address: '456 Wellness Blvd, Midtown',
        distance: 2.1,
        memberships: yogaMemberships,
      ),
      FitnessCenter(
        name: 'Soma Flow Loft',
        sportType: 'Yoga',
        rating: 4.8,
        openingHours: '7AM - 8PM',
        membershipPrice: '\$79.99/mo',
        isOpen: true,
        imageUrl:
            'https://images.unsplash.com/photo-1506126613408-eca07ce68773?w=400&h=300&fit=crop',
        address: '12 Serenity Lane, Old Town',
        distance: 1.6,
        memberships: yogaMemberships,
      ),
      FitnessCenter(
        name: 'Sunrise Yoga House',
        sportType: 'Yoga',
        rating: 4.7,
        openingHours: '6:30AM - 7PM',
        membershipPrice: '\$69.99/mo',
        isOpen: false,
        imageUrl:
            'https://images.unsplash.com/photo-1518611012118-696072aa579a?w=400&h=300&fit=crop',
        address: '5 Garden Square, East Village',
        distance: 2.9,
        memberships: yogaMemberships,
      ),
      FitnessCenter(
        name: 'SpinCycle Studio',
        sportType: 'Cycling',
        rating: 4.7,
        openingHours: '5:30AM - 8PM',
        membershipPrice: '\$149.99/mo',
        isOpen: true,
        imageUrl:
            'https://images.unsplash.com/photo-1517649763962-0c623066013b?w=400&h=300&fit=crop',
        address: '789 Cardio Lane, Uptown',
        distance: 0.8,
        memberships: cyclingMemberships,
      ),
      FitnessCenter(
        name: 'Velo Pulse Studio',
        sportType: 'Cycling',
        rating: 4.8,
        openingHours: '6AM - 9PM',
        membershipPrice: '\$139.99/mo',
        isOpen: true,
        imageUrl:
            'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=400&h=300&fit=crop',
        address: '245 Motion Ave, Central City',
        distance: 1.4,
        memberships: cyclingMemberships,
      ),
      FitnessCenter(
        name: 'Night Ride Lab',
        sportType: 'Cycling',
        rating: 4.6,
        openingHours: '7AM - 10PM',
        membershipPrice: '\$129.99/mo',
        isOpen: true,
        imageUrl:
            'https://images.unsplash.com/photo-1594882645126-14020914d58d?w=400&h=300&fit=crop',
        address: '62 Neon Street, West Market',
        distance: 2.3,
        memberships: cyclingMemberships,
      ),
      FitnessCenter(
        name: 'Champions Boxing Club',
        sportType: 'Boxing',
        rating: 4.6,
        openingHours: '6AM - 10PM',
        membershipPrice: '\$79.99/mo',
        isOpen: false,
        imageUrl:
            'https://images.unsplash.com/photo-1549719386-74dfcbf7dbed?w=400&h=300&fit=crop',
        address: '321 Fighter St, Westside',
        distance: 3.5,
        memberships: boxingMemberships,
      ),
      FitnessCenter(
        name: 'Uppercut Arena',
        sportType: 'Boxing',
        rating: 4.8,
        openingHours: '5AM - 11PM',
        membershipPrice: '\$89.99/mo',
        isOpen: true,
        imageUrl:
            'https://images.unsplash.com/photo-1517438322307-e67111335449?w=400&h=300&fit=crop',
        address: '93 Victory Road, Midtown West',
        distance: 1.7,
        memberships: boxingMemberships,
      ),
      FitnessCenter(
        name: 'Eastside Fight Lab',
        sportType: 'Boxing',
        rating: 4.7,
        openingHours: '6AM - 9PM',
        membershipPrice: '\$84.99/mo',
        isOpen: true,
        imageUrl:
            'https://images.unsplash.com/photo-1550259979-ed79b48d2a89?w=400&h=300&fit=crop',
        address: '201 Ring Avenue, Eastside',
        distance: 2.6,
        memberships: boxingMemberships,
      ),
      FitnessCenter(
        name: 'Aqua Life Center',
        sportType: 'Pool',
        rating: 4.5,
        openingHours: '6AM - 9PM',
        membershipPrice: '\$45.99/mo',
        isOpen: true,
        imageUrl:
            'https://images.unsplash.com/photo-1576013551627-0cc20b96c2a7?w=400&h=300&fit=crop',
        address: '654 Splash Dr, Eastside',
        distance: 2.8,
        memberships: poolMemberships,
      ),
      FitnessCenter(
        name: 'Blue Wave Aquatics',
        sportType: 'Pool',
        rating: 4.8,
        openingHours: '5:30AM - 9PM',
        membershipPrice: '\$59.99/mo',
        isOpen: true,
        imageUrl:
            'https://images.unsplash.com/photo-1560090995-01632a28895b?w=400&h=300&fit=crop',
        address: '44 Marina Point, Lakeside',
        distance: 1.5,
        memberships: poolMemberships,
      ),
      FitnessCenter(
        name: 'Harbor Swim Club',
        sportType: 'Pool',
        rating: 4.6,
        openingHours: '7AM - 8PM',
        membershipPrice: '\$49.99/mo',
        isOpen: false,
        imageUrl:
            'https://images.unsplash.com/photo-1530549387789-4c1017266635?w=400&h=300&fit=crop',
        address: '16 Coastline Rd, Harbor Quarter',
        distance: 3.3,
        memberships: poolMemberships,
      ),
      FitnessCenter(
        name: 'CrossFit Revolution',
        sportType: 'CrossFit',
        rating: 4.8,
        openingHours: '5AM - 9PM',
        membershipPrice: '\$175/mo',
        isOpen: true,
        imageUrl:
            'https://images.unsplash.com/photo-1526506118085-60ce8714f8c5?w=400&h=300&fit=crop',
        address: '987 Power Blvd, Northside',
        distance: 1.9,
        memberships: crossfitMemberships,
      ),
      FitnessCenter(
        name: 'Forge Functional Club',
        sportType: 'CrossFit',
        rating: 4.9,
        openingHours: '5AM - 10PM',
        membershipPrice: '\$189/mo',
        isOpen: true,
        imageUrl:
            'https://images.unsplash.com/photo-1541534741688-6078c6bfb5c5?w=400&h=300&fit=crop',
        address: '29 Foundry Street, Warehouse District',
        distance: 1.1,
        memberships: crossfitMemberships,
      ),
      FitnessCenter(
        name: 'Apex WOD House',
        sportType: 'CrossFit',
        rating: 4.7,
        openingHours: '6AM - 9PM',
        membershipPrice: '\$169/mo',
        isOpen: true,
        imageUrl:
            'https://images.unsplash.com/photo-1533681904393-9ab6eee7e408?w=400&h=300&fit=crop',
        address: '310 Titanium Way, North Loop',
        distance: 2.2,
        memberships: crossfitMemberships,
      ),
    ];

    final categories = [
      const SportCategory(
        name: 'Yoga',
        icon: Icons.self_improvement,
        color: Colors.purple,
        centerCount: 15,
        imageUrl:
            'https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?w=200&h=200&fit=crop',
      ),
      const SportCategory(
        name: 'Gym',
        icon: Icons.fitness_center,
        color: Colors.orange,
        centerCount: 28,
        imageUrl:
            'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?w=200&h=200&fit=crop',
      ),
      const SportCategory(
        name: 'Cycling',
        icon: Icons.directions_bike,
        color: Colors.blue,
        centerCount: 12,
        imageUrl:
            'https://images.unsplash.com/photo-1517649763962-0c623066013b?w=200&h=200&fit=crop',
      ),
      const SportCategory(
        name: 'Boxing',
        icon: Icons.sports_mma,
        color: Colors.red,
        centerCount: 8,
        imageUrl:
            'https://images.unsplash.com/photo-1549719386-74dfcbf7dbed?w=200&h=200&fit=crop',
      ),
      const SportCategory(
        name: 'Pool',
        icon: Icons.pool,
        color: Colors.cyan,
        centerCount: 10,
        imageUrl:
            'https://images.unsplash.com/photo-1576013551627-0cc20b96c2a7?w=200&h=200&fit=crop',
      ),
      const SportCategory(
        name: 'CrossFit',
        icon: Icons.sports_gymnastics,
        color: Colors.green,
        centerCount: 6,
        imageUrl:
            'https://images.unsplash.com/photo-1526506118085-60ce8714f8c5?w=200&h=200&fit=crop',
      ),
    ];

    final friendPosts = [
      const Post(
        title: 'Amazing Yoga Session!',
        description:
            'Just finished an incredible hot yoga class at Zen Yoga Studio. The instructor was so attentive and the atmosphere was perfect for relaxation!',
        author: 'Sarah M.',
        date: 'Today',
        icon: Icons.self_improvement,
        avatarUrl: 'images/e3dcd545b8b34d404217b5da7bcf9775.jpg',
      ),
      const Post(
        title: 'New PR at the Gym!',
        description:
            'Hit a new personal record on deadlift at Iron Paradise! The equipment is top-notch and the trainers really push you to do your best.',
        author: 'Mike R.',
        date: 'Yesterday',
        icon: Icons.fitness_center,
        avatarUrl: 'images/a8898449b7db9a021a187a5006e2ee43.jpg',
      ),
      const Post(
        title: 'First Boxing Class Done!',
        description:
            'Finally tried boxing at Champions Boxing Club. What a workout! My arms are sore but I feel amazing. Definitely coming back for more.',
        author: 'Emma L.',
        date: '2 days ago',
        icon: Icons.sports_mma,
        avatarUrl: 'images/028b5f12160c4a23a9c3b6ec8e2375dc.jpg',
      ),
      const Post(
        title: 'Morning Swim Routine',
        description:
            'Started my day with laps at Aqua Life Center. The pool is so clean and the early morning crowd is super friendly. Great way to start the day!',
        author: 'David K.',
        date: '3 days ago',
        icon: Icons.pool,
        avatarUrl: 'images/8b696d542e16dca8853562c352d55438.jpg',
      ),
      const Post(
        title: 'Sunrise Pilates Flow',
        description:
            'Took a calm mobility class before work and it completely changed my energy for the day. Sunrise Yoga House has such a peaceful vibe.',
        author: 'Amina T.',
        date: '3 days ago',
        icon: Icons.self_improvement,
        avatarUrl: 'images/906a3198743a04accdc38e6a83a4d68b.jpg',
      ),
      const Post(
        title: 'Leg Day Success',
        description:
            'Atlas Performance Club was packed with great energy tonight. New squat PR and the recovery zone afterward felt amazing.',
        author: 'Nikolai P.',
        date: '4 days ago',
        icon: Icons.fitness_center,
        avatarUrl: 'images/03b5aec90fc8a188cc55e973ac323401.jpg',
      ),
      const Post(
        title: 'Best Spin Playlist Ever',
        description:
            'Velo Pulse Studio had a playlist that made the whole ride fly by. Intense intervals, cool lights, and such a motivating coach.',
        author: 'Leila S.',
        date: '4 days ago',
        icon: Icons.directions_bike,
        avatarUrl: 'images/6552f06370a60a3bafe50d15f66d6587.jpg',
      ),
      const Post(
        title: 'Technique Night',
        description:
            'Worked on footwork and defense drills at Uppercut Arena. The trainers really break everything down in a way that clicks.',
        author: 'Arman D.',
        date: '5 days ago',
        icon: Icons.sports_mma,
        avatarUrl: 'images/71c56e783f7da53daca02f592d35dc27.jpg',
      ),
      const Post(
        title: 'Recovery Swim Session',
        description:
            'Blue Wave Aquatics has become my favorite recovery spot after hard training days. Quiet lanes, clean water, and great lighting.',
        author: 'Dana Y.',
        date: '5 days ago',
        icon: Icons.pool,
        avatarUrl: 'images/ace2e4eaf4ad1b3eb5d53f12009a321f.jpg',
      ),
      const Post(
        title: 'CrossFit Team WOD',
        description:
            'Forge Functional Club had an incredible partner workout tonight. Tough session, but the team atmosphere made it fun.',
        author: 'Timur B.',
        date: '6 days ago',
        icon: Icons.sports_gymnastics,
        avatarUrl: 'images/c5b60e16a7ab446993298ffcf9cf5418.jpg',
      ),
      const Post(
        title: 'Stretch and Reset',
        description:
            'Spent the evening in a slow-flow session and left feeling completely reset. Soma Flow Loft is perfect when you need a lighter day.',
        author: 'Madina R.',
        date: '1 week ago',
        icon: Icons.self_improvement,
        avatarUrl: 'images/ce3a3ed67b711a8ccbb343682e00b4a7.jpg',
      ),
    ];

    return ExploreData(
      fitnessCenters: fitnessCenters,
      categories: categories,
      friendPosts: friendPosts,
    );
  }
}
