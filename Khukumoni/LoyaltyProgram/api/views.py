from rest_framework import viewsets
from ..models import (LoyaltyEnrollment, LoyaltyPointsHistory, LoyaltyRedemptionHistory, LoyaltyTier,
LoyaltyMembershipStatus, LoyaltyEarningOpportunity, LoyaltyCustomization, LoyaltyPromotion, LoyaltyPointsTransfer,
LoyaltyAnalytics, LoyaltyReferral, LoyaltyNotification )

from .serializers import (
    LoyaltyEnrollmentSerializer, LoyaltyPointsHistorySerializer,
    LoyaltyRedemptionHistorySerializer, LoyaltyTierSerializer,
    LoyaltyMembershipStatusSerializer, LoyaltyEarningOpportunitySerializer,
    LoyaltyCustomizationSerializer, LoyaltyPromotionSerializer,
    LoyaltyPointsTransferSerializer, LoyaltyAnalyticsSerializer,
    LoyaltyReferralSerializer, LoyaltyNotificationSerializer,
)

class LoyaltyEnrollmentViewSet(viewsets.ModelViewSet):
    queryset = LoyaltyEnrollment.objects.all()
    serializer_class = LoyaltyEnrollmentSerializer

class LoyaltyPointsHistoryViewSet(viewsets.ModelViewSet):
    queryset = LoyaltyPointsHistory.objects.all()
    serializer_class = LoyaltyPointsHistorySerializer

class LoyaltyRedemptionHistoryViewSet(viewsets.ModelViewSet):
    queryset = LoyaltyRedemptionHistory.objects.all()
    serializer_class = LoyaltyRedemptionHistorySerializer

class LoyaltyTierViewSet(viewsets.ModelViewSet):
    queryset = LoyaltyTier.objects.all()
    serializer_class = LoyaltyTierSerializer

class LoyaltyMembershipStatusViewSet(viewsets.ModelViewSet):
    queryset = LoyaltyMembershipStatus.objects.all()
    serializer_class = LoyaltyMembershipStatusSerializer

class LoyaltyEarningOpportunityViewSet(viewsets.ModelViewSet):
    queryset = LoyaltyEarningOpportunity.objects.all()
    serializer_class = LoyaltyEarningOpportunitySerializer

class LoyaltyCustomizationViewSet(viewsets.ModelViewSet):
    queryset = LoyaltyCustomization.objects.all()
    serializer_class = LoyaltyCustomizationSerializer

class LoyaltyPromotionViewSet(viewsets.ModelViewSet):
    queryset = LoyaltyPromotion.objects.all()
    serializer_class = LoyaltyPromotionSerializer

class LoyaltyPointsTransferViewSet(viewsets.ModelViewSet):
    queryset = LoyaltyPointsTransfer.objects.all()
    serializer_class = LoyaltyPointsTransferSerializer

class LoyaltyAnalyticsViewSet(viewsets.ModelViewSet):
    queryset = LoyaltyAnalytics.objects.all()
    serializer_class = LoyaltyAnalyticsSerializer

class LoyaltyReferralViewSet(viewsets.ModelViewSet):
    queryset = LoyaltyReferral.objects.all()
    serializer_class = LoyaltyReferralSerializer

class LoyaltyNotificationViewSet(viewsets.ModelViewSet):
    queryset = LoyaltyNotification.objects.all()
    serializer_class = LoyaltyNotificationSerializer

