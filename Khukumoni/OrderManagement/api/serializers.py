from rest_framework import serializers
from ..models import (
    Order, OrderItem, Shipment, Return, Refund, OrderCommunication,
    RecurringOrder, OrderBatch
)

class OrderSerializer(serializers.ModelSerializer):
    class Meta:
        model = Order
        fields = '__all__'

class OrderItemSerializer(serializers.ModelSerializer):
    class Meta:
        model = OrderItem
        fields = '__all__'

class ShipmentSerializer(serializers.ModelSerializer):
    class Meta:
        model = Shipment
        fields = '__all__'

class ReturnSerializer(serializers.ModelSerializer):
    class Meta:
        model = Return
        fields = '__all__'

class RefundSerializer(serializers.ModelSerializer):
    class Meta:
        model = Refund
        fields = '__all__'

class OrderCommunicationSerializer(serializers.ModelSerializer):
    class Meta:
        model = OrderCommunication
        fields = '__all__'

class RecurringOrderSerializer(serializers.ModelSerializer):
    class Meta:
        model = RecurringOrder
        fields = '__all__'

class OrderBatchSerializer(serializers.ModelSerializer):
    class Meta:
        model = OrderBatch
        fields = '__all__'
