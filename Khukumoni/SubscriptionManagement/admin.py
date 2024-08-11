from django.contrib import admin
from .models import (
    Subscriptions, SubscriptionPlans, SubscriptionCancellationReasons,
    SubscriptionRenewalReminders, SubscriptionPaymentMethods,
    SubscriptionUsageTracking, SubscriptionAnalytics, SubscriptionDiscounts,
    SubscriptionCustomizationOptions
)

@admin.register(Subscriptions)
class SubscriptionsAdmin(admin.ModelAdmin):
    list_display = ('subscription_id', 'user_id', 'plan_id', 'start_date', 'end_date', 'status', 'billing_cycle', 'next_billing_date', 'created_at', 'updated_at')
    search_fields = ('user_id', 'plan_id', 'status', 'billing_cycle')
    list_filter = ('status', 'billing_cycle')

@admin.register(SubscriptionPlans)
class SubscriptionPlansAdmin(admin.ModelAdmin):
    list_display = ('plan_id', 'plan_name', 'description', 'price', 'currency', 'billing_cycle', 'created_at', 'updated_at')
    search_fields = ('plan_name', 'description', 'price', 'currency', 'billing_cycle')
    list_filter = ('currency', 'billing_cycle')

@admin.register(SubscriptionCancellationReasons)
class SubscriptionCancellationReasonsAdmin(admin.ModelAdmin):
    list_display = ('reason_id', 'reason_text', 'created_at', 'updated_at')
    search_fields = ('reason_text',)
    list_filter = ('created_at', 'updated_at')

@admin.register(SubscriptionRenewalReminders)
class SubscriptionRenewalRemindersAdmin(admin.ModelAdmin):
    list_display = ('reminder_id', 'user_id', 'reminder_date', 'reminder_status', 'created_at', 'updated_at')
    search_fields = ('user_id', 'reminder_status')
    list_filter = ('reminder_status', 'created_at', 'updated_at')

@admin.register(SubscriptionPaymentMethods)
class SubscriptionPaymentMethodsAdmin(admin.ModelAdmin):
    list_display = ('method_id', 'user_id', 'payment_method_type', 'payment_details', 'created_at', 'updated_at')
    search_fields = ('user_id', 'payment_method_type')
    list_filter = ('payment_method_type', 'created_at', 'updated_at')

@admin.register(SubscriptionUsageTracking)
class SubscriptionUsageTrackingAdmin(admin.ModelAdmin):
    list_display = ('usage_id', 'subscription_id', 'usage_details', 'usage_date', 'created_at', 'updated_at')
    search_fields = ('subscription_id',)
    list_filter = ('usage_date', 'created_at', 'updated_at')

@admin.register(SubscriptionAnalytics)
class SubscriptionAnalyticsAdmin(admin.ModelAdmin):
    list_display = ('analytics_id', 'subscription_id', 'metric_name', 'metric_value', 'metric_date', 'created_at', 'updated_at')
    search_fields = ('subscription_id', 'metric_name')
    list_filter = ('metric_name', 'metric_date', 'created_at', 'updated_at')

@admin.register(SubscriptionDiscounts)
class SubscriptionDiscountsAdmin(admin.ModelAdmin):
    list_display = ('discount_id', 'subscription_id', 'discount_code', 'discount_amount', 'created_at', 'updated_at')
    search_fields = ('subscription_id', 'discount_code')
    list_filter = ('created_at', 'updated_at')

@admin.register(SubscriptionCustomizationOptions)
class SubscriptionCustomizationOptionsAdmin(admin.ModelAdmin):
    list_display = ('option_id', 'subscription_id', 'option_name', 'option_value', 'created_at', 'updated_at')
    search_fields = ('subscription_id', 'option_name', 'option_value')
    list_filter = ('created_at', 'updated_at')
