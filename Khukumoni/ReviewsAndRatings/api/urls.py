from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import (
    ReviewViewSet, ReviewReplyViewSet, ReviewFilterViewSet, ReviewReportViewSet, ReviewNotificationViewSet, 
    ReviewAnalyticsViewSet, ReviewImportExportViewSet, ReviewResponseTemplateViewSet, ReviewAggregationViewSet, 
    ReviewIntegrationViewSet, ReviewGamificationViewSet, ReviewAuthenticationViewSet
)

router = DefaultRouter()
router.register(r'review', ReviewViewSet)
router.register(r'review-reply', ReviewReplyViewSet)
router.register(r'review-filter', ReviewFilterViewSet)
router.register(r'review-report', ReviewReportViewSet)
router.register(r'review-notification', ReviewNotificationViewSet)
router.register(r'review-analytics', ReviewAnalyticsViewSet)
router.register(r'review-import-export', ReviewImportExportViewSet)
router.register(r'review-response-template', ReviewResponseTemplateViewSet)
router.register(r'review-aggregation', ReviewAggregationViewSet)
router.register(r'review-integration', ReviewIntegrationViewSet)
router.register(r'review-gamification', ReviewGamificationViewSet)
router.register(r'review-authentication', ReviewAuthenticationViewSet)

urlpatterns = [
    path('', include(router.urls)),
]
