from django.db import models
from ProductManagement.models import Product

class InventoryLocation(models.Model):
    name = models.CharField(max_length=255)
    description = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class Inventory(models.Model):
    product = models.ForeignKey(Product, on_delete=models.CASCADE, related_name='inventory_items')
    location = models.ForeignKey(InventoryLocation, on_delete=models.CASCADE)
    quantity = models.IntegerField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class InventoryHistory(models.Model):
    product = models.ForeignKey(Product, on_delete=models.CASCADE, related_name='history_items')
    inventory = models.ForeignKey(Inventory, on_delete=models.CASCADE)
    action = models.CharField(max_length=255)
    quantity_changed = models.IntegerField()
    actor = models.CharField(max_length=255)
    timestamp = models.DateTimeField()

class StockAlert(models.Model):
    product = models.ForeignKey(Product, on_delete=models.CASCADE, related_name='stock_alerts')
    threshold_quantity = models.IntegerField()
    action_required = models.CharField(max_length=255)
    created_at = models.DateTimeField(auto_now_add=True)

class StockTransfer(models.Model):
    from_location = models.ForeignKey(InventoryLocation, on_delete=models.CASCADE, related_name='from_location')
    to_location = models.ForeignKey(InventoryLocation, on_delete=models.CASCADE, related_name='to_location')
    product = models.ForeignKey(Product, on_delete=models.CASCADE, related_name='stock_transfer')
    quantity_transferred = models.IntegerField()
    status = models.CharField(max_length=255)
    initiated_by = models.CharField(max_length=255)
    timestamp = models.DateTimeField()

class Batch(models.Model):
    product = models.ForeignKey(Product, on_delete=models.CASCADE, related_name='batches')
    batch_number = models.CharField(max_length=255)
    expiry_date = models.DateTimeField()
    quantity = models.IntegerField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class ExpiryManagement(models.Model):
    product = models.ForeignKey(Product, on_delete=models.CASCADE, related_name='expiry_managements')
    batch = models.ForeignKey(Batch, on_delete=models.CASCADE)
    expiry_date = models.DateTimeField()
    quantity = models.IntegerField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class InventoryReport(models.Model):
    report_type = models.CharField(max_length=255)
    report_data = models.JSONField()
    generated_at = models.DateTimeField()

class InventoryAdjustmentReason(models.Model):
    reason = models.CharField(max_length=255)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
