from django.contrib import admin
from .models import LoyaltyEnrollment, LoyaltyPointsHistory, LoyaltyRedemptionHistory, LoyaltyTier, LoyaltyMembershipStatus, LoyaltyEarningOpportunity, LoyaltyCustomization, LoyaltyPromotion, LoyaltyPointsTransfer, LoyaltyAnalytics, LoyaltyReferral, LoyaltyNotification

class LoyaltyEnrollmentAdmin(admin.ModelAdmin):
    list_display = ('enrollment_id', 'customer_id', 'enrollment_date', 'status', 'created_at', 'updated_at')
    search_fields = ('customer_id', 'status')

class LoyaltyPointsHistoryAdmin(admin.ModelAdmin):
    list_display = ('history_id', 'customer_id', 'points', 'activity_type', 'created_at', 'updated_at')
    search_fields = ('customer_id', 'activity_type')

class LoyaltyRedemptionHistoryAdmin(admin.ModelAdmin):
    list_display = ('redemption_id', 'customer_id', 'points_redeemed', 'redemption_date', 'item_redeemed', 'created_at', 'updated_at')
    search_fields = ('customer_id', 'item_redeemed')

class LoyaltyTierAdmin(admin.ModelAdmin):
    list_display = ('tier_id', 'tier_name', 'created_at', 'updated_at')
    search_fields = ('tier_name',)

class LoyaltyMembershipStatusAdmin(admin.ModelAdmin):
    list_display = ('status_id', 'customer_id', 'current_tier', 'status', 'points_balance', 'created_at', 'updated_at')
    search_fields = ('customer_id', 'status')

class LoyaltyEarningOpportunityAdmin(admin.ModelAdmin):
    list_display = ('opportunity_id', 'customer_id', 'activity_id', 'points', 'created_at', 'updated_at')
    search_fields = ('customer_id', 'activity_id')

class LoyaltyCustomizationAdmin(admin.ModelAdmin):
    list_display = ('customization_id', 'created_at', 'updated_at')
    search_fields = ('customization_id',)

class LoyaltyPromotionAdmin(admin.ModelAdmin):
    list_display = ('promotion_id', 'start_date', 'end_date', 'created_at', 'updated_at')
    search_fields = ('promotion_id',)

class LoyaltyPointsTransferAdmin(admin.ModelAdmin):
    list_display = ('transfer_id', 'from_customer_id', 'to_customer_id', 'points', 'transfer_date', 'status', 'created_at', 'updated_at')
    search_fields = ('from_customer_id', 'to_customer_id', 'status')

class LoyaltyAnalyticsAdmin(admin.ModelAdmin):
    list_display = ('analytics_id', 'metric', 'value', 'period', 'created_at', 'updated_at')
    search_fields = ('metric', 'period')

class LoyaltyReferralAdmin(admin.ModelAdmin):
    list_display = ('referral_id', 'referrer_id', 'referred_id', 'referral_date', 'points_awarded', 'status', 'created_at', 'updated_at')
    search_fields = ('referrer_id', 'referred_id', 'status')

class LoyaltyNotificationAdmin(admin.ModelAdmin):
    list_display = ('notification_id', 'customer_id', 'notification_type', 'status', 'created_at', 'updated_at')
    search_fields = ('customer_id', 'notification_type', 'status')

admin.site.register(LoyaltyEnrollment, LoyaltyEnrollmentAdmin)
admin.site.register(LoyaltyPointsHistory, LoyaltyPointsHistoryAdmin)
admin.site.register(LoyaltyRedemptionHistory, LoyaltyRedemptionHistoryAdmin)
admin.site.register(LoyaltyTier, LoyaltyTierAdmin)
admin.site.register(LoyaltyMembershipStatus, LoyaltyMembershipStatusAdmin)
admin.site.register(LoyaltyEarningOpportunity, LoyaltyEarningOpportunityAdmin)
admin.site.register(LoyaltyCustomization, LoyaltyCustomizationAdmin)
admin.site.register(LoyaltyPromotion, LoyaltyPromotionAdmin)
admin.site.register(LoyaltyPointsTransfer, LoyaltyPointsTransferAdmin)
admin.site.register(LoyaltyAnalytics, LoyaltyAnalyticsAdmin)
admin.site.register(LoyaltyReferral, LoyaltyReferralAdmin)
admin.site.register(LoyaltyNotification, LoyaltyNotificationAdmin)
