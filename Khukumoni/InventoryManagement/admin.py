from django.contrib import admin
from .models import (
    InventoryLocation, Inventory, InventoryHistory, StockAlert, StockTransfer,
    Batch, ExpiryManagement, InventoryReport, InventoryAdjustmentReason
)

admin.site.register(InventoryLocation)
admin.site.register(Inventory)
admin.site.register(InventoryHistory)
admin.site.register(StockAlert)
admin.site.register(StockTransfer)
admin.site.register(Batch)
admin.site.register(ExpiryManagement)
admin.site.register(InventoryReport)
admin.site.register(InventoryAdjustmentReason)
