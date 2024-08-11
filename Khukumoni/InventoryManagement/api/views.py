from rest_framework import viewsets
from ..models import (
    InventoryLocation, Inventory, InventoryHistory, StockAlert, StockTransfer,
    Batch, ExpiryManagement, InventoryReport, InventoryAdjustmentReason
)
from .serializers import (
    InventoryLocationSerializer, InventorySerializer, InventoryHistorySerializer,
    StockAlertSerializer, StockTransferSerializer, BatchSerializer, ExpiryManagementSerializer,
    InventoryReportSerializer, InventoryAdjustmentReasonSerializer
)

class InventoryLocationViewSet(viewsets.ModelViewSet):
    queryset = InventoryLocation.objects.all()
    serializer_class = InventoryLocationSerializer

class InventoryViewSet(viewsets.ModelViewSet):
    queryset = Inventory.objects.all()
    serializer_class = InventorySerializer

class InventoryHistoryViewSet(viewsets.ModelViewSet):
    queryset = InventoryHistory.objects.all()
    serializer_class = InventoryHistorySerializer

class StockAlertViewSet(viewsets.ModelViewSet):
    queryset = StockAlert.objects.all()
    serializer_class = StockAlertSerializer

class StockTransferViewSet(viewsets.ModelViewSet):
    queryset = StockTransfer.objects.all()
    serializer_class = StockTransferSerializer

class BatchViewSet(viewsets.ModelViewSet):
    queryset = Batch.objects.all()
    serializer_class = BatchSerializer

class ExpiryManagementViewSet(viewsets.ModelViewSet):
    queryset = ExpiryManagement.objects.all()
    serializer_class = ExpiryManagementSerializer

class InventoryReportViewSet(viewsets.ModelViewSet):
    queryset = InventoryReport.objects.all()
    serializer_class = InventoryReportSerializer

class InventoryAdjustmentReasonViewSet(viewsets.ModelViewSet):
    queryset = InventoryAdjustmentReason.objects.all()
    serializer_class = InventoryAdjustmentReasonSerializer
