from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import (
    SubscriptionsViewSet, SubscriptionPlansViewSet, SubscriptionCancellationReasonsViewSet,
    SubscriptionRenewalRemindersViewSet, SubscriptionPaymentMethodsViewSet, SubscriptionUsageTrackingViewSet,
    SubscriptionAnalyticsViewSet, SubscriptionDiscountsViewSet, SubscriptionCustomizationOptionsViewSet
)

router = DefaultRouter()
router.register(r'subscriptions', SubscriptionsViewSet)
router.register(r'subscriptionplans', SubscriptionPlansViewSet)
router.register(r'subscriptioncancellationreasons', SubscriptionCancellationReasonsViewSet)
router.register(r'subscriptionrenewalreminders', SubscriptionRenewalRemindersViewSet)
router.register(r'subscriptionpaymentmethods', SubscriptionPaymentMethodsViewSet)
router.register(r'subscriptionusagetracking', SubscriptionUsageTrackingViewSet)
router.register(r'subscriptionanalytics', SubscriptionAnalyticsViewSet)
router.register(r'subscriptiondiscounts', SubscriptionDiscountsViewSet)
router.register(r'subscriptioncustomizationoptions', SubscriptionCustomizationOptionsViewSet)

urlpatterns = [
    path('', include(router.urls)),
]
