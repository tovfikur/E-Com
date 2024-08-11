from django.db import models

class PersonalizedRecommendation(models.Model):
    recommendation_id = models.AutoField(primary_key=True)
    customer_id = models.IntegerField()
    product_ids = models.JSONField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class SimilarProduct(models.Model):
    recommendation_id = models.AutoField(primary_key=True)
    product_id = models.IntegerField()
    similar_product_ids = models.JSONField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class TrendingProduct(models.Model):
    recommendation_id = models.AutoField(primary_key=True)
    product_ids = models.JSONField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class NewArrival(models.Model):
    recommendation_id = models.AutoField(primary_key=True)
    category_id = models.IntegerField()
    product_ids = models.JSONField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class Bestseller(models.Model):
    recommendation_id = models.AutoField(primary_key=True)
    category_id = models.IntegerField()
    product_ids = models.JSONField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class CrossSellProduct(models.Model):
    recommendation_id = models.AutoField(primary_key=True)
    product_id = models.IntegerField()
    cross_sell_product_ids = models.JSONField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class UpSellProduct(models.Model):
    recommendation_id = models.AutoField(primary_key=True)
    product_id = models.IntegerField()
    up_sell_product_ids = models.JSONField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class FrequentlyBoughtTogether(models.Model):
    recommendation_id = models.AutoField(primary_key=True)
    product_id = models.IntegerField()
    frequently_bought_together_product_ids = models.JSONField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class CustomerBasedRecommendation(models.Model):
    recommendation_id = models.AutoField(primary_key=True)
    customer_id = models.IntegerField()
    product_ids = models.JSONField()
    recommendation_type = models.CharField(max_length=50)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class DynamicPricingRecommendation(models.Model):
    recommendation_id = models.AutoField(primary_key=True)
    customer_id = models.IntegerField()
    product_ids = models.JSONField()
    pricing_details = models.JSONField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class RecommendationRule(models.Model):
    rule_id = models.AutoField(primary_key=True)
    rule_details = models.JSONField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class RealTimeRecommendationUpdate(models.Model):
    update_id = models.AutoField(primary_key=True)
    customer_id = models.IntegerField()
    product_ids = models.JSONField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class SegmentBasedRecommendation(models.Model):
    segment_id = models.AutoField(primary_key=True)
    product_ids = models.JSONField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class FeedbackRecommendation(models.Model):
    feedback_id = models.AutoField(primary_key=True)
    product_id = models.IntegerField()
    feedback_details = models.JSONField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class RecommendationPerformanceAnalytics(models.Model):
    analytics_id = models.AutoField(primary_key=True)
    product_id = models.IntegerField()
    views = models.IntegerField()
    conversions = models.IntegerField()
    click_through_rate = models.FloatField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class CustomerSpecificRecommendation(models.Model):
    recommendation_id = models.AutoField(primary_key=True)
    customer_id = models.IntegerField()
    product_ids = models.JSONField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
