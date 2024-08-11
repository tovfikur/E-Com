from rest_framework import serializers
from ..models import (
    ShippingAddress, ShippingLabel, PackageTracking,
    ShippingCarrier, ShippingInsurance, ShippingZone, ShippingPreference,
    ShippingNotification, DeliverySchedule, Location, ShippingCost,
    ShippingRestriction, OrderRestriction
)

class ShippingAddressSerializer(serializers.ModelSerializer):
    class Meta:
        model = ShippingAddress
        fields = '__all__'

class ShippingLabelSerializer(serializers.ModelSerializer):
    class Meta:
        model = ShippingLabel
        fields = '__all__'

class PackageTrackingSerializer(serializers.ModelSerializer):
    class Meta:
        model = PackageTracking
        fields = '__all__'

class ShippingCarrierSerializer(serializers.ModelSerializer):
    class Meta:
        model = ShippingCarrier
        fields = '__all__'

class ShippingInsuranceSerializer(serializers.ModelSerializer):
    class Meta:
        model = ShippingInsurance
        fields = '__all__'

class ShippingZoneSerializer(serializers.ModelSerializer):
    class Meta:
        model = ShippingZone
        fields = '__all__'

class ShippingPreferenceSerializer(serializers.ModelSerializer):
    class Meta:
        model = ShippingPreference
        fields = '__all__'

class ShippingNotificationSerializer(serializers.ModelSerializer):
    class Meta:
        model = ShippingNotification
        fields = '__all__'

class DeliveryScheduleSerializer(serializers.ModelSerializer):
    class Meta:
        model = DeliverySchedule
        fields = '__all__'

class LocationSerializer(serializers.ModelSerializer):
    class Meta:
        model = Location
        fields = '__all__'

class ShippingCostSerializer(serializers.ModelSerializer):
    class Meta:
        model = ShippingCost
        fields = '__all__'

class ShippingRestrictionSerializer(serializers.ModelSerializer):
    class Meta:
        model = ShippingRestriction
        fields = '__all__'

class OrderRestrictionSerializer(serializers.ModelSerializer):
    class Meta:
        model = OrderRestriction
        fields = '__all__'
