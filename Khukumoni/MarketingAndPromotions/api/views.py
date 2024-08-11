from rest_framework import viewsets
from ..models import (
    PromotionRules, PromotionCoupons, PromotionSegments, PromotionAnalytics,
    PromotionTargeting, PromotionABTesting, PromotionContent,
    PromotionPersonalization, PromotionCollaborationHistory,
    PromotionAutomation, PromotionIntegrations
)
from .serializers import (
    PromotionRulesSerializer, PromotionCouponsSerializer, PromotionSegmentsSerializer,
    PromotionAnalyticsSerializer, PromotionTargetingSerializer, PromotionABTestingSerializer,
    PromotionContentSerializer, PromotionPersonalizationSerializer,
    PromotionCollaborationHistorySerializer, PromotionAutomationSerializer,
    PromotionIntegrationsSerializer
)

class PromotionRulesViewSet(viewsets.ModelViewSet):
    queryset = PromotionRules.objects.all()
    serializer_class = PromotionRulesSerializer

class PromotionCouponsViewSet(viewsets.ModelViewSet):
    queryset = PromotionCoupons.objects.all()
    serializer_class = PromotionCouponsSerializer

class PromotionSegmentsViewSet(viewsets.ModelViewSet):
    queryset = PromotionSegments.objects.all()
    serializer_class = PromotionSegmentsSerializer

class PromotionAnalyticsViewSet(viewsets.ModelViewSet):
    queryset = PromotionAnalytics.objects.all()
    serializer_class = PromotionAnalyticsSerializer

class PromotionTargetingViewSet(viewsets.ModelViewSet):
    queryset = PromotionTargeting.objects.all()
    serializer_class = PromotionTargetingSerializer

class PromotionABTestingViewSet(viewsets.ModelViewSet):
    queryset = PromotionABTesting.objects.all()
    serializer_class = PromotionABTestingSerializer

class PromotionContentViewSet(viewsets.ModelViewSet):
    queryset = PromotionContent.objects.all()
    serializer_class = PromotionContentSerializer

class PromotionPersonalizationViewSet(viewsets.ModelViewSet):
    queryset = PromotionPersonalization.objects.all()
    serializer_class = PromotionPersonalizationSerializer

class PromotionCollaborationHistoryViewSet(viewsets.ModelViewSet):
    queryset = PromotionCollaborationHistory.objects.all()
    serializer_class = PromotionCollaborationHistorySerializer

class PromotionAutomationViewSet(viewsets.ModelViewSet):
    queryset = PromotionAutomation.objects.all()
    serializer_class = PromotionAutomationSerializer

class PromotionIntegrationsViewSet(viewsets.ModelViewSet):
    queryset = PromotionIntegrations.objects.all()
    serializer_class = PromotionIntegrationsSerializer
