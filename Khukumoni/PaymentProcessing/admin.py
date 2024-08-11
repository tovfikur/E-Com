from django.contrib import admin
from .models import (
    Payments, PaymentMethods, PaymentHistory, PaymentTokens,
    PaymentNotifications, PaymentGateways, RecurringPayments,
    Settlements, FraudDetection, SecureAuthentication
)


# Customize admin display for each model
class PaymentAdmin(admin.ModelAdmin):
    list_display = ('payment_id', 'order_id', 'customer_id', 'amount', 'status', 'created_at', 'updated_at')
    list_filter = ('status', 'created_at')
    search_fields = ('order_id__id', 'customer_id__first_name', 'customer_id__last_name', 'transaction_id')

class PaymentMethodsAdmin(admin.ModelAdmin):
    list_display = ('payment_method_id', 'customer_id', 'method_type', 'created_at', 'updated_at')
    list_filter = ('method_type', 'created_at')
    search_fields = ('customer_id__first_name', 'customer_id__last_name', 'method_type')

class PaymentHistoryAdmin(admin.ModelAdmin):
    list_display = ('history_id', 'payment_id', 'event_type', 'event_date')
    list_filter = ('event_type', 'event_date')
    search_fields = ('payment_id__payment_id',)

class PaymentTokensAdmin(admin.ModelAdmin):
    list_display = ('token_id', 'customer_id', 'token_type', 'created_at', 'updated_at')
    list_filter = ('token_type', 'created_at')
    search_fields = ('customer_id__first_name', 'customer_id__last_name', 'token_type')

class PaymentNotificationsAdmin(admin.ModelAdmin):
    list_display = ('notification_id', 'transaction_id', 'notification_type', 'created_at')
    list_filter = ('notification_type', 'created_at')
    search_fields = ('transaction_id',)

class PaymentGatewaysAdmin(admin.ModelAdmin):
    list_display = ('gateway_id', 'gateway_name', 'created_at', 'updated_at')
    search_fields = ('gateway_name',)

class RecurringPaymentsAdmin(admin.ModelAdmin):
    list_display = ('subscription_id', 'customer_id', 'order_id', 'amount', 'status', 'created_at', 'updated_at')
    list_filter = ('status', 'created_at')
    search_fields = ('customer_id__first_name', 'customer_id__last_name')

class SettlementsAdmin(admin.ModelAdmin):
    list_display = ('settlement_id', 'gateway_id', 'amount', 'status', 'created_at', 'updated_at')
    list_filter = ('status', 'created_at')
    search_fields = ('gateway_id__gateway_name',)

class FraudDetectionAdmin(admin.ModelAdmin):
    list_display = ('fraud_id', 'transaction_id', 'customer_id', 'fraud_score', 'fraud_alert', 'created_at', 'updated_at')
    list_filter = ('fraud_score', 'fraud_alert', 'created_at')
    search_fields = ('customer_id__first_name', 'customer_id__last_name', 'transaction_id')

class SecureAuthenticationAdmin(admin.ModelAdmin):
    list_display = ('auth_id', 'transaction_id', 'customer_id', 'status', 'created_at', 'updated_at')
    list_filter = ('status', 'created_at')
    search_fields = ('customer_id__first_name', 'customer_id__last_name', 'transaction_id')

# Register models with custom admin displays
admin.site.register(Payments, PaymentAdmin)
admin.site.register(PaymentMethods, PaymentMethodsAdmin)
admin.site.register(PaymentHistory, PaymentHistoryAdmin)
admin.site.register(PaymentTokens, PaymentTokensAdmin)
admin.site.register(PaymentNotifications, PaymentNotificationsAdmin)
admin.site.register(PaymentGateways, PaymentGatewaysAdmin)
admin.site.register(RecurringPayments, RecurringPaymentsAdmin)
admin.site.register(Settlements, SettlementsAdmin)
admin.site.register(FraudDetection, FraudDetectionAdmin)
admin.site.register(SecureAuthentication, SecureAuthenticationAdmin)
