from rest_framework import viewsets
from ..models import (
    Subscriptions, SubscriptionPlans, SubscriptionCancellationReasons,
    SubscriptionRenewalReminders, SubscriptionPaymentMethods, SubscriptionUsageTracking,
    SubscriptionAnalytics, SubscriptionDiscounts, SubscriptionCustomizationOptions
)
from .serializers import (
    SubscriptionsSerializer, SubscriptionPlansSerializer, SubscriptionCancellationReasonsSerializer,
    SubscriptionRenewalRemindersSerializer, SubscriptionPaymentMethodsSerializer,
    SubscriptionUsageTrackingSerializer, SubscriptionAnalyticsSerializer, SubscriptionDiscountsSerializer,
    SubscriptionCustomizationOptionsSerializer
)

# Define viewsets for each model
class SubscriptionsViewSet(viewsets.ModelViewSet):
    queryset = Subscriptions.objects.all()
    serializer_class = SubscriptionsSerializer

class SubscriptionPlansViewSet(viewsets.ModelViewSet):
    queryset = SubscriptionPlans.objects.all()
    serializer_class = SubscriptionPlansSerializer

class SubscriptionCancellationReasonsViewSet(viewsets.ModelViewSet):
    queryset = SubscriptionCancellationReasons.objects.all()
    serializer_class = SubscriptionCancellationReasonsSerializer

class SubscriptionRenewalRemindersViewSet(viewsets.ModelViewSet):
    queryset = SubscriptionRenewalReminders.objects.all()
    serializer_class = SubscriptionRenewalRemindersSerializer

class SubscriptionPaymentMethodsViewSet(viewsets.ModelViewSet):
    queryset = SubscriptionPaymentMethods.objects.all()
    serializer_class = SubscriptionPaymentMethodsSerializer

class SubscriptionAnalyticsViewSet(viewsets.ModelViewSet):
    queryset = SubscriptionAnalytics.objects.all()
    serializer_class = SubscriptionAnalyticsSerializer

class SubscriptionDiscountsViewSet(viewsets.ModelViewSet):
    queryset = SubscriptionDiscounts.objects.all()
    serializer_class = SubscriptionDiscountsSerializer

class SubscriptionCustomizationOptionsViewSet(viewsets.ModelViewSet):
    queryset = SubscriptionCustomizationOptions.objects.all()
    serializer_class = SubscriptionCustomizationOptionsSerializer

class SubscriptionUsageTrackingViewSet(viewsets.ModelViewSet):
    queryset = SubscriptionUsageTracking.objects.all()
    serializer_class = SubscriptionUsageTrackingSerializer

