from django.db import models

class Subscriptions(models.Model):
    subscription_id = models.AutoField(primary_key=True)
    user_id = models.IntegerField()
    plan_id = models.IntegerField()
    start_date = models.DateTimeField()
    end_date = models.DateTimeField()
    status = models.CharField(max_length=50)
    billing_cycle = models.CharField(max_length=50)
    next_billing_date = models.DateTimeField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class SubscriptionPlans(models.Model):
    plan_id = models.AutoField(primary_key=True)
    plan_name = models.CharField(max_length=255)
    description = models.TextField()
    price = models.DecimalField(max_digits=10, decimal_places=2)
    currency = models.CharField(max_length=10)
    billing_cycle = models.CharField(max_length=50)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class SubscriptionCancellationReasons(models.Model):
    reason_id = models.AutoField(primary_key=True)
    reason_text = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class SubscriptionRenewalReminders(models.Model):
    reminder_id = models.AutoField(primary_key=True)
    user_id = models.IntegerField()
    reminder_date = models.DateTimeField()
    reminder_status = models.CharField(max_length=50)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class SubscriptionPaymentMethods(models.Model):
    method_id = models.AutoField(primary_key=True)
    user_id = models.IntegerField()
    payment_method_type = models.CharField(max_length=50)
    payment_details = models.JSONField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class SubscriptionUsageTracking(models.Model):
    usage_id = models.AutoField(primary_key=True)
    subscription_id = models.IntegerField()
    usage_details = models.JSONField()
    usage_date = models.DateTimeField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class SubscriptionAnalytics(models.Model):
    analytics_id = models.AutoField(primary_key=True)
    subscription_id = models.IntegerField()
    metric_name = models.CharField(max_length=255)
    metric_value = models.DecimalField(max_digits=10, decimal_places=2)
    metric_date = models.DateTimeField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class SubscriptionDiscounts(models.Model):
    discount_id = models.AutoField(primary_key=True)
    subscription_id = models.IntegerField()
    discount_code = models.CharField(max_length=50)
    discount_amount = models.DecimalField(max_digits=10, decimal_places=2)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class SubscriptionCustomizationOptions(models.Model):
    option_id = models.AutoField(primary_key=True)
    subscription_id = models.IntegerField()
    option_name = models.CharField(max_length=255)
    option_value = models.CharField(max_length=255)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
