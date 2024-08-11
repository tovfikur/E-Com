from django.contrib import admin
from .models import (
    RevenueAnalytics, CustomerBehaviorAnalytics, ProductPerformanceAnalytics,
    OrderFulfillmentAnalytics, InventoryManagementAnalytics,
    MarketingCampaignAnalytics, CustomerServiceAnalytics,
    UserEngagementAnalytics, ConversionRateOptimizationAnalytics,
    FinancialReporting, DataVisualizationDashboards, CustomReporting
)

@admin.register(RevenueAnalytics)
class RevenueAnalyticsAdmin(admin.ModelAdmin):
    list_display = ('analytics_id', 'date', 'revenue', 'profit', 'sales_channels', 'sales_by_region')
    search_fields = ('date',)

@admin.register(CustomerBehaviorAnalytics)
class CustomerBehaviorAnalyticsAdmin(admin.ModelAdmin):
    list_display = ('analytics_id', 'date', 'customer_acquisition', 'customer_retention', 'customer_lifetime_value', 'customer_segments')
    search_fields = ('date',)

@admin.register(ProductPerformanceAnalytics)
class ProductPerformanceAnalyticsAdmin(admin.ModelAdmin):
    list_display = ('analytics_id', 'date', 'product_views', 'product_purchases', 'product_feedback', 'product_recommendations')
    search_fields = ('date',)

@admin.register(OrderFulfillmentAnalytics)
class OrderFulfillmentAnalyticsAdmin(admin.ModelAdmin):
    list_display = ('analytics_id', 'date', 'fulfillment_speed', 'fulfillment_accuracy', 'fulfillment_costs')
    search_fields = ('date',)

@admin.register(InventoryManagementAnalytics)
class InventoryManagementAnalyticsAdmin(admin.ModelAdmin):
    list_display = ('analytics_id', 'date', 'inventory_turnover', 'inventory_age', 'inventory_levels', 'inventory_valuation')
    search_fields = ('date',)

@admin.register(MarketingCampaignAnalytics)
class MarketingCampaignAnalyticsAdmin(admin.ModelAdmin):
    list_display = ('analytics_id', 'date', 'campaign_performance', 'channel_effectiveness', 'marketing_roi')
    search_fields = ('date',)

@admin.register(CustomerServiceAnalytics)
class CustomerServiceAnalyticsAdmin(admin.ModelAdmin):
    list_display = ('analytics_id', 'date', 'support_tickets', 'feedback_sentiment', 'satisfaction_scores')
    search_fields = ('date',)

@admin.register(UserEngagementAnalytics)
class UserEngagementAnalyticsAdmin(admin.ModelAdmin):
    list_display = ('analytics_id', 'date', 'user_activity', 'user_retention', 'churn_rate')
    search_fields = ('date',)

@admin.register(ConversionRateOptimizationAnalytics)
class ConversionRateOptimizationAnalyticsAdmin(admin.ModelAdmin):
    list_display = ('analytics_id', 'date', 'conversion_funnel', 'ab_testing_results', 'landing_page_performance')
    search_fields = ('date',)

@admin.register(FinancialReporting)
class FinancialReportingAdmin(admin.ModelAdmin):
    list_display = ('report_id', 'report_type', 'report_details', 'generated_at')
    search_fields = ('report_type',)

@admin.register(DataVisualizationDashboards)
class DataVisualizationDashboardsAdmin(admin.ModelAdmin):
    list_display = ('dashboard_id', 'dashboard_name', 'dashboard_content', 'created_at', 'updated_at')
    search_fields = ('dashboard_name',)

@admin.register(CustomReporting)
class CustomReportingAdmin(admin.ModelAdmin):
    list_display = ('report_id', 'report_name', 'report_details', 'created_at', 'updated_at')
    search_fields = ('report_name',)

