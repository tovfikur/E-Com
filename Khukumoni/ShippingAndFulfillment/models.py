from django.db import models
from CustomerManagement.models import Customer
from OrderManagement.models import Order


class ShippingAddress(models.Model):
    address_id = models.AutoField(primary_key=True)
    recipient_name = models.CharField(max_length=255)
    street_address = models.CharField(max_length=255)
    city = models.CharField(max_length=255)
    state = models.CharField(max_length=255)
    postal_code = models.CharField(max_length=20)
    country = models.CharField(max_length=255)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class ShippingLabel(models.Model):
    label_id = models.AutoField(primary_key=True)
    order_id = models.ForeignKey(Order, on_delete=models.CASCADE)
    label_type = models.CharField(max_length=255)
    label_url = models.CharField(max_length=255)
    customization_settings = models.JSONField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class PackageTracking(models.Model):
    tracking_id = models.AutoField(primary_key=True)
    order_id = models.ForeignKey(Order, on_delete=models.CASCADE)
    tracking_number = models.CharField(max_length=255)
    carrier_id = models.ForeignKey('ShippingCarrier', on_delete=models.CASCADE)
    status = models.CharField(max_length=255)
    tracking_updates = models.JSONField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class ShippingCarrier(models.Model):
    carrier_id = models.AutoField(primary_key=True)
    carrier_name = models.CharField(max_length=255)
    carrier_details = models.JSONField()
    settings = models.JSONField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class ShippingInsurance(models.Model):
    insurance_id = models.AutoField(primary_key=True)
    order_id = models.ForeignKey(Order, on_delete=models.CASCADE)
    coverage_amount = models.DecimalField(max_digits=10, decimal_places=2)
    claim_status = models.CharField(max_length=255)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class ShippingZone(models.Model):
    zone_id = models.AutoField(primary_key=True)
    name = models.CharField(max_length=255)
    description = models.CharField(max_length=255)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class ShippingPreference(models.Model):
    preference_id = models.AutoField(primary_key=True)
    preference_name = models.CharField(max_length=255)
    preference_value = models.JSONField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class ShippingNotification(models.Model):
    notification_id = models.AutoField(primary_key=True)
    order_id = models.ForeignKey(Order, on_delete=models.CASCADE)
    enabled = models.BooleanField(default=True)
    email = models.EmailField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class DeliverySchedule(models.Model):
    schedule_id = models.AutoField(primary_key=True)
    order_id = models.ForeignKey(Order, on_delete=models.CASCADE)
    delivery_date = models.DateField()
    delivery_time = models.TimeField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class Location(models.Model):
    location_id = models.AutoField(primary_key=True)
    name = models.CharField(max_length=255)
    address_id = models.ForeignKey('ShippingAddress', on_delete=models.CASCADE)
    location_type = models.CharField(max_length=255)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class ShippingCost(models.Model):
    cost_id = models.AutoField(primary_key=True)
    order_id = models.ForeignKey(Order, on_delete=models.CASCADE)
    cost = models.DecimalField(max_digits=10, decimal_places=2)
    estimation_method = models.CharField(max_length=255)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class ShippingRestriction(models.Model):
    restriction_id = models.AutoField(primary_key=True)
    description = models.CharField(max_length=255)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class OrderRestriction(models.Model):
    order_id = models.ForeignKey(Order, on_delete=models.CASCADE)
    restriction_id = models.ForeignKey('ShippingRestriction', on_delete=models.CASCADE)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

