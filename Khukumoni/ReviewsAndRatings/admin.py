from django.contrib import admin
from .models import (
    Review, ReviewReply, ReviewFilter, ReviewReport, ReviewNotification, 
    ReviewAnalytics, ReviewImportExport, ReviewResponseTemplate, ReviewAggregation, 
    ReviewIntegration, ReviewGamification, ReviewAuthentication
)

class ReviewAdmin(admin.ModelAdmin):
    list_display = ('review_id', 'product_id', 'user_id', 'rating', 'status', 'created_at', 'updated_at')
    search_fields = ('product_id', 'user_id', 'status')
    list_filter = ('status',)

class ReviewReplyAdmin(admin.ModelAdmin):
    list_display = ('reply_id', 'review_id', 'user_id', 'reply_text', 'created_at', 'updated_at')
    search_fields = ('review_id', 'user_id')

class ReviewFilterAdmin(admin.ModelAdmin):
    list_display = ('filter_id', 'criteria', 'sort_order', 'created_at')
    search_fields = ('criteria',)

class ReviewReportAdmin(admin.ModelAdmin):
    list_display = ('report_id', 'review_id', 'report_reason', 'status', 'created_at', 'updated_at')
    search_fields = ('review_id', 'status')
    list_filter = ('status',)

class ReviewNotificationAdmin(admin.ModelAdmin):
    list_display = ('notification_id', 'user_id', 'subscribed', 'created_at')
    search_fields = ('user_id',)

class ReviewAnalyticsAdmin(admin.ModelAdmin):
    list_display = ('analytics_id', 'review_id', 'views', 'engagement', 'sentiment', 'trend', 'updated_at')
    search_fields = ('review_id',)

class ReviewImportExportAdmin(admin.ModelAdmin):
    list_display = ('operation_id', 'operation_type', 'date_range', 'status', 'created_at', 'completed_at')
    search_fields = ('operation_type', 'status')

class ReviewResponseTemplateAdmin(admin.ModelAdmin):
    list_display = ('template_id', 'template_name', 'template_text', 'created_at', 'updated_at')
    search_fields = ('template_name',)

class ReviewAggregationAdmin(admin.ModelAdmin):
    list_display = ('aggregation_id', 'product_id', 'summary', 'sentiment', 'trends', 'updated_at')
    search_fields = ('product_id', 'sentiment')

class ReviewIntegrationAdmin(admin.ModelAdmin):
    list_display = ('integration_id', 'platform_name', 'details', 'status', 'created_at', 'updated_at')
    search_fields = ('platform_name', 'status')

class ReviewGamificationAdmin(admin.ModelAdmin):
    list_display = ('gamification_id', 'settings', 'leaderboard', 'rewards', 'created_at', 'updated_at')
    search_fields = ('settings',)

class ReviewAuthenticationAdmin(admin.ModelAdmin):
    list_display = ('auth_id', 'review_id', 'verification_token', 'status', 'created_at', 'verified_at')
    search_fields = ('review_id', 'status')

admin.site.register(Review, ReviewAdmin)
admin.site.register(ReviewReply, ReviewReplyAdmin)
admin.site.register(ReviewFilter, ReviewFilterAdmin)
admin.site.register(ReviewReport, ReviewReportAdmin)
admin.site.register(ReviewNotification, ReviewNotificationAdmin)
admin.site.register(ReviewAnalytics, ReviewAnalyticsAdmin)
admin.site.register(ReviewImportExport, ReviewImportExportAdmin)
admin.site.register(ReviewResponseTemplate, ReviewResponseTemplateAdmin)
admin.site.register(ReviewAggregation, ReviewAggregationAdmin)
admin.site.register(ReviewIntegration, ReviewIntegrationAdmin)
admin.site.register(ReviewGamification, ReviewGamificationAdmin)
admin.site.register(ReviewAuthentication, ReviewAuthenticationAdmin)
