from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import (
    PaymentsViewSet, PaymentMethodsViewSet, PaymentHistoryViewSet, PaymentTokensViewSet,
    PaymentNotificationsViewSet, PaymentGatewaysViewSet, RecurringPaymentsViewSet,
    SettlementsViewSet, FraudDetectionViewSet, SecureAuthenticationViewSet
)

router = DefaultRouter()
router.register(r'payments', PaymentsViewSet)
router.register(r'payment_methods', PaymentMethodsViewSet)
router.register(r'payment_history', PaymentHistoryViewSet)
router.register(r'payment_tokens', PaymentTokensViewSet)
router.register(r'payment_notifications', PaymentNotificationsViewSet)
router.register(r'payment_gateways', PaymentGatewaysViewSet)
router.register(r'recurring_payments', RecurringPaymentsViewSet)
router.register(r'settlements', SettlementsViewSet)
router.register(r'fraud_detection', FraudDetectionViewSet)
router.register(r'secure_authentication', SecureAuthenticationViewSet)

urlpatterns = [
    path('', include(router.urls)),
]
