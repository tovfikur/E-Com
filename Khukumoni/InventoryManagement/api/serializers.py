from rest_framework import serializers
from ..models import (
    InventoryLocation, Inventory, InventoryHistory, StockAlert, StockTransfer,
    Batch, ExpiryManagement, InventoryReport, InventoryAdjustmentReason
)

class InventoryLocationSerializer(serializers.ModelSerializer):
    class Meta:
        model = InventoryLocation
        fields = '__all__'

class InventorySerializer(serializers.ModelSerializer):
    class Meta:
        model = Inventory
        fields = '__all__'

class InventoryHistorySerializer(serializers.ModelSerializer):
    class Meta:
        model = InventoryHistory
        fields = '__all__'

class StockAlertSerializer(serializers.ModelSerializer):
    class Meta:
        model = StockAlert
        fields = '__all__'

class StockTransferSerializer(serializers.ModelSerializer):
    class Meta:
        model = StockTransfer
        fields = '__all__'

class BatchSerializer(serializers.ModelSerializer):
    class Meta:
        model = Batch
        fields = '__all__'

class ExpiryManagementSerializer(serializers.ModelSerializer):
    class Meta:
        model = ExpiryManagement
        fields = '__all__'

class InventoryReportSerializer(serializers.ModelSerializer):
    class Meta:
        model = InventoryReport
        fields = '__all__'

class InventoryAdjustmentReasonSerializer(serializers.ModelSerializer):
    class Meta:
        model = InventoryAdjustmentReason
        fields = '__all__'
