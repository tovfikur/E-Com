from rest_framework import viewsets
from ..models import (
    Payments, PaymentMethods, PaymentHistory, PaymentTokens,
    PaymentNotifications, PaymentGateways, RecurringPayments,
    Settlements, FraudDetection, SecureAuthentication
)
from .serializers import (
    PaymentsSerializer, PaymentMethodsSerializer, PaymentHistorySerializer,
    PaymentTokensSerializer, PaymentNotificationsSerializer, PaymentGatewaysSerializer,
    RecurringPaymentsSerializer, SettlementsSerializer, FraudDetectionSerializer,
    SecureAuthenticationSerializer
)

class PaymentsViewSet(viewsets.ModelViewSet):
    queryset = Payments.objects.all()
    serializer_class = PaymentsSerializer

class PaymentMethodsViewSet(viewsets.ModelViewSet):
    queryset = PaymentMethods.objects.all()
    serializer_class = PaymentMethodsSerializer

class PaymentHistoryViewSet(viewsets.ModelViewSet):
    queryset = PaymentHistory.objects.all()
    serializer_class = PaymentHistorySerializer

class PaymentTokensViewSet(viewsets.ModelViewSet):
    queryset = PaymentTokens.objects.all()
    serializer_class = PaymentTokensSerializer

class PaymentNotificationsViewSet(viewsets.ModelViewSet):
    queryset = PaymentNotifications.objects.all()
    serializer_class = PaymentNotificationsSerializer

class PaymentGatewaysViewSet(viewsets.ModelViewSet):
    queryset = PaymentGateways.objects.all()
    serializer_class = PaymentGatewaysSerializer

class RecurringPaymentsViewSet(viewsets.ModelViewSet):
    queryset = RecurringPayments.objects.all()
    serializer_class = RecurringPaymentsSerializer

class SettlementsViewSet(viewsets.ModelViewSet):
    queryset = Settlements.objects.all()
    serializer_class = SettlementsSerializer

class FraudDetectionViewSet(viewsets.ModelViewSet):
    queryset = FraudDetection.objects.all()
    serializer_class = FraudDetectionSerializer

class SecureAuthenticationViewSet(viewsets.ModelViewSet):
    queryset = SecureAuthentication.objects.all()
    serializer_class = SecureAuthenticationSerializer
