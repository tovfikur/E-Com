#!/bin/bash

APP_NAME="ReviewsAndRatings"
PROJECT_NAME="Khukumoni"
API_DIR="../$PROJECT_NAME/$APP_NAME/api"
VIEWS_FILE="$API_DIR/views.py"
URLS_FILE="$API_DIR/urls.py"
SERIALIZERS_FILE="$API_DIR/serializers.py"
PROJECT_URLS_FILE="../$PROJECT_NAME/$PROJECT_NAME/urls.py"
APP_URLS_FILE="../$PROJECT_NAME/$APP_NAME/urls.py"

# Step 1: Create the api folder and files
mkdir -p $API_DIR
touch $API_DIR/__init__.py

# Step 2: Create serializers.py
cat <<EOF > $SERIALIZERS_FILE
from rest_framework import serializers
from ..models import (
    Review, ReviewReply, ReviewFilter, ReviewReport, ReviewNotification, 
    ReviewAnalytics, ReviewImportExport, ReviewResponseTemplate, ReviewAggregation, 
    ReviewIntegration, ReviewGamification, ReviewAuthentication
)

class ReviewSerializer(serializers.ModelSerializer):
    class Meta:
        model = Review
        fields = '__all__'

class ReviewReplySerializer(serializers.ModelSerializer):
    class Meta:
        model = ReviewReply
        fields = '__all__'

class ReviewFilterSerializer(serializers.ModelSerializer):
    class Meta:
        model = ReviewFilter
        fields = '__all__'

class ReviewReportSerializer(serializers.ModelSerializer):
    class Meta:
        model = ReviewReport
        fields = '__all__'

class ReviewNotificationSerializer(serializers.ModelSerializer):
    class Meta:
        model = ReviewNotification
        fields = '__all__'

class ReviewAnalyticsSerializer(serializers.ModelSerializer):
    class Meta:
        model = ReviewAnalytics
        fields = '__all__'

class ReviewImportExportSerializer(serializers.ModelSerializer):
    class Meta:
        model = ReviewImportExport
        fields = '__all__'

class ReviewResponseTemplateSerializer(serializers.ModelSerializer):
    class Meta:
        model = ReviewResponseTemplate
        fields = '__all__'

class ReviewAggregationSerializer(serializers.ModelSerializer):
    class Meta:
        model = ReviewAggregation
        fields = '__all__'

class ReviewIntegrationSerializer(serializers.ModelSerializer):
    class Meta:
        model = ReviewIntegration
        fields = '__all__'

class ReviewGamificationSerializer(serializers.ModelSerializer):
    class Meta:
        model = ReviewGamification
        fields = '__all__'

class ReviewAuthenticationSerializer(serializers.ModelSerializer):
    class Meta:
        model = ReviewAuthentication
        fields = '__all__'

EOF

# Step 3: Create views.py
cat <<EOF > $VIEWS_FILE
from rest_framework import viewsets
from ..models import (
    Review, ReviewReply, ReviewFilter, ReviewReport, ReviewNotification, 
    ReviewAnalytics, ReviewImportExport, ReviewResponseTemplate, ReviewAggregation, 
    ReviewIntegration, ReviewGamification, ReviewAuthentication
)
from .serializers import (
    ReviewSerializer, ReviewReplySerializer, ReviewFilterSerializer, ReviewReportSerializer, ReviewNotificationSerializer, 
    ReviewAnalyticsSerializer, ReviewImportExportSerializer, ReviewResponseTemplateSerializer, ReviewAggregationSerializer, 
    ReviewIntegrationSerializer, ReviewGamificationSerializer, ReviewAuthenticationSerializer
)

class ReviewViewSet(viewsets.ModelViewSet):
    queryset = Review.objects.all()
    serializer_class = ReviewSerializer

class ReviewReplyViewSet(viewsets.ModelViewSet):
    queryset = ReviewReply.objects.all()
    serializer_class = ReviewReplySerializer

class ReviewFilterViewSet(viewsets.ModelViewSet):
    queryset = ReviewFilter.objects.all()
    serializer_class = ReviewFilterSerializer

class ReviewReportViewSet(viewsets.ModelViewSet):
    queryset = ReviewReport.objects.all()
    serializer_class = ReviewReportSerializer

class ReviewNotificationViewSet(viewsets.ModelViewSet):
    queryset = ReviewNotification.objects.all()
    serializer_class = ReviewNotificationSerializer

class ReviewAnalyticsViewSet(viewsets.ModelViewSet):
    queryset = ReviewAnalytics.objects.all()
    serializer_class = ReviewAnalyticsSerializer

class ReviewImportExportViewSet(viewsets.ModelViewSet):
    queryset = ReviewImportExport.objects.all()
    serializer_class = ReviewImportExportSerializer

class ReviewResponseTemplateViewSet(viewsets.ModelViewSet):
    queryset = ReviewResponseTemplate.objects.all()
    serializer_class = ReviewResponseTemplateSerializer

class ReviewAggregationViewSet(viewsets.ModelViewSet):
    queryset = ReviewAggregation.objects.all()
    serializer_class = ReviewAggregationSerializer

class ReviewIntegrationViewSet(viewsets.ModelViewSet):
    queryset = ReviewIntegration.objects.all()
    serializer_class = ReviewIntegrationSerializer

class ReviewGamificationViewSet(viewsets.ModelViewSet):
    queryset = ReviewGamification.objects.all()
    serializer_class = ReviewGamificationSerializer

class ReviewAuthenticationViewSet(viewsets.ModelViewSet):
    queryset = ReviewAuthentication.objects.all()
    serializer_class = ReviewAuthenticationSerializer

EOF

# Step 4: Create urls.py
cat <<EOF > $URLS_FILE
from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import (
    ReviewViewSet, ReviewReplyViewSet, ReviewFilterViewSet, ReviewReportViewSet, ReviewNotificationViewSet, 
    ReviewAnalyticsViewSet, ReviewImportExportViewSet, ReviewResponseTemplateViewSet, ReviewAggregationViewSet, 
    ReviewIntegrationViewSet, ReviewGamificationViewSet, ReviewAuthenticationViewSet
)

router = DefaultRouter()
router.register(r'review', ReviewViewSet)
router.register(r'review-reply', ReviewReplyViewSet)
router.register(r'review-filter', ReviewFilterViewSet)
router.register(r'review-report', ReviewReportViewSet)
router.register(r'review-notification', ReviewNotificationViewSet)
router.register(r'review-analytics', ReviewAnalyticsViewSet)
router.register(r'review-import-export', ReviewImportExportViewSet)
router.register(r'review-response-template', ReviewResponseTemplateViewSet)
router.register(r'review-aggregation', ReviewAggregationViewSet)
router.register(r'review-integration', ReviewIntegrationViewSet)
router.register(r'review-gamification', ReviewGamificationViewSet)
router.register(r'review-authentication', ReviewAuthenticationViewSet)

urlpatterns = [
    path('', include(router.urls)),
]
EOF

# Step 5: Ensure the main project urls.py file exists and include the api urls
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

# Step 6: Add the app path to the main project urls.py if not already included
if ! grep -q "path('$APP_NAME/', include('$APP_NAME.urls'))" "$PROJECT_URLS_FILE"; then
    sed -i "/urlpatterns = \[/a \ \ \ \ path('$APP_NAME/', include('$APP_NAME.urls'))," $PROJECT_URLS_FILE
fi

echo "API setup for $APP_NAME completed."