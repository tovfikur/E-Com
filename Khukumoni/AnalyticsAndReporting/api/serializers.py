from rest_framework import serializers
from ..models import (
    RevenueAnalytics, CustomerBehaviorAnalytics, ProductPerformanceAnalytics,
    OrderFulfillmentAnalytics, InventoryManagementAnalytics,
    MarketingCampaignAnalytics, CustomerServiceAnalytics,
    UserEngagementAnalytics, ConversionRateOptimizationAnalytics,
    FinancialReporting, DataVisualizationDashboards, CustomReporting
)

class RevenueAnalyticsSerializer(serializers.ModelSerializer):
    class Meta:
        model = RevenueAnalytics
        fields = '__all__'

class CustomerBehaviorAnalyticsSerializer(serializers.ModelSerializer):
    class Meta:
        model = CustomerBehaviorAnalytics
        fields = '__all__'

class ProductPerformanceAnalyticsSerializer(serializers.ModelSerializer):
    class Meta:
        model = ProductPerformanceAnalytics
        fields = '__all__'

class OrderFulfillmentAnalyticsSerializer(serializers.ModelSerializer):
    class Meta:
        model = OrderFulfillmentAnalytics
        fields = '__all__'

class InventoryManagementAnalyticsSerializer(serializers.ModelSerializer):
    class Meta:
        model = InventoryManagementAnalytics
        fields = '__all__'

class MarketingCampaignAnalyticsSerializer(serializers.ModelSerializer):
    class Meta:
        model = MarketingCampaignAnalytics
        fields = '__all__'

class CustomerServiceAnalyticsSerializer(serializers.ModelSerializer):
    class Meta:
        model = CustomerServiceAnalytics
        fields = '__all__'

class UserEngagementAnalyticsSerializer(serializers.ModelSerializer):
    class Meta:
        model = UserEngagementAnalytics
        fields = '__all__'

class ConversionRateOptimizationAnalyticsSerializer(serializers.ModelSerializer):
    class Meta:
        model = ConversionRateOptimizationAnalytics
        fields = '__all__'

class FinancialReportingSerializer(serializers.ModelSerializer):
    class Meta:
        model = FinancialReporting
        fields = '__all__'

class DataVisualizationDashboardsSerializer(serializers.ModelSerializer):
    class Meta:
        model = DataVisualizationDashboards
        fields = '__all__'

class CustomReportingSerializer(serializers.ModelSerializer):
    class Meta:
        model = CustomReporting
        fields = '__all__'
