from rest_framework import viewsets
from ..models import (
    ShippingAddress, ShippingLabel, PackageTracking,
    ShippingCarrier, ShippingInsurance, ShippingZone, ShippingPreference,
    ShippingNotification, DeliverySchedule, Location, ShippingCost,
    ShippingRestriction, OrderRestriction
)
from .serializers import (
    ShippingAddressSerializer, ShippingLabelSerializer, PackageTrackingSerializer,
    ShippingCarrierSerializer, ShippingInsuranceSerializer, ShippingZoneSerializer,
    ShippingPreferenceSerializer, ShippingNotificationSerializer, DeliveryScheduleSerializer,
    LocationSerializer, ShippingCostSerializer, ShippingRestrictionSerializer, OrderRestrictionSerializer
)

class ShippingAddressViewSet(viewsets.ModelViewSet):
    queryset = ShippingAddress.objects.all()
    serializer_class = ShippingAddressSerializer

class ShippingLabelViewSet(viewsets.ModelViewSet):
    queryset = ShippingLabel.objects.all()
    serializer_class = ShippingLabelSerializer

class PackageTrackingViewSet(viewsets.ModelViewSet):
    queryset = PackageTracking.objects.all()
    serializer_class = PackageTrackingSerializer

class ShippingCarrierViewSet(viewsets.ModelViewSet):
    queryset = ShippingCarrier.objects.all()
    serializer_class = ShippingCarrierSerializer

class ShippingInsuranceViewSet(viewsets.ModelViewSet):
    queryset = ShippingInsurance.objects.all()
    serializer_class = ShippingInsuranceSerializer

class ShippingZoneViewSet(viewsets.ModelViewSet):
    queryset = ShippingZone.objects.all()
    serializer_class = ShippingZoneSerializer

class ShippingPreferenceViewSet(viewsets.ModelViewSet):
    queryset = ShippingPreference.objects.all()
    serializer_class = ShippingPreferenceSerializer

class ShippingNotificationViewSet(viewsets.ModelViewSet):
    queryset = ShippingNotification.objects.all()
    serializer_class = ShippingNotificationSerializer

class DeliveryScheduleViewSet(viewsets.ModelViewSet):
    queryset = DeliverySchedule.objects.all()
    serializer_class = DeliveryScheduleSerializer

class LocationViewSet(viewsets.ModelViewSet):
    queryset = Location.objects.all()
    serializer_class = LocationSerializer

class ShippingCostViewSet(viewsets.ModelViewSet):
    queryset = ShippingCost.objects.all()
    serializer_class = ShippingCostSerializer

class ShippingRestrictionViewSet(viewsets.ModelViewSet):
    queryset = ShippingRestriction.objects.all()
    serializer_class = ShippingRestrictionSerializer

class OrderRestrictionViewSet(viewsets.ModelViewSet):
    queryset = OrderRestriction.objects.all()
    serializer_class = OrderRestrictionSerializer
