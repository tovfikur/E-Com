from django.db import models

class Review(models.Model):
    review_id = models.AutoField(primary_key=True)
    product_id = models.IntegerField()
    user_id = models.IntegerField()
    rating = models.IntegerField()
    review_text = models.TextField()
    status = models.CharField(max_length=20)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class ReviewReply(models.Model):
    reply_id = models.AutoField(primary_key=True)
    review_id = models.ForeignKey(Review, on_delete=models.CASCADE)
    user_id = models.IntegerField()
    reply_text = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class ReviewFilter(models.Model):
    filter_id = models.AutoField(primary_key=True)
    criteria = models.CharField(max_length=255)
    sort_order = models.CharField(max_length=20)
    created_at = models.DateTimeField(auto_now_add=True)

class ReviewReport(models.Model):
    report_id = models.AutoField(primary_key=True)
    review_id = models.ForeignKey(Review, on_delete=models.CASCADE)
    report_reason = models.CharField(max_length=255)
    status = models.CharField(max_length=20)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class ReviewNotification(models.Model):
    notification_id = models.AutoField(primary_key=True)
    user_id = models.IntegerField()
    subscribed = models.BooleanField(default=False)
    created_at = models.DateTimeField(auto_now_add=True)

class ReviewAnalytics(models.Model):
    analytics_id = models.AutoField(primary_key=True)
    review_id = models.ForeignKey(Review, on_delete=models.CASCADE)
    views = models.IntegerField()
    engagement = models.IntegerField()
    sentiment = models.CharField(max_length=255)
    trend = models.CharField(max_length=255)
    updated_at = models.DateTimeField(auto_now=True)

class ReviewImportExport(models.Model):
    operation_id = models.AutoField(primary_key=True)
    operation_type = models.CharField(max_length=20)
    date_range = models.CharField(max_length=255)
    status = models.CharField(max_length=20)
    created_at = models.DateTimeField(auto_now_add=True)
    completed_at = models.DateTimeField(null=True, blank=True)

class ReviewResponseTemplate(models.Model):
    template_id = models.AutoField(primary_key=True)
    template_name = models.CharField(max_length=255)
    template_text = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class ReviewAggregation(models.Model):
    aggregation_id = models.AutoField(primary_key=True)
    product_id = models.IntegerField()
    summary = models.TextField()
    sentiment = models.CharField(max_length=255)
    trends = models.TextField()
    updated_at = models.DateTimeField(auto_now=True)

class ReviewIntegration(models.Model):
    integration_id = models.AutoField(primary_key=True)
    platform_name = models.CharField(max_length=255)
    details = models.JSONField()
    status = models.CharField(max_length=20)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class ReviewGamification(models.Model):
    gamification_id = models.AutoField(primary_key=True)
    settings = models.JSONField()
    leaderboard = models.JSONField()
    rewards = models.JSONField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class ReviewAuthentication(models.Model):
    auth_id = models.AutoField(primary_key=True)
    review_id = models.ForeignKey(Review, on_delete=models.CASCADE)
    verification_token = models.CharField(max_length=255)
    status = models.CharField(max_length=20)
    created_at = models.DateTimeField(auto_now_add=True)
    verified_at = models.DateTimeField(null=True, blank=True)
