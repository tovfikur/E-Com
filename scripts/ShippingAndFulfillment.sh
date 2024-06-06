#!/bin/bash

APP_NAME="ShippingAndFulfillment"
PROJECT_NAME="Khukumoni"
API_DIR="../$PROJECT_NAME/$APP_NAME/api"
VIEWS_FILE="$API_DIR/views.py"
URLS_FILE="$API_DIR/urls.py"
SERIALIZERS_FILE="$API_DIR/serializers.py"
SETTINGS_FILE="../$PROJECT_NAME/$PROJECT_NAME/settings.py"
PROJECT_URLS_FILE="../$PROJECT_NAME/$PROJECT_NAME/urls.py"
APP_URLS_FILE="../$PROJECT_NAME/$APP_NAME/urls.py"

# Create the api folder and files
mkdir -p $API_DIR
touch $API_DIR/__init__.py

# Create serializers.py
cat <<EOF > $SERIALIZERS_FILE
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
EOF

# Create views.py
cat <<EOF > $VIEWS_FILE
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
EOF

# Create urls.py
cat <<EOF > $URLS_FILE
from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import (
    ShippingAddressViewSet, ShippingLabelViewSet, PackageTrackingViewSet,
    ShippingCarrierViewSet, ShippingInsuranceViewSet, ShippingZoneViewSet,
    ShippingPreferenceViewSet, ShippingNotificationViewSet, DeliveryScheduleViewSet,
    LocationViewSet, ShippingCostViewSet, ShippingRestrictionViewSet, OrderRestrictionViewSet
)

router = DefaultRouter()
router.register(r'shipping_address', ShippingAddressViewSet)
router.register(r'shipping_label', ShippingLabelViewSet)
router.register(r'package_tracking', PackageTrackingViewSet)
router.register(r'shipping_carrier', ShippingCarrierViewSet)
router.register(r'shipping_insurance', ShippingInsuranceViewSet)
router.register(r'shipping_zone', ShippingZoneViewSet)
router.register(r'shipping_preference', ShippingPreferenceViewSet)
router.register(r'shipping_notification', ShippingNotificationViewSet)
router.register(r'delivery_schedule', DeliveryScheduleViewSet)
router.register(r'location', LocationViewSet)
router.register(r'shipping_cost', ShippingCostViewSet)
router.register(r'shipping_restriction', ShippingRestrictionViewSet)
router.register(r'order_restriction', OrderRestrictionViewSet)

urlpatterns = [
    path('', include(router.urls)),
]
EOF

# Ensure the main project urls.py file exists and include the api urls
if [ ! -f "$APP_URLS_FILE" ]; then
    # Create the main urls.py if it does not exist
    cat <<EOF > $APP_URLS_FILE
from django.urls import path, include

urlpatterns = [
    path('api/', include('$APP_NAME.api.urls')),
]
EOF
else
    # Add the api path if it's not already included
    if ! grep -q "path('api/', include('$APP_NAME.api.urls'))" "$APP_URLS_FILE"; then
        sed -i "/urlpatterns = \[/a \ \ \ \ path('api/', include('$APP_NAME.api.urls'))," $APP_URLS_FILE
    fi
fi

# Add the app path to the main project urls.py if not already included
if ! grep -q "path('$APP_NAME/', include('$APP_NAME.urls'))" "$PROJECT_URLS_FILE"; then
    sed -i "/urlpatterns = \[/a \ \ \ \ path('$APP_NAME/', include('$APP_NAME.urls'))," $PROJECT_URLS_FILE
fi

echo "API setup for ShippingAndFulfillment completed successfully."
