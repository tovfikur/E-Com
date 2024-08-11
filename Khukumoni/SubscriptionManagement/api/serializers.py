from rest_framework import serializers
from ..models import (
    Subscriptions, SubscriptionPlans, SubscriptionCancellationReasons,
    SubscriptionRenewalReminders, SubscriptionPaymentMethods, SubscriptionUsageTracking,
    SubscriptionAnalytics, SubscriptionDiscounts, SubscriptionCustomizationOptions
)

class SubscriptionsSerializer(serializers.ModelSerializer):
    class Meta:
        model = Subscriptions
        fields = '__all__'

class SubscriptionPlansSerializer(serializers.ModelSerializer):
    class Meta:
        model = SubscriptionPlans
        fields = '__all__'

class SubscriptionCancellationReasonsSerializer(serializers.ModelSerializer):
    class Meta:
        model = SubscriptionCancellationReasons
        fields = '__all__'

class SubscriptionRenewalRemindersSerializer(serializers.ModelSerializer):
    class Meta:
        model = SubscriptionRenewalReminders
        fields = '__all__'

class SubscriptionPaymentMethodsSerializer(serializers.ModelSerializer):
    class Meta:
        model = SubscriptionPaymentMethods
        fields = '__all__'

class SubscriptionUsageTrackingSerializer(serializers.ModelSerializer):
    class Meta:
        model = SubscriptionUsageTracking
        fields = '__all__'

class SubscriptionAnalyticsSerializer(serializers.ModelSerializer):
    class Meta:
        model = SubscriptionAnalytics
        fields = '__all__'

class SubscriptionDiscountsSerializer(serializers.ModelSerializer):
    class Meta:
        model = SubscriptionDiscounts
        fields = '__all__'

class SubscriptionCustomizationOptionsSerializer(serializers.ModelSerializer):
    class Meta:
        model = SubscriptionCustomizationOptions
        fields = '__all__'
