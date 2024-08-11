# Generated by Django 5.0.6 on 2024-06-30 10:10

from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='GiftCardCustomizationOptions',
            fields=[
                ('customization_id', models.AutoField(primary_key=True, serialize=False)),
                ('gift_card_id', models.IntegerField()),
                ('customization_option', models.CharField(max_length=255)),
                ('customization_value', models.CharField(max_length=255)),
                ('created_at', models.DateTimeField(auto_now_add=True)),
                ('updated_at', models.DateTimeField(auto_now=True)),
            ],
        ),
        migrations.CreateModel(
            name='GiftCardNotifications',
            fields=[
                ('notification_id', models.AutoField(primary_key=True, serialize=False)),
                ('user_id', models.IntegerField()),
                ('gift_card_id', models.IntegerField()),
                ('subscription_status', models.CharField(max_length=50)),
                ('created_at', models.DateTimeField(auto_now_add=True)),
                ('updated_at', models.DateTimeField(auto_now=True)),
            ],
        ),
        migrations.CreateModel(
            name='GiftCardRedemptionOptions',
            fields=[
                ('redemption_id', models.AutoField(primary_key=True, serialize=False)),
                ('gift_card_id', models.IntegerField()),
                ('redemption_option', models.CharField(max_length=255)),
                ('redemption_details', models.JSONField()),
                ('created_at', models.DateTimeField(auto_now_add=True)),
                ('updated_at', models.DateTimeField(auto_now=True)),
            ],
        ),
        migrations.CreateModel(
            name='GiftCards',
            fields=[
                ('gift_card_id', models.AutoField(primary_key=True, serialize=False)),
                ('recipient_id', models.IntegerField()),
                ('card_code', models.CharField(max_length=50)),
                ('balance', models.DecimalField(decimal_places=2, max_digits=10)),
                ('activation_date', models.DateTimeField()),
                ('expiration_date', models.DateTimeField()),
                ('status', models.CharField(max_length=50)),
                ('created_at', models.DateTimeField(auto_now_add=True)),
                ('updated_at', models.DateTimeField(auto_now=True)),
            ],
        ),
        migrations.CreateModel(
            name='GiftCardTransactions',
            fields=[
                ('transaction_id', models.AutoField(primary_key=True, serialize=False)),
                ('gift_card_id', models.IntegerField()),
                ('transaction_type', models.CharField(max_length=50)),
                ('amount', models.DecimalField(decimal_places=2, max_digits=10)),
                ('transaction_date', models.DateTimeField()),
                ('transaction_details', models.JSONField()),
                ('created_at', models.DateTimeField(auto_now_add=True)),
                ('updated_at', models.DateTimeField(auto_now=True)),
            ],
        ),
        migrations.CreateModel(
            name='POSIntegrationConfiguration',
            fields=[
                ('pos_id', models.AutoField(primary_key=True, serialize=False)),
                ('pos_name', models.CharField(max_length=255)),
                ('configuration_details', models.JSONField()),
                ('created_at', models.DateTimeField(auto_now_add=True)),
                ('updated_at', models.DateTimeField(auto_now=True)),
            ],
        ),
    ]