# Generated by Django 5.0.6 on 2024-06-30 10:10

import django.db.models.deletion
from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        ('CustomerManagement', '0001_initial'),
        ('ProductManagement', '0001_initial'),
    ]

    operations = [
        migrations.CreateModel(
            name='OrderBatch',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('batch_type', models.CharField(max_length=255)),
                ('batch_data', models.JSONField()),
                ('processed_at', models.DateTimeField()),
            ],
        ),
        migrations.CreateModel(
            name='Order',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('order_date', models.DateTimeField()),
                ('status', models.CharField(max_length=255)),
                ('total_amount', models.DecimalField(decimal_places=2, max_digits=10)),
                ('payment_status', models.CharField(max_length=255)),
                ('shipping_address', models.CharField(max_length=255)),
                ('billing_address', models.CharField(max_length=255)),
                ('created_at', models.DateTimeField(auto_now_add=True)),
                ('updated_at', models.DateTimeField(auto_now=True)),
                ('customer', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='CustomerManagement.customer')),
            ],
        ),
        migrations.CreateModel(
            name='OrderCommunication',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('recipient_email', models.CharField(max_length=255)),
                ('subject', models.CharField(max_length=255)),
                ('message_body', models.TextField()),
                ('sent_at', models.DateTimeField()),
                ('order', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='OrderManagement.order')),
            ],
        ),
        migrations.CreateModel(
            name='OrderItem',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('quantity', models.IntegerField()),
                ('unit_price', models.DecimalField(decimal_places=2, max_digits=10)),
                ('total_price', models.DecimalField(decimal_places=2, max_digits=10)),
                ('order', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='OrderManagement.order')),
                ('product', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='ProductManagement.product')),
            ],
        ),
        migrations.CreateModel(
            name='RecurringOrder',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('start_date', models.DateTimeField()),
                ('end_date', models.DateTimeField()),
                ('frequency', models.CharField(max_length=255)),
                ('customer', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='CustomerManagement.customer')),
            ],
        ),
        migrations.CreateModel(
            name='Refund',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('refund_amount', models.DecimalField(decimal_places=2, max_digits=10)),
                ('refund_reason', models.TextField()),
                ('refund_status', models.CharField(max_length=255)),
                ('refund_date', models.DateTimeField()),
                ('order', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='OrderManagement.order')),
            ],
        ),
        migrations.CreateModel(
            name='Return',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('return_reason', models.TextField()),
                ('return_status', models.CharField(max_length=255)),
                ('return_date', models.DateTimeField()),
                ('order', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='OrderManagement.order')),
            ],
        ),
        migrations.CreateModel(
            name='Shipment',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('shipping_method', models.CharField(max_length=255)),
                ('tracking_number', models.CharField(max_length=255)),
                ('shipping_date', models.DateTimeField()),
                ('delivery_date', models.DateTimeField()),
                ('order', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='OrderManagement.order')),
            ],
        ),
    ]
