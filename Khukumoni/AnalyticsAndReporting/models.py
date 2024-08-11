from django.db import models

class RevenueAnalytics(models.Model):
    analytics_id = models.AutoField(primary_key=True)
    date = models.DateField()
    revenue = models.DecimalField(max_digits=10, decimal_places=2)
    profit = models.DecimalField(max_digits=10, decimal_places=2)
    sales_channels = models.JSONField()
    sales_by_region = models.JSONField()

class CustomerBehaviorAnalytics(models.Model):
    analytics_id = models.AutoField(primary_key=True)
    date = models.DateField()
    customer_acquisition = models.IntegerField()
    customer_retention = models.IntegerField()
    customer_lifetime_value = models.DecimalField(max_digits=10, decimal_places=2)
    customer_segments = models.JSONField()

class ProductPerformanceAnalytics(models.Model):
    analytics_id = models.AutoField(primary_key=True)
    date = models.DateField()
    product_views = models.IntegerField()
    product_purchases = models.IntegerField()
    product_feedback = models.JSONField()
    product_recommendations = models.JSONField()

class OrderFulfillmentAnalytics(models.Model):
    analytics_id = models.AutoField(primary_key=True)
    date = models.DateField()
    fulfillment_speed = models.DecimalField(max_digits=10, decimal_places=2)
    fulfillment_accuracy = models.DecimalField(max_digits=10, decimal_places=2)
    fulfillment_costs = models.DecimalField(max_digits=10, decimal_places=2)

class InventoryManagementAnalytics(models.Model):
    analytics_id = models.AutoField(primary_key=True)
    date = models.DateField()
    inventory_turnover = models.DecimalField(max_digits=10, decimal_places=2)
    inventory_age = models.DecimalField(max_digits=10, decimal_places=2)
    inventory_levels = models.JSONField()
    inventory_valuation = models.DecimalField(max_digits=10, decimal_places=2)

class MarketingCampaignAnalytics(models.Model):
    analytics_id = models.AutoField(primary_key=True)
    date = models.DateField()
    campaign_performance = models.JSONField()
    channel_effectiveness = models.JSONField()
    marketing_roi = models.DecimalField(max_digits=10, decimal_places=2)

class CustomerServiceAnalytics(models.Model):
    analytics_id = models.AutoField(primary_key=True)
    date = models.DateField()
    support_tickets = models.IntegerField()
    feedback_sentiment = models.JSONField()
    satisfaction_scores = models.JSONField()

class UserEngagementAnalytics(models.Model):
    analytics_id = models.AutoField(primary_key=True)
    date = models.DateField()
    user_activity = models.JSONField()
    user_retention = models.DecimalField(max_digits=10, decimal_places=2)
    churn_rate = models.DecimalField(max_digits=10, decimal_places=2)

class ConversionRateOptimizationAnalytics(models.Model):
    analytics_id = models.AutoField(primary_key=True)
    date = models.DateField()
    conversion_funnel = models.JSONField()
    ab_testing_results = models.JSONField()
    landing_page_performance = models.JSONField()

class FinancialReporting(models.Model):
    report_id = models.AutoField(primary_key=True)
    report_type = models.CharField(max_length=255)
    report_details = models.JSONField()
    generated_at = models.DateTimeField()

class DataVisualizationDashboards(models.Model):
    dashboard_id = models.AutoField(primary_key=True)
    dashboard_name = models.CharField(max_length=255)
    dashboard_content = models.JSONField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class CustomReporting(models.Model):
    report_id = models.AutoField(primary_key=True)
    report_name = models.CharField(max_length=255)
    report_details = models.JSONField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
