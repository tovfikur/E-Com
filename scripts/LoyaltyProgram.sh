#!/bin/bash

APP_NAME="LoyaltyProgram"
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
from ..models import (LoyaltyEnrollment, LoyaltyPointsHistory, LoyaltyRedemptionHistory, LoyaltyTier,
LoyaltyMembershipStatus, LoyaltyEarningOpportunity, LoyaltyCustomization, LoyaltyPromotion, LoyaltyPointsTransfer,
LoyaltyAnalytics, LoyaltyReferral, LoyaltyNotification )

class LoyaltyEnrollmentSerializer(serializers.ModelSerializer):
    class Meta:
        model = LoyaltyEnrollment
        fields = '__all__'

class LoyaltyPointsHistorySerializer(serializers.ModelSerializer):
    class Meta:
        model = LoyaltyPointsHistory
        fields = '__all__'

class LoyaltyRedemptionHistorySerializer(serializers.ModelSerializer):
    class Meta:
        model = LoyaltyRedemptionHistory
        fields = '__all__'

class LoyaltyTierSerializer(serializers.ModelSerializer):
    class Meta:
        model = LoyaltyTier
        fields = '__all__'

class LoyaltyMembershipStatusSerializer(serializers.ModelSerializer):
    class Meta:
        model = LoyaltyMembershipStatus
        fields = '__all__'

class LoyaltyEarningOpportunitySerializer(serializers.ModelSerializer):
    class Meta:
        model = LoyaltyEarningOpportunity
        fields = '__all__'

class LoyaltyCustomizationSerializer(serializers.ModelSerializer):
    class Meta:
        model = LoyaltyCustomization
        fields = '__all__'

class LoyaltyPromotionSerializer(serializers.ModelSerializer):
    class Meta:
        model = LoyaltyPromotion
        fields = '__all__'

class LoyaltyPointsTransferSerializer(serializers.ModelSerializer):
    class Meta:
        model = LoyaltyPointsTransfer
        fields = '__all__'

class LoyaltyAnalyticsSerializer(serializers.ModelSerializer):
    class Meta:
        model = LoyaltyAnalytics
        fields = '__all__'

class LoyaltyReferralSerializer(serializers.ModelSerializer):
    class Meta:
        model = LoyaltyReferral
        fields = '__all__'

class LoyaltyNotificationSerializer(serializers.ModelSerializer):
    class Meta:
        model = LoyaltyNotification
        fields = '__all__'


EOF

# Create views.py
cat <<EOF > $VIEWS_FILE
from rest_framework import viewsets
from ..models import (LoyaltyEnrollment, LoyaltyPointsHistory, LoyaltyRedemptionHistory, LoyaltyTier,
LoyaltyMembershipStatus, LoyaltyEarningOpportunity, LoyaltyCustomization, LoyaltyPromotion, LoyaltyPointsTransfer,
LoyaltyAnalytics, LoyaltyReferral, LoyaltyNotification )

from .serializers import (
    LoyaltyEnrollmentSerializer, LoyaltyPointsHistorySerializer,
    LoyaltyRedemptionHistorySerializer, LoyaltyTierSerializer,
    LoyaltyMembershipStatusSerializer, LoyaltyEarningOpportunitySerializer,
    LoyaltyCustomizationSerializer, LoyaltyPromotionSerializer,
    LoyaltyPointsTransferSerializer, LoyaltyAnalyticsSerializer,
    LoyaltyReferralSerializer, LoyaltyNotificationSerializer,
)

class LoyaltyEnrollmentViewSet(viewsets.ModelViewSet):
    queryset = LoyaltyEnrollment.objects.all()
    serializer_class = LoyaltyEnrollmentSerializer

class LoyaltyPointsHistoryViewSet(viewsets.ModelViewSet):
    queryset = LoyaltyPointsHistory.objects.all()
    serializer_class = LoyaltyPointsHistorySerializer

class LoyaltyRedemptionHistoryViewSet(viewsets.ModelViewSet):
    queryset = LoyaltyRedemptionHistory.objects.all()
    serializer_class = LoyaltyRedemptionHistorySerializer

class LoyaltyTierViewSet(viewsets.ModelViewSet):
    queryset = LoyaltyTier.objects.all()
    serializer_class = LoyaltyTierSerializer

class LoyaltyMembershipStatusViewSet(viewsets.ModelViewSet):
    queryset = LoyaltyMembershipStatus.objects.all()
    serializer_class = LoyaltyMembershipStatusSerializer

class LoyaltyEarningOpportunityViewSet(viewsets.ModelViewSet):
    queryset = LoyaltyEarningOpportunity.objects.all()
    serializer_class = LoyaltyEarningOpportunitySerializer

class LoyaltyCustomizationViewSet(viewsets.ModelViewSet):
    queryset = LoyaltyCustomization.objects.all()
    serializer_class = LoyaltyCustomizationSerializer

class LoyaltyPromotionViewSet(viewsets.ModelViewSet):
    queryset = LoyaltyPromotion.objects.all()
    serializer_class = LoyaltyPromotionSerializer

class LoyaltyPointsTransferViewSet(viewsets.ModelViewSet):
    queryset = LoyaltyPointsTransfer.objects.all()
    serializer_class = LoyaltyPointsTransferSerializer

class LoyaltyAnalyticsViewSet(viewsets.ModelViewSet):
    queryset = LoyaltyAnalytics.objects.all()
    serializer_class = LoyaltyAnalyticsSerializer

class LoyaltyReferralViewSet(viewsets.ModelViewSet):
    queryset = LoyaltyReferral.objects.all()
    serializer_class = LoyaltyReferralSerializer

class LoyaltyNotificationViewSet(viewsets.ModelViewSet):
    queryset = LoyaltyNotification.objects.all()
    serializer_class = LoyaltyNotificationSerializer

EOF

# Create urls.py
cat <<EOF > $URLS_FILE
from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import (
    LoyaltyEnrollmentViewSet, LoyaltyPointsHistoryViewSet, LoyaltyRedemptionHistoryViewSet,
    LoyaltyTierViewSet, LoyaltyMembershipStatusViewSet, LoyaltyEarningOpportunityViewSet,
    LoyaltyCustomizationViewSet, LoyaltyPromotionViewSet, LoyaltyPointsTransferViewSet,
    LoyaltyAnalyticsViewSet, LoyaltyReferralViewSet, LoyaltyNotificationViewSet
)

router = DefaultRouter()

# Register all viewsets for all imported views
router.register(r'enrollment', LoyaltyEnrollmentViewSet)
router.register(r'points_history', LoyaltyPointsHistoryViewSet)
router.register(r'redemption_history', LoyaltyRedemptionHistoryViewSet)
router.register(r'tier', LoyaltyTierViewSet)
router.register(r'membership_status', LoyaltyMembershipStatusViewSet)
router.register(r'earning_opportunity', LoyaltyEarningOpportunityViewSet)
router.register(r'customization', LoyaltyCustomizationViewSet)
router.register(r'promotion', LoyaltyPromotionViewSet)
router.register(r'points_transfer', LoyaltyPointsTransferViewSet)
router.register(r'analytics', LoyaltyAnalyticsViewSet)
router.register(r'referral', LoyaltyReferralViewSet)
router.register(r'notification', LoyaltyNotificationViewSet)

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
