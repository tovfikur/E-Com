from rest_framework import serializers
from ..models import (
    Payments, PaymentMethods, PaymentHistory, PaymentTokens,
    PaymentNotifications, PaymentGateways, RecurringPayments,
    Settlements, FraudDetection, SecureAuthentication
)

class PaymentsSerializer(serializers.ModelSerializer):
    class Meta:
        model = Payments
        fields = '__all__'

class PaymentMethodsSerializer(serializers.ModelSerializer):
    class Meta:
        model = PaymentMethods
        fields = '__all__'

class PaymentHistorySerializer(serializers.ModelSerializer):
    class Meta:
        model = PaymentHistory
        fields = '__all__'

class PaymentTokensSerializer(serializers.ModelSerializer):
    class Meta:
        model = PaymentTokens
        fields = '__all__'

class PaymentNotificationsSerializer(serializers.ModelSerializer):
    class Meta:
        model = PaymentNotifications
        fields = '__all__'

class PaymentGatewaysSerializer(serializers.ModelSerializer):
    class Meta:
        model = PaymentGateways
        fields = '__all__'

class RecurringPaymentsSerializer(serializers.ModelSerializer):
    class Meta:
        model = RecurringPayments
        fields = '__all__'

class SettlementsSerializer(serializers.ModelSerializer):
    class Meta:
        model = Settlements
        fields = '__all__'

class FraudDetectionSerializer(serializers.ModelSerializer):
    class Meta:
        model = FraudDetection
        fields = '__all__'

class SecureAuthenticationSerializer(serializers.ModelSerializer):
    class Meta:
        model = SecureAuthentication
        fields = '__all__'
