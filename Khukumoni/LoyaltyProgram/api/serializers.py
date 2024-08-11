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


