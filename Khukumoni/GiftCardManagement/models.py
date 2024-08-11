from django.db import models

class GiftCards(models.Model):
    gift_card_id = models.AutoField(primary_key=True)
    recipient_id = models.IntegerField()
    card_code = models.CharField(max_length=50)
    balance = models.DecimalField(max_digits=10, decimal_places=2)
    activation_date = models.DateTimeField()
    expiration_date = models.DateTimeField()
    status = models.CharField(max_length=50)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class GiftCardTransactions(models.Model):
    transaction_id = models.AutoField(primary_key=True)
    gift_card_id = models.IntegerField()
    transaction_type = models.CharField(max_length=50)
    amount = models.DecimalField(max_digits=10, decimal_places=2)
    transaction_date = models.DateTimeField()
    transaction_details = models.JSONField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class GiftCardNotifications(models.Model):
    notification_id = models.AutoField(primary_key=True)
    user_id = models.IntegerField()
    gift_card_id = models.IntegerField()
    subscription_status = models.CharField(max_length=50)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class POSIntegrationConfiguration(models.Model):
    pos_id = models.AutoField(primary_key=True)
    pos_name = models.CharField(max_length=255)
    configuration_details = models.JSONField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class GiftCardRedemptionOptions(models.Model):
    redemption_id = models.AutoField(primary_key=True)
    gift_card_id = models.IntegerField()
    redemption_option = models.CharField(max_length=255)
    redemption_details = models.JSONField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class GiftCardCustomizationOptions(models.Model):
    customization_id = models.AutoField(primary_key=True)
    gift_card_id = models.IntegerField()
    customization_option = models.CharField(max_length=255)
    customization_value = models.CharField(max_length=255)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
