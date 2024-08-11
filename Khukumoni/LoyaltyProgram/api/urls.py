from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import (
    LoyaltyEnrollmentViewSet, LoyaltyPointsHistoryViewSet, LoyaltyRedemptionHistoryViewSet,
    LoyaltyTierViewSet, LoyaltyMembershipStatusViewSet, LoyaltyEarningOpportunityViewSet,
    LoyaltyCustomizationViewSet, LoyaltyPromotionViewSet, LoyaltyPointsTransferViewSet,
    LoyaltyAnalyticsViewSet, LoyaltyReferralViewSet, LoyaltyNotificationViewSet
)

router = DefaultRouter()

# Register all viewsets for all imported views
router.register(r'enrollment', LoyaltyEnrollmentViewSet)
router.register(r'points_history', LoyaltyPointsHistoryViewSet)
router.register(r'redemption_history', LoyaltyRedemptionHistoryViewSet)
router.register(r'tier', LoyaltyTierViewSet)
router.register(r'membership_status', LoyaltyMembershipStatusViewSet)
router.register(r'earning_opportunity', LoyaltyEarningOpportunityViewSet)
router.register(r'customization', LoyaltyCustomizationViewSet)
router.register(r'promotion', LoyaltyPromotionViewSet)
router.register(r'points_transfer', LoyaltyPointsTransferViewSet)
router.register(r'analytics', LoyaltyAnalyticsViewSet)
router.register(r'referral', LoyaltyReferralViewSet)
router.register(r'notification', LoyaltyNotificationViewSet)

urlpatterns = [
    path('', include(router.urls)),
]
