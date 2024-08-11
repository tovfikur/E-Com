from django.db import models

class LoyaltyEnrollment(models.Model):
    enrollment_id = models.AutoField(primary_key=True)
    customer_id = models.IntegerField()
    enrollment_date = models.DateTimeField()
    status = models.CharField(max_length=50)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class LoyaltyPointsHistory(models.Model):
    history_id = models.AutoField(primary_key=True)
    customer_id = models.IntegerField()
    points = models.IntegerField()
    activity_type = models.CharField(max_length=50)
    description = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class LoyaltyRedemptionHistory(models.Model):
    redemption_id = models.AutoField(primary_key=True)
    customer_id = models.IntegerField()
    points_redeemed = models.IntegerField()
    redemption_date = models.DateTimeField()
    item_redeemed = models.CharField(max_length=255)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class LoyaltyTier(models.Model):
    tier_id = models.AutoField(primary_key=True)
    tier_name = models.CharField(max_length=255)
    tier_details = models.TextField()
    tier_benefits = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class LoyaltyMembershipStatus(models.Model):
    status_id = models.AutoField(primary_key=True)
    customer_id = models.IntegerField()
    current_tier = models.ForeignKey(LoyaltyTier, on_delete=models.CASCADE)
    status = models.CharField(max_length=50)
    points_balance = models.IntegerField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class LoyaltyEarningOpportunity(models.Model):
    opportunity_id = models.AutoField(primary_key=True)
    customer_id = models.IntegerField()
    activity_id = models.IntegerField()
    activity_details = models.TextField()
    points = models.IntegerField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class LoyaltyCustomization(models.Model):
    customization_id = models.AutoField(primary_key=True)
    rules = models.JSONField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class LoyaltyPromotion(models.Model):
    promotion_id = models.AutoField(primary_key=True)
    promotion_details = models.TextField()
    start_date = models.DateTimeField()
    end_date = models.DateTimeField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class LoyaltyPointsTransfer(models.Model):
    transfer_id = models.AutoField(primary_key=True)
    from_customer_id = models.IntegerField()
    to_customer_id = models.IntegerField()
    points = models.IntegerField()
    transfer_date = models.DateTimeField()
    status = models.CharField(max_length=50)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class LoyaltyAnalytics(models.Model):
    analytics_id = models.AutoField(primary_key=True)
    metric = models.CharField(max_length=50)
    value = models.IntegerField()
    period = models.CharField(max_length=50)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class LoyaltyReferral(models.Model):
    referral_id = models.AutoField(primary_key=True)
    referrer_id = models.IntegerField()
    referred_id = models.IntegerField()
    referral_date = models.DateTimeField()
    points_awarded = models.IntegerField()
    status = models.CharField(max_length=50)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class LoyaltyNotification(models.Model):
    notification_id = models.AutoField(primary_key=True)
    customer_id = models.IntegerField()
    notification_type = models.CharField(max_length=50)
    status = models.CharField(max_length=50)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
