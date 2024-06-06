#!/bin/bash

APP_NAME="SocialShare"
PROJECT_NAME="Khukumoni"
API_DIR="../$PROJECT_NAME/$APP_NAME/api"
VIEWS_FILE="$API_DIR/views.py"
URLS_FILE="$API_DIR/urls.py"
SERIALIZERS_FILE="$API_DIR/serializers.py"
SETTINGS_FILE="../$PROJECT_NAME/$PROJECT_NAME/settings.py"
PROJECT_URLS_FILE="../$PROJECT_NAME/$PROJECT_NAME/urls.py"
APP_URLS_FILE="../$PROJECT_NAME/$APP_NAME/urls.py"

# Create the api folder and files
mkdir -p $API_DIR
touch $API_DIR/__init__.py

# Create serializers.py
cat <<EOF > $SERIALIZERS_FILE
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

EOF

# Create views.py
cat <<EOF > $VIEWS_FILE
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

EOF

# Create urls.py
cat <<EOF > $URLS_FILE
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
EOF

# Ensure the main project urls.py file exists and include the api urls
if [ ! -f "$APP_URLS_FILE" ]; then
    # Create the main urls.py if it does not exist
    cat <<EOF > $APP_URLS_FILE
from django.urls import path, include

urlpatterns = [
    path('api/', include('$APP_NAME.api.urls')),
]
EOF
else
    # Add the api path if it's not already included
    if ! grep -q "path('api/', include('$APP_NAME.api.urls'))" "$APP_URLS_FILE"; then
        sed -i "/urlpatterns = \[/a \ \ \ \ path('api/', include('$APP_NAME.api.urls'))," $APP_URLS_FILE
    fi
fi

# Add the app path to the main project urls.py if not already included
if ! grep -q "path('$APP_NAME/', include('$APP_NAME.urls'))" "$PROJECT_URLS_FILE"; then
    sed -i "/urlpatterns = \[/a \ \ \ \ path('$APP_NAME/', include('$APP_NAME.urls'))," $PROJECT_URLS_FILE
fi

# Display success message
echo "API setup for $APP_NAME completed."