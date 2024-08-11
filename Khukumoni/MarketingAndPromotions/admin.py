from django.contrib import admin
from .models import (
    PromotionRules, PromotionCoupons, PromotionSegments, PromotionAnalytics,
    PromotionTargeting, PromotionABTesting, PromotionContent,
    PromotionPersonalization, PromotionCollaborationHistory,
    PromotionAutomation, PromotionIntegrations
)

@admin.register(PromotionRules)
class PromotionRulesAdmin(admin.ModelAdmin):
    list_display = ('rule_id', 'rule_name', 'rule_description', 'created_at', 'updated_at')
    search_fields = ('rule_name', 'rule_description')

@admin.register(PromotionCoupons)
class PromotionCouponsAdmin(admin.ModelAdmin):
    list_display = ('coupon_id', 'coupon_code', 'discount_type', 'discount_value', 'max_uses', 'uses_counter', 'expiration_date', 'created_at', 'updated_at')
    search_fields = ('coupon_code',)

@admin.register(PromotionSegments)
class PromotionSegmentsAdmin(admin.ModelAdmin):
    list_display = ('segment_id', 'segment_name', 'created_at', 'updated_at')
    search_fields = ('segment_name',)

@admin.register(PromotionAnalytics)
class PromotionAnalyticsAdmin(admin.ModelAdmin):
    list_display = ('analytics_id', 'promotion_id', 'sales', 'conversions', 'engagement', 'roi', 'analytics_date')
    search_fields = ('promotion_id',)

@admin.register(PromotionTargeting)
class PromotionTargetingAdmin(admin.ModelAdmin):
    list_display = ('targeting_id', 'promotion_id', 'target_type', 'created_at', 'updated_at')
    search_fields = ('promotion_id',)

@admin.register(PromotionABTesting)
class PromotionABTestingAdmin(admin.ModelAdmin):
    list_display = ('test_id', 'test_name', 'test_description', 'created_at', 'updated_at')
    search_fields = ('test_name',)

@admin.register(PromotionContent)
class PromotionContentAdmin(admin.ModelAdmin):
    list_display = ('content_id', 'promotion_id', 'content_type', 'created_at', 'updated_at')
    search_fields = ('promotion_id',)

@admin.register(PromotionPersonalization)
class PromotionPersonalizationAdmin(admin.ModelAdmin):
    list_display = ('personalization_id', 'promotion_id', 'created_at', 'updated_at')
    search_fields = ('promotion_id',)

@admin.register(PromotionCollaborationHistory)
class PromotionCollaborationHistoryAdmin(admin.ModelAdmin):
    list_display = ('collaboration_id', 'promotion_id', 'action', 'user_id', 'timestamp')
    search_fields = ('promotion_id',)

@admin.register(PromotionAutomation)
class PromotionAutomationAdmin(admin.ModelAdmin):
    list_display = ('automation_id', 'automation_name', 'automation_type', 'created_at', 'updated_at')
    search_fields = ('automation_name',)

@admin.register(PromotionIntegrations)
class PromotionIntegrationsAdmin(admin.ModelAdmin):
    list_display = ('integration_id', 'integration_name', 'enabled', 'created_at', 'updated_at')
    search_fields = ('integration_name',)

