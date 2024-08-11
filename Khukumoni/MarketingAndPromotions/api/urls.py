from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import (
    PromotionRulesViewSet, PromotionCouponsViewSet, PromotionSegmentsViewSet,
    PromotionAnalyticsViewSet, PromotionTargetingViewSet, PromotionABTestingViewSet,
    PromotionContentViewSet, PromotionPersonalizationViewSet,
    PromotionCollaborationHistoryViewSet, PromotionAutomationViewSet,
    PromotionIntegrationsViewSet
)

router = DefaultRouter()
router.register(r'promotion_rules', PromotionRulesViewSet)
router.register(r'promotion_coupons', PromotionCouponsViewSet)
router.register(r'promotion_segments', PromotionSegmentsViewSet)
router.register(r'promotion_analytics', PromotionAnalyticsViewSet)
router.register(r'promotion_targeting', PromotionTargetingViewSet)
router.register(r'promotion_ab_testing', PromotionABTestingViewSet)
router.register(r'promotion_content', PromotionContentViewSet)
router.register(r'promotion_personalization', PromotionPersonalizationViewSet)
router.register(r'promotion_collaboration_history', PromotionCollaborationHistoryViewSet)
router.register(r'promotion_automation', PromotionAutomationViewSet)
router.register(r'promotion_integrations', PromotionIntegrationsViewSet)

urlpatterns = [
    path('', include(router.urls)),
]
