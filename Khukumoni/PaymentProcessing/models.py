from django.db import models
from CustomerManagement.models import Customer

class Payments(models.Model):
    payment_id = models.AutoField(primary_key=True)
    order_id = models.ForeignKey('OrderManagement.Order', on_delete=models.CASCADE)
    customer_id = models.ForeignKey(Customer, on_delete=models.CASCADE)
    amount = models.DecimalField(max_digits=10, decimal_places=2)
    currency = models.CharField(max_length=255)
    status = models.CharField(max_length=255)
    payment_method_id = models.ForeignKey('PaymentMethods', on_delete=models.CASCADE)
    transaction_id = models.CharField(max_length=255)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
      return f"Payment ID: {self.payment_id}, Amount: {self.amount}, Status: {self.status}"


class PaymentMethods(models.Model):
    payment_method_id = models.AutoField(primary_key=True)
    customer_id = models.ForeignKey(Customer, on_delete=models.CASCADE)
    method_type = models.CharField(max_length=255)
    details = models.JSONField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
      return f"Payment Method ID: {self.payment_method_id}, Type: {self.method_type}"


class PaymentHistory(models.Model):
    history_id = models.AutoField(primary_key=True)
    payment_id = models.ForeignKey(Payments, on_delete=models.CASCADE)
    event_type = models.CharField(max_length=255)
    event_details = models.JSONField()
    event_date = models.DateTimeField()

    def __str__(self):
      return f"History ID: {self.history_id}, Payment ID: {self.payment_id}, Event Type: {self.event_type}"


class PaymentTokens(models.Model):
    token_id = models.AutoField(primary_key=True)
    customer_id = models.ForeignKey(Customer, on_delete=models.CASCADE)
    token_type = models.CharField(max_length=255)
    token_value = models.CharField(max_length=255)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
      return f"Token ID: {self.token_id}, Type: {self.token_type}"


class PaymentNotifications(models.Model):
    notification_id = models.AutoField(primary_key=True)
    transaction_id = models.CharField(max_length=255)
    notification_type = models.CharField(max_length=255)
    notification_details = models.JSONField()
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
      return f"Notification ID: {self.notification_id}, Transaction ID: {self.transaction_id}, Type: {self.notification_type}"


class PaymentGateways(models.Model):
    gateway_id = models.AutoField(primary_key=True)
    gateway_name = models.CharField(max_length=255)
    configuration = models.JSONField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
      return f"Gateway ID: {self.gateway_id}, Name: {self.gateway_name}"


class RecurringPayments(models.Model):
    subscription_id = models.AutoField(primary_key=True)
    customer_id = models.ForeignKey(Customer, on_delete=models.CASCADE)
    order_id = models.ForeignKey('OrderManagement.Order', on_delete=models.CASCADE)
    amount = models.DecimalField(max_digits=10, decimal_places=2)
    frequency = models.CharField(max_length=255)
    status = models.CharField(max_length=255)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
      return f"Subscription ID: {self.subscription_id}, Amount: {self.amount}, Status: {self.status}"


class Settlements(models.Model):
    settlement_id = models.AutoField(primary_key=True)
    gateway_id = models.ForeignKey(PaymentGateways, on_delete=models.CASCADE)
    amount = models.DecimalField(max_digits=10, decimal_places=2)
    currency = models.CharField(max_length=255)
    status = models.CharField(max_length=255)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
      return f"Settlement ID: {self.settlement_id}, Gateway ID: {self.gateway_id}, Amount: {self.amount}, Status: {self.status}"


class FraudDetection(models.Model):
    fraud_id = models.AutoField(primary_key=True)
    transaction_id = models.CharField(max_length=255)
    customer_id = models.ForeignKey(Customer, on_delete=models.CASCADE)
    fraud_score = models.IntegerField()
    fraud_alert = models.CharField(max_length=255)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
      return f"Fraud ID: {self.fraud_id}, Transaction ID: {self.transaction_id}, Score: {self.fraud_score}, Alert: {self.fraud_alert}"


class SecureAuthentication(models.Model):
    auth_id = models.AutoField(primary_key=True)
    transaction_id = models.CharField(max_length=255)
    customer_id = models.ForeignKey(Customer, on_delete=models.CASCADE)
    status = models.CharField(max_length=255)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    
    def __str__(self):
      return f"Auth ID: {self.auth_id}, Transaction ID: {self.transaction_id}, Status: {self.status}"


