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
