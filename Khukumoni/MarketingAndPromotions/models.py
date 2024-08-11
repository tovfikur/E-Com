from django.db import models

class PromotionRules(models.Model):
    rule_id = models.IntegerField(primary_key=True)
    rule_name = models.CharField(max_length=255)
    rule_description = models.TextField()
    conditions = models.JSONField()
    actions = models.JSONField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class PromotionCoupons(models.Model):
    coupon_id = models.IntegerField(primary_key=True)
    coupon_code = models.CharField(max_length=255)
    discount_type = models.CharField(max_length=255)
    discount_value = models.DecimalField(max_digits=10, decimal_places=2)
    max_uses = models.IntegerField()
    uses_counter = models.IntegerField()
    expiration_date = models.DateTimeField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class PromotionSegments(models.Model):
    segment_id = models.IntegerField(primary_key=True)
    segment_name = models.CharField(max_length=255)
    segment_criteria = models.JSONField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class PromotionAnalytics(models.Model):
    analytics_id = models.IntegerField(primary_key=True)
    promotion_id = models.IntegerField()
    sales = models.DecimalField(max_digits=10, decimal_places=2)
    conversions = models.IntegerField()
    engagement = models.IntegerField()
    roi = models.DecimalField(max_digits=10, decimal_places=2)
    analytics_date = models.DateField()

class PromotionTargeting(models.Model):
    targeting_id = models.IntegerField(primary_key=True)
    promotion_id = models.IntegerField()
    target_type = models.CharField(max_length=255)
    target_details = models.JSONField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class PromotionABTesting(models.Model):
    test_id = models.IntegerField(primary_key=True)
    test_name = models.CharField(max_length=255)
    test_description = models.TextField()
    test_settings = models.JSONField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class PromotionContent(models.Model):
    content_id = models.IntegerField(primary_key=True)
    promotion_id = models.IntegerField()
    content_type = models.CharField(max_length=255)
    content_details = models.JSONField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class PromotionPersonalization(models.Model):
    personalization_id = models.IntegerField(primary_key=True)
    promotion_id = models.IntegerField()
    personalization_details = models.JSONField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class PromotionCollaborationHistory(models.Model):
    collaboration_id = models.IntegerField(primary_key=True)
    promotion_id = models.IntegerField()
    action = models.CharField(max_length=255)
    user_id = models.IntegerField()
    timestamp = models.DateTimeField()

class PromotionAutomation(models.Model):
    automation_id = models.IntegerField(primary_key=True)
    automation_name = models.CharField(max_length=255)
    automation_type = models.CharField(max_length=255)
    automation_details = models.JSONField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class PromotionIntegrations(models.Model):
    integration_id = models.IntegerField(primary_key=True)
    integration_name = models.CharField(max_length=255)
    integration_details = models.JSONField()
    enabled = models.BooleanField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
