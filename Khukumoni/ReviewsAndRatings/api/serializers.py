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

