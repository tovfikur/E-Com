from django.contrib import admin
from .models import SocialShare, SocialAnalytics, SocialLike, SocialComment, SocialPrivacy, UserSocialProfile, SocialBadge, SocialReward, SocialRecommendation, SocialTrendingTopic, InfluencerCampaign, SocialCollaboration, CMSIntegration

class SocialShareAdmin(admin.ModelAdmin):
    list_display = ('share_id', 'user_id', 'platform', 'content_id', 'share_url', 'created_at', 'updated_at')
    search_fields = ('user_id', 'platform', 'content_id')

class SocialAnalyticsAdmin(admin.ModelAdmin):
    list_display = ('analytics_id', 'share_id', 'views', 'engagement', 'conversions', 'created_at', 'updated_at')
    search_fields = ('share_id',)

class SocialLikeAdmin(admin.ModelAdmin):
    list_display = ('like_id', 'user_id', 'post_id', 'action', 'created_at', 'updated_at')
    search_fields = ('user_id', 'post_id', 'action')

class SocialCommentAdmin(admin.ModelAdmin):
    list_display = ('comment_id', 'user_id', 'post_id', 'comment_text', 'created_at', 'updated_at')
    search_fields = ('user_id', 'post_id')

class SocialPrivacyAdmin(admin.ModelAdmin):
    list_display = ('post_id', 'user_id', 'privacy_level', 'created_at', 'updated_at')
    search_fields = ('post_id', 'user_id', 'privacy_level')

class UserSocialProfileAdmin(admin.ModelAdmin):
    list_display = ('profile_id', 'user_id', 'platform', 'share_count', 'like_count', 'comment_count', 'created_at', 'updated_at')
    search_fields = ('user_id', 'platform')

class SocialBadgeAdmin(admin.ModelAdmin):
    list_display = ('badge_id', 'user_id', 'badge_name', 'earned_at')
    search_fields = ('user_id', 'badge_name')

class SocialRewardAdmin(admin.ModelAdmin):
    list_display = ('reward_id', 'user_id', 'reward_name', 'points', 'earned_at')
    search_fields = ('user_id', 'reward_name')

class SocialRecommendationAdmin(admin.ModelAdmin):
    list_display = ('recommendation_id', 'user_id', 'content_id', 'recommendation_type', 'created_at', 'updated_at')
    search_fields = ('user_id', 'content_id', 'recommendation_type')

class SocialTrendingTopicAdmin(admin.ModelAdmin):
    list_display = ('trend_id', 'category_id', 'trend_name', 'created_at', 'updated_at')
    search_fields = ('category_id', 'trend_name')

class InfluencerCampaignAdmin(admin.ModelAdmin):
    list_display = ('campaign_id', 'influencer_id', 'campaign_details', 'created_at', 'updated_at')
    search_fields = ('influencer_id',)

class SocialCollaborationAdmin(admin.ModelAdmin):
    list_display = ('collaboration_id', 'partner_id', 'user_id', 'status', 'created_at', 'updated_at')
    search_fields = ('partner_id', 'user_id', 'status')

class CMSIntegrationAdmin(admin.ModelAdmin):
    list_display = ('integration_id', 'cms_id', 'configuration', 'status', 'created_at', 'updated_at')
    search_fields = ('cms_id', 'status')

admin.site.register(SocialShare, SocialShareAdmin)
admin.site.register(SocialAnalytics, SocialAnalyticsAdmin)
admin.site.register(SocialLike, SocialLikeAdmin)
admin.site.register(SocialComment, SocialCommentAdmin)
admin.site.register(SocialPrivacy, SocialPrivacyAdmin)
admin.site.register(UserSocialProfile, UserSocialProfileAdmin)
admin.site.register(SocialBadge, SocialBadgeAdmin)
admin.site.register(SocialReward, SocialRewardAdmin)
admin.site.register(SocialRecommendation, SocialRecommendationAdmin)
admin.site.register(SocialTrendingTopic, SocialTrendingTopicAdmin)
admin.site.register(InfluencerCampaign, InfluencerCampaignAdmin)
admin.site.register(SocialCollaboration, SocialCollaborationAdmin)
admin.site.register(CMSIntegration, CMSIntegrationAdmin)
