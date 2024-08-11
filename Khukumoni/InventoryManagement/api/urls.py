from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import (
    InventoryLocationViewSet, InventoryViewSet, InventoryHistoryViewSet,
    StockAlertViewSet, StockTransferViewSet, BatchViewSet, ExpiryManagementViewSet,
    InventoryReportViewSet, InventoryAdjustmentReasonViewSet
)

router = DefaultRouter()
router.register(r'locations', InventoryLocationViewSet)
router.register(r'inventories', InventoryViewSet)
router.register(r'histories', InventoryHistoryViewSet)
router.register(r'alerts', StockAlertViewSet)
router.register(r'transfers', StockTransferViewSet)
router.register(r'batches', BatchViewSet)
router.register(r'expiries', ExpiryManagementViewSet)
router.register(r'reports', InventoryReportViewSet)
router.register(r'adjustment_reasons', InventoryAdjustmentReasonViewSet)

urlpatterns = [
    path('', include(router.urls)),
]
