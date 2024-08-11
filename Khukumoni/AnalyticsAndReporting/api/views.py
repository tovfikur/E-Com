from rest_framework import viewsets
from ..models import (
    RevenueAnalytics, CustomerBehaviorAnalytics, ProductPerformanceAnalytics,
    OrderFulfillmentAnalytics, InventoryManagementAnalytics,
    MarketingCampaignAnalytics, CustomerServiceAnalytics,
    UserEngagementAnalytics, ConversionRateOptimizationAnalytics,
    FinancialReporting, DataVisualizationDashboards, CustomReporting
)
from .serializers import (
    RevenueAnalyticsSerializer, CustomerBehaviorAnalyticsSerializer, ProductPerformanceAnalyticsSerializer,
    OrderFulfillmentAnalyticsSerializer, InventoryManagementAnalyticsSerializer,
    MarketingCampaignAnalyticsSerializer, CustomerServiceAnalyticsSerializer,
    UserEngagementAnalyticsSerializer, ConversionRateOptimizationAnalyticsSerializer,
    FinancialReportingSerializer, DataVisualizationDashboardsSerializer, CustomReportingSerializer
)

class RevenueAnalyticsViewSet(viewsets.ModelViewSet):
    queryset = RevenueAnalytics.objects.all()
    serializer_class = RevenueAnalyticsSerializer

class CustomerBehaviorAnalyticsViewSet(viewsets.ModelViewSet):
    queryset = CustomerBehaviorAnalytics.objects.all()
    serializer_class = CustomerBehaviorAnalyticsSerializer

class ProductPerformanceAnalyticsViewSet(viewsets.ModelViewSet):
    queryset = ProductPerformanceAnalytics.objects.all()
    serializer_class = ProductPerformanceAnalyticsSerializer

class OrderFulfillmentAnalyticsViewSet(viewsets.ModelViewSet):
    queryset = OrderFulfillmentAnalytics.objects.all()
    serializer_class = OrderFulfillmentAnalyticsSerializer

class InventoryManagementAnalyticsViewSet(viewsets.ModelViewSet):
    queryset = InventoryManagementAnalytics.objects.all()
    serializer_class = InventoryManagementAnalyticsSerializer

class MarketingCampaignAnalyticsViewSet(viewsets.ModelViewSet):
    queryset = MarketingCampaignAnalytics.objects.all()
    serializer_class = MarketingCampaignAnalyticsSerializer

class CustomerServiceAnalyticsViewSet(viewsets.ModelViewSet):
    queryset = CustomerServiceAnalytics.objects.all()
    serializer_class = CustomerServiceAnalyticsSerializer

class UserEngagementAnalyticsViewSet(viewsets.ModelViewSet):
    queryset = UserEngagementAnalytics.objects.all()
    serializer_class = UserEngagementAnalyticsSerializer

class ConversionRateOptimizationAnalyticsViewSet(viewsets.ModelViewSet):
    queryset = ConversionRateOptimizationAnalytics.objects.all()
    serializer_class = ConversionRateOptimizationAnalyticsSerializer

class FinancialReportingViewSet(viewsets.ModelViewSet):
    queryset = FinancialReporting.objects.all()
    serializer_class = FinancialReportingSerializer

class DataVisualizationDashboardsViewSet(viewsets.ModelViewSet):
    queryset = DataVisualizationDashboards.objects.all()
    serializer_class = DataVisualizationDashboardsSerializer

class CustomReportingViewSet(viewsets.ModelViewSet):
    queryset = CustomReporting.objects.all()
    serializer_class = CustomReportingSerializer
