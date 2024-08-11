from rest_framework import viewsets
from ..models import (
    Order, OrderItem, Shipment, Return, Refund, OrderCommunication,
    RecurringOrder, OrderBatch
)
from .serializers import (
    OrderSerializer, OrderItemSerializer, ShipmentSerializer, ReturnSerializer,
    RefundSerializer, OrderCommunicationSerializer, RecurringOrderSerializer,
    OrderBatchSerializer
)

class OrderViewSet(viewsets.ModelViewSet):
    queryset = Order.objects.all()
    serializer_class = OrderSerializer

class OrderItemViewSet(viewsets.ModelViewSet):
    queryset = OrderItem.objects.all()
    serializer_class = OrderItemSerializer

class ShipmentViewSet(viewsets.ModelViewSet):
    queryset = Shipment.objects.all()
    serializer_class = ShipmentSerializer

class ReturnViewSet(viewsets.ModelViewSet):
    queryset = Return.objects.all()
    serializer_class = ReturnSerializer

class RefundViewSet(viewsets.ModelViewSet):
    queryset = Refund.objects.all()
    serializer_class = RefundSerializer

class OrderCommunicationViewSet(viewsets.ModelViewSet):
    queryset = OrderCommunication.objects.all()
    serializer_class = OrderCommunicationSerializer

class RecurringOrderViewSet(viewsets.ModelViewSet):
    queryset = RecurringOrder.objects.all()
    serializer_class = RecurringOrderSerializer

class OrderBatchViewSet(viewsets.ModelViewSet):
    queryset = OrderBatch.objects.all()
    serializer_class = OrderBatchSerializer
