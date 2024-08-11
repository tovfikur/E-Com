from django.db import models

class SocialShare(models.Model):
    share_id = models.AutoField(primary_key=True)
    user_id = models.IntegerField()
    platform = models.CharField(max_length=50)
    content_id = models.IntegerField()
    share_url = models.CharField(max_length=255)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class SocialAnalytics(models.Model):
    analytics_id = models.AutoField(primary_key=True)
    share_id = models.ForeignKey(SocialShare, on_delete=models.CASCADE)
    views = models.IntegerField()
    engagement = models.IntegerField()
    conversions = models.IntegerField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class SocialLike(models.Model):
    like_id = models.AutoField(primary_key=True)
    user_id = models.IntegerField()
    post_id = models.IntegerField()
    action = models.CharField(max_length=50)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class SocialComment(models.Model):
    comment_id = models.AutoField(primary_key=True)
    user_id = models.IntegerField()
    post_id = models.IntegerField()
    comment_text = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class SocialPrivacy(models.Model):
    post_id = models.IntegerField(primary_key=True)
    user_id = models.IntegerField()
    privacy_level = models.CharField(max_length=50)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class UserSocialProfile(models.Model):
    profile_id = models.AutoField(primary_key=True)
    user_id = models.IntegerField()
    platform = models.CharField(max_length=50)
    share_count = models.IntegerField()
    like_count = models.IntegerField()
    comment_count = models.IntegerField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class SocialBadge(models.Model):
    badge_id = models.AutoField(primary_key=True)
    user_id = models.IntegerField()
    badge_name = models.CharField(max_length=255)
    earned_at = models.DateTimeField()

class SocialReward(models.Model):
    reward_id = models.AutoField(primary_key=True)
    user_id = models.IntegerField()
    reward_name = models.CharField(max_length=255)
    points = models.IntegerField()
    earned_at = models.DateTimeField()

class SocialRecommendation(models.Model):
    recommendation_id = models.AutoField(primary_key=True)
    user_id = models.IntegerField()
    content_id = models.IntegerField()
    recommendation_type = models.CharField(max_length=50)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class SocialTrendingTopic(models.Model):
    trend_id = models.AutoField(primary_key=True)
    category_id = models.IntegerField()
    trend_name = models.CharField(max_length=255)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class InfluencerCampaign(models.Model):
    campaign_id = models.AutoField(primary_key=True)
    influencer_id = models.IntegerField()
    campaign_details = models.TextField()
    stats = models.JSONField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class SocialCollaboration(models.Model):
    collaboration_id = models.AutoField(primary_key=True)
    partner_id = models.IntegerField()
    user_id = models.IntegerField()
    status = models.CharField(max_length=50)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class CMSIntegration(models.Model):
    integration_id = models.AutoField(primary_key=True)
    cms_id = models.IntegerField()
    configuration = models.JSONField()
    status = models.CharField(max_length=50)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
