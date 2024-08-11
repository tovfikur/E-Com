from django.contrib import admin
from .models import (
    Order, OrderItem, Shipment, Return, Refund, OrderCommunication,
    RecurringOrder, OrderBatch
)

class OrderAdmin(admin.ModelAdmin):
    list_display = ('id', 'customer', 'order_date', 'status', 'total_amount', 'payment_status', 'created_at', 'updated_at')
    search_fields = ('customer__first_name', 'customer__last_name', 'status', 'payment_status')
    list_filter = ('status', 'payment_status', 'order_date')

class OrderItemAdmin(admin.ModelAdmin):
    list_display = (Order, 'product', 'quantity', 'unit_price', 'total_price')
    search_fields = ('order__id', 'product__name')
    list_filter = ('order__order_date',)

class ShipmentAdmin(admin.ModelAdmin):
    list_display = (Order, 'shipping_method', 'tracking_number', 'shipping_date', 'delivery_date')
    search_fields = ('order__id', 'shipping_method', 'tracking_number')
    list_filter = ('shipping_date', 'delivery_date')

class ReturnAdmin(admin.ModelAdmin):
    list_display = (Order, 'return_reason', 'return_status', 'return_date')
    search_fields = ('order__id', 'return_status')
    list_filter = ('return_status', 'return_date')

class RefundAdmin(admin.ModelAdmin):
    list_display = (Order, 'refund_amount', 'refund_reason', 'refund_status', 'refund_date')
    search_fields = ('order__id', 'refund_status')
    list_filter = ('refund_status', 'refund_date')

class OrderCommunicationAdmin(admin.ModelAdmin):
    list_display = (Order, 'recipient_email', 'subject', 'sent_at')
    search_fields = ('order__id', 'recipient_email', 'subject')
    list_filter = ('sent_at',)

class RecurringOrderAdmin(admin.ModelAdmin):
    list_display = ('customer', 'start_date', 'end_date', 'frequency')
    search_fields = ('customer__first_name', 'customer__last_name', 'frequency')
    list_filter = ('start_date', 'end_date', 'frequency')

class OrderBatchAdmin(admin.ModelAdmin):
    list_display = ('batch_type', 'processed_at')
    search_fields = ('batch_type',)
    list_filter = ('processed_at',)

admin.site.register(Order, OrderAdmin)
admin.site.register(OrderItem, OrderItemAdmin)
admin.site.register(Shipment, ShipmentAdmin)
admin.site.register(Return, ReturnAdmin)
admin.site.register(Refund, RefundAdmin)
admin.site.register(OrderCommunication, OrderCommunicationAdmin)
admin.site.register(RecurringOrder, RecurringOrderAdmin)
admin.site.register(OrderBatch, OrderBatchAdmin)
