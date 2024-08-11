from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import (
    SocialShareViewSet, SocialAnalyticsViewSet, SocialLikeViewSet, SocialCommentViewSet, SocialPrivacyViewSet,
    UserSocialProfileViewSet, SocialBadgeViewSet, SocialRewardViewSet, SocialRecommendationViewSet,
    SocialTrendingTopicViewSet, InfluencerCampaignViewSet, SocialCollaborationViewSet, CMSIntegrationViewSet
)

router = DefaultRouter()

# Register viewsets for each model
router.register(r'social-share', SocialShareViewSet)
router.register(r'social-analytics', SocialAnalyticsViewSet)
router.register(r'social-like', SocialLikeViewSet)
router.register(r'social-comment', SocialCommentViewSet)
router.register(r'social-privacy', SocialPrivacyViewSet)
router.register(r'user-social-profile', UserSocialProfileViewSet)
router.register(r'social-badge', SocialBadgeViewSet)
router.register(r'social-reward', SocialRewardViewSet)
router.register(r'social-recommendation', SocialRecommendationViewSet)
router.register(r'social-trending-topic', SocialTrendingTopicViewSet)
router.register(r'influencer-campaign', InfluencerCampaignViewSet)
router.register(r'social-collaboration', SocialCollaborationViewSet)
router.register(r'cms-integration', CMSIntegrationViewSet)

urlpatterns = [
    path('', include(router.urls)),
]
