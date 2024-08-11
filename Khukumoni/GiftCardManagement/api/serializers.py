from rest_framework import serializers
from ..models import GiftCards, GiftCardTransactions, GiftCardNotifications, POSIntegrationConfiguration,     GiftCardRedemptionOptions, GiftCardCustomizationOptions

class GiftCardsSerializer(serializers.ModelSerializer):
    class Meta:
        model = GiftCards
        fields = '__all__'

class GiftCardTransactionsSerializer(serializers.ModelSerializer):
    class Meta:
        model = GiftCardTransactions
        fields = '__all__'

class GiftCardNotificationsSerializer(serializers.ModelSerializer):
    class Meta:
        model = GiftCardNotifications
        fields = '__all__'

class POSIntegrationConfigurationSerializer(serializers.ModelSerializer):
    class Meta:
        model = POSIntegrationConfiguration
        fields = '__all__'

class GiftCardRedemptionOptionsSerializer(serializers.ModelSerializer):
    class Meta:
        model = GiftCardRedemptionOptions
        fields = '__all__'

class GiftCardCustomizationOptionsSerializer(serializers.ModelSerializer):
    class Meta:
        model = GiftCardCustomizationOptions
        fields = '__all__'
