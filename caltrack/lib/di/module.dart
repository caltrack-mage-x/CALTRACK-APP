import 'package:caltrack/domain/repository/conversation/conversation_repository.dart';
import 'package:caltrack/domain/repository/conversation/message_repository.dart';
import 'package:caltrack/domain/repository/conversation/topic_repository.dart';
import 'package:caltrack/domain/repository/exercise/exercise_repository.dart';
import 'package:caltrack/domain/repository/exercise/exerciselog_repository.dart';
import 'package:caltrack/domain/repository/food/food_repository.dart';
import 'package:caltrack/domain/repository/food/foodattachment_repository.dart';
import 'package:caltrack/domain/repository/food/foodlog_repository.dart';
import 'package:caltrack/domain/repository/gamification/achievement_repository.dart';
import 'package:caltrack/domain/repository/gamification/challange_repository.dart';
import 'package:caltrack/domain/repository/gamification/leaderboard_repository.dart';
import 'package:caltrack/domain/repository/gamification/userachievement_repository.dart';
import 'package:caltrack/domain/repository/gamification/userchallange_repository.dart';
import 'package:caltrack/domain/repository/gamification/xplog_repository.dart';
import 'package:caltrack/domain/repository/user/user_repository.dart';
import 'package:caltrack/domain/repository/user/userattachment_repository.dart';
import 'package:caltrack/domain/services/conversation/conversation_service.dart';
import 'package:caltrack/domain/services/conversation/message_service.dart';
import 'package:caltrack/domain/services/conversation/topic_service.dart';
import 'package:caltrack/domain/services/exercise/exercise_service.dart';
import 'package:caltrack/domain/services/exercise/exerciselog_service.dart';
import 'package:caltrack/domain/services/food/food_service.dart';
import 'package:caltrack/domain/services/food/foodattachment_service.dart';
import 'package:caltrack/domain/services/food/foodlog_service.dart';
import 'package:caltrack/domain/services/gamification/achievement_service.dart';
import 'package:caltrack/domain/services/gamification/challange_service.dart';
import 'package:caltrack/domain/services/gamification/leaderboard_service.dart';
import 'package:caltrack/domain/services/gamification/userachievement_service.dart';
import 'package:caltrack/domain/services/gamification/userchallange_service.dart';
import 'package:caltrack/domain/services/gamification/xplog_service.dart';
import 'package:caltrack/domain/services/user/user_service.dart';
import 'package:caltrack/domain/services/user/userattachment_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Module {
  static final SupabaseClient supabaseClient = SupabaseClient(
    'https://oypqnvowydydwaddaith.supabase.co',
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im95cHFudm93eWR5ZHdhZGRhaXRoIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjY4MjU0OTAsImV4cCI6MjA0MjQwMTQ5MH0.bWK6aXjgWrm_gdnPazCcEfxYTUp550sotiWJDZATGcU',
  );

  static ConversationRepository get conversationRepository => ConversationRepository(supabaseClient);
  static ConversationService get conversationService => ConversationService(conversationRepository);

  static MessageRepository get messageRepository => MessageRepository(supabaseClient);
  static MessageService get messageService => MessageService(messageRepository);

  static TopicRepository get topicRepository => TopicRepository(supabaseClient);
  static TopicService get topicService => TopicService(topicRepository);

  static ExerciseRepository get exerciseRepository => ExerciseRepository(supabaseClient);
  static ExerciseService get exerciseService => ExerciseService(exerciseRepository);

  static ExerciseLogRepository get exerciseLogRepository => ExerciseLogRepository(supabaseClient);
  static ExerciseLogService get exerciseLogService => ExerciseLogService(exerciseLogRepository);

  static FoodRepository get foodRepository => FoodRepository(supabaseClient);
  static FoodService get foodService => FoodService(foodRepository);

  static FoodAttachmentRepository get foodAttachmentRepository => FoodAttachmentRepository(supabaseClient);
  static FoodAttachmentService get foodAttachmentService => FoodAttachmentService(foodAttachmentRepository);

  static FoodLogRepository get foodLogRepository => FoodLogRepository(supabaseClient);
  static FoodLogService get foodLogService => FoodLogService(foodLogRepository);

  static AchievementRepository get achievementRepository => AchievementRepository(supabaseClient);
  static AchievementService get achievementService => AchievementService(achievementRepository);

  static ChallengeRepository get challengeRepository => ChallengeRepository(supabaseClient);
  static ChallengeService get challengeService => ChallengeService(challengeRepository);

  static LeaderboardRepository get leaderboardRepository => LeaderboardRepository(supabaseClient);
  static LeaderboardService get leaderboardService => LeaderboardService(leaderboardRepository);

  static UserAchievementRepository get userAchievementRepository => UserAchievementRepository(supabaseClient);
  static UserAchievementService get userAchievementService => UserAchievementService(userAchievementRepository);

  static UserChallengeRepository get userChallengeRepository => UserChallengeRepository(supabaseClient);
  static UserChallengeService get userChallengeService => UserChallengeService(userChallengeRepository);

  // static ViewLeaderboardRepository get viewLeaderboardRepository => ViewLeaderboardRepository(supabaseClient);
  // static ViewUserAchievementRepository get viewUserAchievementRepository => ViewUserAchievementRepository(supabaseClient);
  // static ViewUserChallengeRepository get viewUserChallengeRepository => ViewUserChallengeRepository(supabaseClient);

  static XPLogRepository get xpLogRepository => XPLogRepository(supabaseClient);
  static XPLogService get xpLogService => XPLogService(xpLogRepository);

  static UserRepository get userRepository => UserRepository(supabaseClient);
  static UserService get userService => UserService(userRepository);

  static UserAttachmentRepository get userAttachmentRepository => UserAttachmentRepository(supabaseClient);
  static UserAttachmentService get userAttachmentService => UserAttachmentService(userAttachmentRepository);
}

class DependencyProvider extends StatelessWidget {
  final Widget child;

  DependencyProvider({required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ConversationService>(create: (_) => Module.conversationService),
        Provider<MessageService>(create: (_) => Module.messageService),
        Provider<TopicService>(create: (_) => Module.topicService),
        Provider<ExerciseService>(create: (_) => Module.exerciseService),
        Provider<ExerciseLogService>(create: (_) => Module.exerciseLogService),
        Provider<FoodService>(create: (_) => Module.foodService),
        Provider<FoodAttachmentService>(create: (_) => Module.foodAttachmentService),
        Provider<FoodLogService>(create: (_) => Module.foodLogService),
        Provider<AchievementService>(create: (_) => Module.achievementService),
        Provider<ChallengeService>(create: (_) => Module.challengeService),
        Provider<LeaderboardService>(create: (_) => Module.leaderboardService),
        Provider<UserAchievementService>(create: (_) => Module.userAchievementService),
        Provider<UserChallengeService>(create: (_) => Module.userChallengeService),
        // Provider<ViewLeaderboardService>(create: (_) => DependencyInjection.viewLeaderboardService),
        // Provider<ViewUserAchievementService>(create: (_) => DependencyInjection.viewUserAchievementService),
        // Provider<ViewUserChallengeService>(create: (_) => DependencyInjection.viewUserChallengeService),
        Provider<XPLogService>(create: (_) => Module.xpLogService),
        Provider<UserService>(create: (_) => Module.userService),
        Provider<UserAttachmentService>(create: (_) => Module.userAttachmentService),
      ],
      child: child,
    );
  }
}