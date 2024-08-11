from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import (
    RevenueAnalyticsViewSet, CustomerBehaviorAnalyticsViewSet, ProductPerformanceAnalyticsViewSet,
    OrderFulfillmentAnalyticsViewSet, InventoryManagementAnalyticsViewSet,
    MarketingCampaignAnalyticsViewSet, CustomerServiceAnalyticsViewSet,
    UserEngagementAnalyticsViewSet, ConversionRateOptimizationAnalyticsViewSet,
    FinancialReportingViewSet, DataVisualizationDashboardsViewSet, CustomReportingViewSet
)

router = DefaultRouter()
router.register(r'revenue_analytics', RevenueAnalyticsViewSet)
router.register(r'customer_behavior_analytics', CustomerBehaviorAnalyticsViewSet)
router.register(r'product_performance_analytics', ProductPerformanceAnalyticsViewSet)
router.register(r'order_fulfillment_analytics', OrderFulfillmentAnalyticsViewSet)
router.register(r'inventory_management_analytics', InventoryManagementAnalyticsViewSet)
router.register(r'marketing_campaign_analytics', MarketingCampaignAnalyticsViewSet)
router.register(r'customer_service_analytics', CustomerServiceAnalyticsViewSet)
router.register(r'user_engagement_analytics', UserEngagementAnalyticsViewSet)
router.register(r'cro_analytics', ConversionRateOptimizationAnalyticsViewSet)
router.register(r'financial_reporting', FinancialReportingViewSet)
router.register(r'dashboards', DataVisualizationDashboardsViewSet)
router.register(r'custom_reporting', CustomReportingViewSet)

urlpatterns = [
    path('', include(router.urls)),
]
