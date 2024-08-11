from rest_framework import viewsets
from ..models import (SocialShare, SocialAnalytics, SocialLike, SocialComment, SocialPrivacy, UserSocialProfile,
SocialBadge, SocialReward, SocialRecommendation, SocialTrendingTopic, InfluencerCampaign, SocialCollaboration, CMSIntegration )
from .serializers import (
    SocialShareSerializer, SocialAnalyticsSerializer, SocialLikeSerializer, SocialCommentSerializer, SocialPrivacySerializer, 
    UserSocialProfileSerializer, SocialBadgeSerializer, SocialRewardSerializer, SocialRecommendationSerializer, 
    SocialTrendingTopicSerializer, InfluencerCampaignSerializer, SocialCollaborationSerializer, CMSIntegrationSerializer
)

class SocialShareViewSet(viewsets.ModelViewSet):
    queryset = SocialShare.objects.all()
    serializer_class = SocialShareSerializer

class SocialAnalyticsViewSet(viewsets.ModelViewSet):
    queryset = SocialAnalytics.objects.all()
    serializer_class = SocialAnalyticsSerializer

class SocialLikeViewSet(viewsets.ModelViewSet):
    queryset = SocialLike.objects.all()
    serializer_class = SocialLikeSerializer

class SocialCommentViewSet(viewsets.ModelViewSet):
    queryset = SocialComment.objects.all()
    serializer_class = SocialCommentSerializer

class SocialPrivacyViewSet(viewsets.ModelViewSet):
    queryset = SocialPrivacy.objects.all()
    serializer_class = SocialPrivacySerializer

class UserSocialProfileViewSet(viewsets.ModelViewSet):
    queryset = UserSocialProfile.objects.all()
    serializer_class = UserSocialProfileSerializer

class SocialBadgeViewSet(viewsets.ModelViewSet):
    queryset = SocialBadge.objects.all()
    serializer_class = SocialBadgeSerializer

class SocialRewardViewSet(viewsets.ModelViewSet):
    queryset = SocialReward.objects.all()
    serializer_class = SocialRewardSerializer

class SocialRecommendationViewSet(viewsets.ModelViewSet):
    queryset = SocialRecommendation.objects.all()
    serializer_class = SocialRecommendationSerializer

class SocialTrendingTopicViewSet(viewsets.ModelViewSet):
    queryset = SocialTrendingTopic.objects.all()
    serializer_class = SocialTrendingTopicSerializer

class InfluencerCampaignViewSet(viewsets.ModelViewSet):
    queryset = InfluencerCampaign.objects.all()
    serializer_class = InfluencerCampaignSerializer

class SocialCollaborationViewSet(viewsets.ModelViewSet):
    queryset = SocialCollaboration.objects.all()
    serializer_class = SocialCollaborationSerializer

class CMSIntegrationViewSet(viewsets.ModelViewSet):
    queryset = CMSIntegration.objects.all()
    serializer_class = CMSIntegrationSerializer

