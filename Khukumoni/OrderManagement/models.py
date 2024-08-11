from django.db import models
from CustomerManagement.models import Customer
from ProductManagement.models import Product

class Order(models.Model):
    customer = models.ForeignKey(Customer, on_delete=models.CASCADE)
    order_date = models.DateTimeField()
    status = models.CharField(max_length=255)
    total_amount = models.DecimalField(max_digits=10, decimal_places=2)
    payment_status = models.CharField(max_length=255)
    shipping_address = models.CharField(max_length=255)
    billing_address = models.CharField(max_length=255)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return f'Order {self.id} - {self.customer}'

class OrderItem(models.Model):
    order = models.ForeignKey(Order, on_delete=models.CASCADE)
    product = models.ForeignKey(Product, on_delete=models.CASCADE)
    quantity = models.IntegerField()
    unit_price = models.DecimalField(max_digits=10, decimal_places=2)
    total_price = models.DecimalField(max_digits=10, decimal_places=2)

    def __str__(self):
        return f'{self.product.name} (x{self.quantity})'

class Shipment(models.Model):
    order = models.ForeignKey(Order, on_delete=models.CASCADE)
    shipping_method = models.CharField(max_length=255)
    tracking_number = models.CharField(max_length=255)
    shipping_date = models.DateTimeField()
    delivery_date = models.DateTimeField()

    def __str__(self):
        return f'Shipment for Order {self.order.id}'

class Return(models.Model):
    order = models.ForeignKey(Order, on_delete=models.CASCADE)
    return_reason = models.TextField()
    return_status = models.CharField(max_length=255)
    return_date = models.DateTimeField()

    def __str__(self):
        return f'Return for Order {self.order.id}'

class Refund(models.Model):
    order = models.ForeignKey(Order, on_delete=models.CASCADE)
    refund_amount = models.DecimalField(max_digits=10, decimal_places=2)
    refund_reason = models.TextField()
    refund_status = models.CharField(max_length=255)
    refund_date = models.DateTimeField()

    def __str__(self):
        return f'Refund for Order {self.order.id}'

class OrderCommunication(models.Model):
    order = models.ForeignKey(Order, on_delete=models.CASCADE)
    recipient_email = models.CharField(max_length=255)
    subject = models.CharField(max_length=255)
    message_body = models.TextField()
    sent_at = models.DateTimeField()

    def __str__(self):
        return f'Communication for Order {self.order.id}'

class RecurringOrder(models.Model):
    customer = models.ForeignKey(Customer, on_delete=models.CASCADE)
    start_date = models.DateTimeField()
    end_date = models.DateTimeField()
    frequency = models.CharField(max_length=255)

    def __str__(self):
        return f'Recurring Order for {self.customer}'

class OrderBatch(models.Model):
    batch_type = models.CharField(max_length=255)
    batch_data = models.JSONField()
    processed_at = models.DateTimeField()

    def __str__(self):
        return f'Order Batch {self.id} - {self.batch_type}'
