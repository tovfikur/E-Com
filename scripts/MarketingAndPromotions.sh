#!/bin/bash

APP_NAME="MarketingAndPromotions"
PROJECT_NAME="Khukumoni"
API_DIR="../$PROJECT_NAME/$APP_NAME/api"
VIEWS_FILE="$API_DIR/views.py"
URLS_FILE="$API_DIR/urls.py"
SERIALIZERS_FILE="$API_DIR/serializers.py"
PROJECT_URLS_FILE="../$PROJECT_NAME/$PROJECT_NAME/urls.py"
APP_URLS_FILE="../$PROJECT_NAME/$APP_NAME/urls.py"

# Create the api folder and files
mkdir -p $API_DIR
touch $API_DIR/__init__.py

# Create serializers.py
cat <<EOF > $SERIALIZERS_FILE
from rest_framework import serializers
from ..models import (
    PromotionRules, PromotionCoupons, PromotionSegments, PromotionAnalytics,
    PromotionTargeting, PromotionABTesting, PromotionContent,
    PromotionPersonalization, PromotionCollaborationHistory,
    PromotionAutomation, PromotionIntegrations
)

class PromotionRulesSerializer(serializers.ModelSerializer):
    class Meta:
        model = PromotionRules
        fields = '__all__'

class PromotionCouponsSerializer(serializers.ModelSerializer):
    class Meta:
        model = PromotionCoupons
        fields = '__all__'

class PromotionSegmentsSerializer(serializers.ModelSerializer):
    class Meta:
        model = PromotionSegments
        fields = '__all__'

class PromotionAnalyticsSerializer(serializers.ModelSerializer):
    class Meta:
        model = PromotionAnalytics
        fields = '__all__'

class PromotionTargetingSerializer(serializers.ModelSerializer):
    class Meta:
        model = PromotionTargeting
        fields = '__all__'

class PromotionABTestingSerializer(serializers.ModelSerializer):
    class Meta:
        model = PromotionABTesting
        fields = '__all__'

class PromotionContentSerializer(serializers.ModelSerializer):
    class Meta:
        model = PromotionContent
        fields = '__all__'

class PromotionPersonalizationSerializer(serializers.ModelSerializer):
    class Meta:
        model = PromotionPersonalization
        fields = '__all__'

class PromotionCollaborationHistorySerializer(serializers.ModelSerializer):
    class Meta:
        model = PromotionCollaborationHistory
        fields = '__all__'

class PromotionAutomationSerializer(serializers.ModelSerializer):
    class Meta:
        model = PromotionAutomation
        fields = '__all__'

class PromotionIntegrationsSerializer(serializers.ModelSerializer):
    class Meta:
        model = PromotionIntegrations
        fields = '__all__'
EOF

# Create views.py
cat <<EOF > $VIEWS_FILE
from rest_framework import viewsets
from ..models import (
    PromotionRules, PromotionCoupons, PromotionSegments, PromotionAnalytics,
    PromotionTargeting, PromotionABTesting, PromotionContent,
    PromotionPersonalization, PromotionCollaborationHistory,
    PromotionAutomation, PromotionIntegrations
)
from .serializers import (
    PromotionRulesSerializer, PromotionCouponsSerializer, PromotionSegmentsSerializer,
    PromotionAnalyticsSerializer, PromotionTargetingSerializer, PromotionABTestingSerializer,
    PromotionContentSerializer, PromotionPersonalizationSerializer,
    PromotionCollaborationHistorySerializer, PromotionAutomationSerializer,
    PromotionIntegrationsSerializer
)

class PromotionRulesViewSet(viewsets.ModelViewSet):
    queryset = PromotionRules.objects.all()
    serializer_class = PromotionRulesSerializer

class PromotionCouponsViewSet(viewsets.ModelViewSet):
    queryset = PromotionCoupons.objects.all()
    serializer_class = PromotionCouponsSerializer

class PromotionSegmentsViewSet(viewsets.ModelViewSet):
    queryset = PromotionSegments.objects.all()
    serializer_class = PromotionSegmentsSerializer

class PromotionAnalyticsViewSet(viewsets.ModelViewSet):
    queryset = PromotionAnalytics.objects.all()
    serializer_class = PromotionAnalyticsSerializer

class PromotionTargetingViewSet(viewsets.ModelViewSet):
    queryset = PromotionTargeting.objects.all()
    serializer_class = PromotionTargetingSerializer

class PromotionABTestingViewSet(viewsets.ModelViewSet):
    queryset = PromotionABTesting.objects.all()
    serializer_class = PromotionABTestingSerializer

class PromotionContentViewSet(viewsets.ModelViewSet):
    queryset = PromotionContent.objects.all()
    serializer_class = PromotionContentSerializer

class PromotionPersonalizationViewSet(viewsets.ModelViewSet):
    queryset = PromotionPersonalization.objects.all()
    serializer_class = PromotionPersonalizationSerializer

class PromotionCollaborationHistoryViewSet(viewsets.ModelViewSet):
    queryset = PromotionCollaborationHistory.objects.all()
    serializer_class = PromotionCollaborationHistorySerializer

class PromotionAutomationViewSet(viewsets.ModelViewSet):
    queryset = PromotionAutomation.objects.all()
    serializer_class = PromotionAutomationSerializer

class PromotionIntegrationsViewSet(viewsets.ModelViewSet):
    queryset = PromotionIntegrations.objects.all()
    serializer_class = PromotionIntegrationsSerializer
EOF

# Create urls.py
cat <<EOF > $URLS_FILE
from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import (
    PromotionRulesViewSet, PromotionCouponsViewSet, PromotionSegmentsViewSet,
    PromotionAnalyticsViewSet, PromotionTargetingViewSet, PromotionABTestingViewSet,
    PromotionContentViewSet, PromotionPersonalizationViewSet,
    PromotionCollaborationHistoryViewSet, PromotionAutomationViewSet,
    PromotionIntegrationsViewSet
)

router = DefaultRouter()
router.register(r'promotion_rules', PromotionRulesViewSet)
router.register(r'promotion_coupons', PromotionCouponsViewSet)
router.register(r'promotion_segments', PromotionSegmentsViewSet)
router.register(r'promotion_analytics', PromotionAnalyticsViewSet)
router.register(r'promotion_targeting', PromotionTargetingViewSet)
router.register(r'promotion_ab_testing', PromotionABTestingViewSet)
router.register(r'promotion_content', PromotionContentViewSet)
router.register(r'promotion_personalization', PromotionPersonalizationViewSet)
router.register(r'promotion_collaboration_history', PromotionCollaborationHistoryViewSet)
router.register(r'promotion_automation', PromotionAutomationViewSet)
router.register(r'promotion_integrations', PromotionIntegrationsViewSet)

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

echo "API setup for MarketingAndPromotions completed successfully."

