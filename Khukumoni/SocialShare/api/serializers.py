from rest_framework import serializers
from ..models import ( SocialShare, SocialAnalytics, SocialLike, SocialComment, SocialPrivacy,
UserSocialProfile, SocialBadge, SocialReward, SocialRecommendation, SocialTrendingTopic, InfluencerCampaign,
SocialCollaboration, CMSIntegration )

class SocialShareSerializer(serializers.ModelSerializer):
    class Meta:
        model = SocialShare
        fields = '__all__'

class SocialAnalyticsSerializer(serializers.ModelSerializer):
    class Meta:
        model = SocialAnalytics
        fields = '__all__'

class SocialLikeSerializer(serializers.ModelSerializer):
    class Meta:
        model = SocialLike
        fields = '__all__'

class SocialCommentSerializer(serializers.ModelSerializer):
    class Meta:
        model = SocialComment
        fields = '__all__'

class SocialPrivacySerializer(serializers.ModelSerializer):
    class Meta:
        model = SocialPrivacy
        fields = '__all__'

class UserSocialProfileSerializer(serializers.ModelSerializer):
    class Meta:
        model = UserSocialProfile
        fields = '__all__'

class SocialBadgeSerializer(serializers.ModelSerializer):
    class Meta:
        model = SocialBadge
        fields = '__all__'

class SocialRewardSerializer(serializers.ModelSerializer):
    class Meta:
        model = SocialReward
        fields = '__all__'

class SocialRecommendationSerializer(serializers.ModelSerializer):
    class Meta:
        model = SocialRecommendation
        fields = '__all__'

class SocialTrendingTopicSerializer(serializers.ModelSerializer):
    class Meta:
        model = SocialTrendingTopic
        fields = '__all__'

class InfluencerCampaignSerializer(serializers.ModelSerializer):
    class Meta:
        model = InfluencerCampaign
        fields = '__all__'

class SocialCollaborationSerializer(serializers.ModelSerializer):
    class Meta:
        model = SocialCollaboration
        fields = '__all__'

class CMSIntegrationSerializer(serializers.ModelSerializer):
    class Meta:
        model = CMSIntegration
        fields = '__all__'

