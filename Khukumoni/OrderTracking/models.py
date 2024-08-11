from django.db import models

class OrderTracking(models.Model):
    order_id = models.IntegerField(primary_key=True)
    current_status = models.CharField(max_length=255)
    estimated_delivery_date = models.DateTimeField()
    real_time_tracking_url = models.CharField(max_length=255)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class TrackingUpdates(models.Model):
    update_id = models.AutoField(primary_key=True)
    order_id = models.ForeignKey(OrderTracking, on_delete=models.CASCADE)
    status_update = models.CharField(max_length=255)
    timestamp = models.DateTimeField()
    location = models.CharField(max_length=255)
    additional_info = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class DeliveryRoutes(models.Model):
    route_id = models.AutoField(primary_key=True)
    order_id = models.ForeignKey(OrderTracking, on_delete=models.CASCADE)
    route_details = models.JSONField()
    map_url = models.CharField(max_length=255)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class ProofOfDelivery(models.Model):
    pod_id = models.AutoField(primary_key=True)
    order_id = models.ForeignKey(OrderTracking, on_delete=models.CASCADE)
    pod_details = models.TextField()
    pod_file_url = models.CharField(max_length=255)
    uploaded_at = models.DateTimeField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class DeliveryNotifications(models.Model):
    notification_id = models.AutoField(primary_key=True)
    order_id = models.ForeignKey(OrderTracking, on_delete=models.CASCADE)
    notification_type = models.CharField(max_length=255)
    sent_at = models.DateTimeField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class DeliveryIssues(models.Model):
    issue_id = models.AutoField(primary_key=True)
    order_id = models.ForeignKey(OrderTracking, on_delete=models.CASCADE)
    issue_description = models.TextField()
    reported_at = models.DateTimeField()
    status = models.CharField(max_length=50)
    resolution_details = models.TextField(null=True, blank=True)
    resolved_at = models.DateTimeField(null=True, blank=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class CarrierIntegration(models.Model):
    carrier_id = models.AutoField(primary_key=True)
    carrier_name = models.CharField(max_length=255)
    tracking_url = models.CharField(max_length=255)
    additional_details = models.JSONField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class DeliveryHistory(models.Model):
    history_id = models.AutoField(primary_key=True)
    order_id = models.ForeignKey(OrderTracking, on_delete=models.CASCADE)
    event_details = models.TextField()
    event_timestamp = models.DateTimeField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class DeliverySignatures(models.Model):
    signature_id = models.AutoField(primary_key=True)
    order_id = models.ForeignKey(OrderTracking, on_delete=models.CASCADE)
    signature_url = models.CharField(max_length=255)
    uploaded_at = models.DateTimeField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
