#!/bin/bash

APP_NAME="InventoryManagement"
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
from ..models import (
    InventoryLocation, Inventory, InventoryHistory, StockAlert, StockTransfer,
    Batch, ExpiryManagement, InventoryReport, InventoryAdjustmentReason
)

class InventoryLocationSerializer(serializers.ModelSerializer):
    class Meta:
        model = InventoryLocation
        fields = '__all__'

class InventorySerializer(serializers.ModelSerializer):
    class Meta:
        model = Inventory
        fields = '__all__'

class InventoryHistorySerializer(serializers.ModelSerializer):
    class Meta:
        model = InventoryHistory
        fields = '__all__'

class StockAlertSerializer(serializers.ModelSerializer):
    class Meta:
        model = StockAlert
        fields = '__all__'

class StockTransferSerializer(serializers.ModelSerializer):
    class Meta:
        model = StockTransfer
        fields = '__all__'

class BatchSerializer(serializers.ModelSerializer):
    class Meta:
        model = Batch
        fields = '__all__'

class ExpiryManagementSerializer(serializers.ModelSerializer):
    class Meta:
        model = ExpiryManagement
        fields = '__all__'

class InventoryReportSerializer(serializers.ModelSerializer):
    class Meta:
        model = InventoryReport
        fields = '__all__'

class InventoryAdjustmentReasonSerializer(serializers.ModelSerializer):
    class Meta:
        model = InventoryAdjustmentReason
        fields = '__all__'
EOF

# Step 3: Create views.py
cat <<EOF > $VIEWS_FILE
from rest_framework import viewsets
from ..models import (
    InventoryLocation, Inventory, InventoryHistory, StockAlert, StockTransfer,
    Batch, ExpiryManagement, InventoryReport, InventoryAdjustmentReason
)
from .serializers import (
    InventoryLocationSerializer, InventorySerializer, InventoryHistorySerializer,
    StockAlertSerializer, StockTransferSerializer, BatchSerializer, ExpiryManagementSerializer,
    InventoryReportSerializer, InventoryAdjustmentReasonSerializer
)

class InventoryLocationViewSet(viewsets.ModelViewSet):
    queryset = InventoryLocation.objects.all()
    serializer_class = InventoryLocationSerializer

class InventoryViewSet(viewsets.ModelViewSet):
    queryset = Inventory.objects.all()
    serializer_class = InventorySerializer

class InventoryHistoryViewSet(viewsets.ModelViewSet):
    queryset = InventoryHistory.objects.all()
    serializer_class = InventoryHistorySerializer

class StockAlertViewSet(viewsets.ModelViewSet):
    queryset = StockAlert.objects.all()
    serializer_class = StockAlertSerializer

class StockTransferViewSet(viewsets.ModelViewSet):
    queryset = StockTransfer.objects.all()
    serializer_class = StockTransferSerializer

class BatchViewSet(viewsets.ModelViewSet):
    queryset = Batch.objects.all()
    serializer_class = BatchSerializer

class ExpiryManagementViewSet(viewsets.ModelViewSet):
    queryset = ExpiryManagement.objects.all()
    serializer_class = ExpiryManagementSerializer

class InventoryReportViewSet(viewsets.ModelViewSet):
    queryset = InventoryReport.objects.all()
    serializer_class = InventoryReportSerializer

class InventoryAdjustmentReasonViewSet(viewsets.ModelViewSet):
    queryset = InventoryAdjustmentReason.objects.all()
    serializer_class = InventoryAdjustmentReasonSerializer
EOF

# Step 4: Create urls.py
cat <<EOF > $URLS_FILE
from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import (
    InventoryLocationViewSet, InventoryViewSet, InventoryHistoryViewSet,
    StockAlertViewSet, StockTransferViewSet, BatchViewSet, ExpiryManagementViewSet,
    InventoryReportViewSet, InventoryAdjustmentReasonViewSet
)

router = DefaultRouter()
router.register(r'locations', InventoryLocationViewSet)
router.register(r'inventories', InventoryViewSet)
router.register(r'histories', InventoryHistoryViewSet)
router.register(r'alerts', StockAlertViewSet)
router.register(r'transfers', StockTransferViewSet)
router.register(r'batches', BatchViewSet)
router.register(r'expiries', ExpiryManagementViewSet)
router.register(r'reports', InventoryReportViewSet)
router.register(r'adjustment_reasons', InventoryAdjustmentReasonViewSet)

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

echo "API setup for InventoryManagement completed successfully."
