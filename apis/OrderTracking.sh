#!/bin/bash

APP_NAME="OrderTracking"
PROJECT_NAME="Khukumoni"
API_DIR="../$PROJECT_NAME/$APP_NAME/api"
VIEWS_FILE="$API_DIR/views.py"
URLS_FILE="$API_DIR/urls.py"
SERIALIZERS_FILE="$API_DIR/serializers.py"
SETTINGS_FILE="../$PROJECT_NAME/$PROJECT_NAME/settings.py"
PROJECT_URLS_FILE="../$PROJECT_NAME/$PROJECT_NAME/urls.py"
APP_URLS_FILE="../$PROJECT_NAME/$APP_NAME/urls.py"

# Step 1: Create the api folder and files
mkdir -p $API_DIR
touch $API_DIR/__init__.py

# Step 2: Create serializers.py
cat <<EOF > $SERIALIZERS_FILE
from rest_framework import serializers
from ..models import ( OrderTracking, TrackingUpdates, DeliveryRoutes, ProofOfDelivery, DeliveryNotifications, DeliveryIssues,
CarrierIntegration, DeliveryHistory, DeliverySignatures )

class OrderTrackingSerializer(serializers.ModelSerializer):
    class Meta:
        model = OrderTracking
        fields = '__all__'

class TrackingUpdatesSerializer(serializers.ModelSerializer):
    class Meta:
        model = TrackingUpdates
        fields = '__all__'

class DeliveryRoutesSerializer(serializers.ModelSerializer):
    class Meta:
        model = DeliveryRoutes
        fields = '__all__'

class ProofOfDeliverySerializer(serializers.ModelSerializer):
    class Meta:
        model = ProofOfDelivery
        fields = '__all__'

class DeliveryNotificationsSerializer(serializers.ModelSerializer):
    class Meta:
        model = DeliveryNotifications
        fields = '__all__'

class DeliveryIssuesSerializer(serializers.ModelSerializer):
    class Meta:
        model = DeliveryIssues
        fields = '__all__'

class CarrierIntegrationSerializer(serializers.ModelSerializer):
    class Meta:
        model = CarrierIntegration
        fields = '__all__'

class DeliveryHistorySerializer(serializers.ModelSerializer):
    class Meta:
        model = DeliveryHistory
        fields = '__all__'

class DeliverySignaturesSerializer(serializers.ModelSerializer):
    class Meta:
        model = DeliverySignatures
        fields = '__all__'
EOF

# Step 3: Create views.py
cat <<EOF > $VIEWS_FILE
from rest_framework import viewsets
from ..models import ( OrderTracking, TrackingUpdates, DeliveryRoutes, ProofOfDelivery, DeliveryNotifications,
DeliveryIssues, CarrierIntegration, DeliveryHistory, DeliverySignatures )
from .serializers import (
    DeliveryHistorySerializer,
    DeliveryIssuesSerializer,
    DeliveryNotificationsSerializer,
    DeliveryRoutesSerializer,
    DeliverySignaturesSerializer,
    OrderTrackingSerializer,
    ProofOfDeliverySerializer,
    TrackingUpdatesSerializer,
    CarrierIntegrationSerializer
)

class OrderTrackingViewSet(viewsets.ModelViewSet):
    queryset = OrderTracking.objects.all()
    serializer_class = OrderTrackingSerializer

class TrackingUpdatesViewSet(viewsets.ModelViewSet):
    queryset = TrackingUpdates.objects.all()
    serializer_class = TrackingUpdatesSerializer

class DeliveryRoutesViewSet(viewsets.ModelViewSet):
    queryset = DeliveryRoutes.objects.all()
    serializer_class = DeliveryRoutesSerializer

class ProofOfDeliveryViewSet(viewsets.ModelViewSet):
    queryset = ProofOfDelivery.objects.all()
    serializer_class = ProofOfDeliverySerializer

class DeliveryNotificationsViewSet(viewsets.ModelViewSet):
    queryset = DeliveryNotifications.objects.all()
    serializer_class = DeliveryNotificationsSerializer

class DeliveryIssuesViewSet(viewsets.ModelViewSet):
    queryset = DeliveryIssues.objects.all()
    serializer_class = DeliveryIssuesSerializer

class CarrierIntegrationViewSet(viewsets.ModelViewSet):
    queryset = CarrierIntegration.objects.all()
    serializer_class = CarrierIntegrationSerializer

class DeliveryHistoryViewSet(viewsets.ModelViewSet):
    queryset = DeliveryHistory.objects.all()
    serializer_class = DeliveryHistorySerializer

class DeliverySignaturesViewSet(viewsets.ModelViewSet):
    queryset = DeliverySignatures.objects.all()
    serializer_class = DeliverySignaturesSerializer
EOF

# Step 4: Create urls.py
cat <<EOF > $URLS_FILE
from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import OrderTrackingViewSet

router = DefaultRouter()
router.register(r'order_tracking', OrderTrackingViewSet)

urlpatterns = [
    path('', include(router.urls)),
]
EOF

# Step 5: Ensure the main project urls.py file exists and include the api urls
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

# Step 6: Add the app path to the main project urls.py if not already included
if ! grep -q "path('$APP_NAME/', include('$APP_NAME.urls'))" "$PROJECT_URLS_FILE"; then
    sed -i "/urlpatterns = \[/a \ \ \ \ path('$APP_NAME/', include('$APP_NAME.urls'))," $PROJECT_URLS_FILE
fi

# Display success message
echo "API setup for $APP_NAME completed."