from django.contrib import admin
from .models import (
    ShippingAddress, ShippingLabel, PackageTracking,
    ShippingCarrier, ShippingInsurance, ShippingZone, ShippingPreference,
    ShippingNotification, DeliverySchedule, Location, ShippingCost,
    ShippingRestriction, OrderRestriction
)


@admin.register(ShippingAddress)
class ShippingAddressAdmin(admin.ModelAdmin):
    list_display = ('address_id', 'recipient_name', 'street_address', 'city', 'state', 'postal_code', 'country', 'created_at', 'updated_at')
    search_fields = ('recipient_name', 'street_address', 'city', 'state', 'postal_code', 'country')

@admin.register(ShippingLabel)
class ShippingLabelAdmin(admin.ModelAdmin):
    list_display = ('label_id', 'order_id', 'label_type', 'label_url', 'created_at', 'updated_at')
    search_fields = ('label_type',)

@admin.register(PackageTracking)
class PackageTrackingAdmin(admin.ModelAdmin):
    list_display = ('tracking_id', 'order_id', 'tracking_number', 'carrier_id', 'status', 'created_at', 'updated_at')
    search_fields = ('tracking_number', 'status')

@admin.register(ShippingCarrier)
class ShippingCarrierAdmin(admin.ModelAdmin):
    list_display = ('carrier_id', 'carrier_name', 'created_at', 'updated_at')
    search_fields = ('carrier_name',)

@admin.register(ShippingInsurance)
class ShippingInsuranceAdmin(admin.ModelAdmin):
    list_display = ('insurance_id', 'order_id', 'coverage_amount', 'claim_status', 'created_at', 'updated_at')
    search_fields = ('claim_status',)

@admin.register(ShippingZone)
class ShippingZoneAdmin(admin.ModelAdmin):
    list_display = ('zone_id', 'name', 'description', 'created_at', 'updated_at')
    search_fields = ('name', 'description')

@admin.register(ShippingPreference)
class ShippingPreferenceAdmin(admin.ModelAdmin):
    list_display = ('preference_id', 'preference_name', 'preference_value', 'created_at', 'updated_at')
    search_fields = ('preference_name',)

@admin.register(ShippingNotification)
class ShippingNotificationAdmin(admin.ModelAdmin):
    list_display = ('notification_id', 'order_id', 'enabled', 'email', 'created_at', 'updated_at')
    search_fields = ('email',)

@admin.register(DeliverySchedule)
class DeliveryScheduleAdmin(admin.ModelAdmin):
    list_display = ('schedule_id', 'order_id', 'delivery_date', 'delivery_time', 'created_at', 'updated_at')
    search_fields = ('delivery_date', 'delivery_time')

@admin.register(Location)
class LocationAdmin(admin.ModelAdmin):
    list_display = ('location_id', 'name', 'address_id', 'location_type', 'created_at', 'updated_at')
    search_fields = ('name', 'location_type')

@admin.register(ShippingCost)
class ShippingCostAdmin(admin.ModelAdmin):
    list_display = ('cost_id', 'order_id', 'cost', 'estimation_method', 'created_at', 'updated_at')
    search_fields = ('estimation_method',)

@admin.register(ShippingRestriction)
class ShippingRestrictionAdmin(admin.ModelAdmin):
    list_display = ('restriction_id', 'description', 'created_at', 'updated_at')
    search_fields = ('description',)

@admin.register(OrderRestriction)
class OrderRestrictionAdmin(admin.ModelAdmin):
    list_display = ('order_id', 'restriction_id', 'created_at', 'updated_at')
    search_fields = ('order_id',)

