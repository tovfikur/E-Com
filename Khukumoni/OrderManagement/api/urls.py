from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import (
    OrderViewSet, OrderItemViewSet, ShipmentViewSet, ReturnViewSet, RefundViewSet,
    OrderCommunicationViewSet, RecurringOrderViewSet, OrderBatchViewSet
)

router = DefaultRouter()
router.register(r'orders', OrderViewSet)
router.register(r'order_items', OrderItemViewSet)
router.register(r'shipments', ShipmentViewSet)
router.register(r'returns', ReturnViewSet)
router.register(r'refunds', RefundViewSet)
router.register(r'order_communications', OrderCommunicationViewSet)
router.register(r'recurring_orders', RecurringOrderViewSet)
router.register(r'order_batches', OrderBatchViewSet)

urlpatterns = [
    path('', include(router.urls)),
]
