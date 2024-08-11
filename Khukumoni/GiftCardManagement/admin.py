from django.contrib import admin
from .models import (
    GiftCards, GiftCardTransactions, GiftCardNotifications,
    POSIntegrationConfiguration, GiftCardRedemptionOptions,
    GiftCardCustomizationOptions
)

@admin.register(GiftCards)
class GiftCardsAdmin(admin.ModelAdmin):
    list_display = ('gift_card_id', 'recipient_id', 'card_code', 'balance', 'activation_date', 'expiration_date', 'status', 'created_at', 'updated_at')
    search_fields = ('recipient_id', 'card_code', 'status')
    list_filter = ('status', 'activation_date', 'expiration_date')

@admin.register(GiftCardTransactions)
class GiftCardTransactionsAdmin(admin.ModelAdmin):
    list_display = ('transaction_id', 'gift_card_id', 'transaction_type', 'amount', 'transaction_date', 'created_at', 'updated_at')
    search_fields = ('gift_card_id', 'transaction_type')
    list_filter = ('transaction_type', 'transaction_date')

@admin.register(GiftCardNotifications)
class GiftCardNotificationsAdmin(admin.ModelAdmin):
    list_display = ('notification_id', 'user_id', 'gift_card_id', 'subscription_status', 'created_at', 'updated_at')
    search_fields = ('user_id', 'gift_card_id', 'subscription_status')
    list_filter = ('subscription_status', 'created_at', 'updated_at')

@admin.register(POSIntegrationConfiguration)
class POSIntegrationConfigurationAdmin(admin.ModelAdmin):
    list_display = ('pos_id', 'pos_name', 'created_at', 'updated_at')
    search_fields = ('pos_name',)
    list_filter = ('created_at', 'updated_at')

@admin.register(GiftCardRedemptionOptions)
class GiftCardRedemptionOptionsAdmin(admin.ModelAdmin):
    list_display = ('redemption_id', 'gift_card_id', 'redemption_option', 'created_at', 'updated_at')
    search_fields = ('gift_card_id', 'redemption_option')
    list_filter = ('created_at', 'updated_at')

@admin.register(GiftCardCustomizationOptions)
class GiftCardCustomizationOptionsAdmin(admin.ModelAdmin):
    list_display = ('customization_id', 'gift_card_id', 'customization_option', 'customization_value', 'created_at', 'updated_at')
    search_fields = ('gift_card_id', 'customization_option', 'customization_value')
    list_filter = ('created_at', 'updated_at')
