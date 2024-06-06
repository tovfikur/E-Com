APP_NAME="OrderManagement"
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
    Order, OrderItem, Shipment, Return, Refund, OrderCommunication,
    RecurringOrder, OrderBatch
)

class OrderSerializer(serializers.ModelSerializer):
    class Meta:
        model = Order
        fields = '__all__'

class OrderItemSerializer(serializers.ModelSerializer):
    class Meta:
        model = OrderItem
        fields = '__all__'

class ShipmentSerializer(serializers.ModelSerializer):
    class Meta:
        model = Shipment
        fields = '__all__'

class ReturnSerializer(serializers.ModelSerializer):
    class Meta:
        model = Return
        fields = '__all__'

class RefundSerializer(serializers.ModelSerializer):
    class Meta:
        model = Refund
        fields = '__all__'

class OrderCommunicationSerializer(serializers.ModelSerializer):
    class Meta:
        model = OrderCommunication
        fields = '__all__'

class RecurringOrderSerializer(serializers.ModelSerializer):
    class Meta:
        model = RecurringOrder
        fields = '__all__'

class OrderBatchSerializer(serializers.ModelSerializer):
    class Meta:
        model = OrderBatch
        fields = '__all__'
EOF

# Step 3: Create views.py
cat <<EOF > $VIEWS_FILE
from rest_framework import viewsets
from ..models import (
    Order, OrderItem, Shipment, Return, Refund, OrderCommunication,
    RecurringOrder, OrderBatch
)
from .serializers import (
    OrderSerializer, OrderItemSerializer, ShipmentSerializer, ReturnSerializer,
    RefundSerializer, OrderCommunicationSerializer, RecurringOrderSerializer,
    OrderBatchSerializer
)

class OrderViewSet(viewsets.ModelViewSet):
    queryset = Order.objects.all()
    serializer_class = OrderSerializer

class OrderItemViewSet(viewsets.ModelViewSet):
    queryset = OrderItem.objects.all()
    serializer_class = OrderItemSerializer

class ShipmentViewSet(viewsets.ModelViewSet):
    queryset = Shipment.objects.all()
    serializer_class = ShipmentSerializer

class ReturnViewSet(viewsets.ModelViewSet):
    queryset = Return.objects.all()
    serializer_class = ReturnSerializer

class RefundViewSet(viewsets.ModelViewSet):
    queryset = Refund.objects.all()
    serializer_class = RefundSerializer

class OrderCommunicationViewSet(viewsets.ModelViewSet):
    queryset = OrderCommunication.objects.all()
    serializer_class = OrderCommunicationSerializer

class RecurringOrderViewSet(viewsets.ModelViewSet):
    queryset = RecurringOrder.objects.all()
    serializer_class = RecurringOrderSerializer

class OrderBatchViewSet(viewsets.ModelViewSet):
    queryset = OrderBatch.objects.all()
    serializer_class = OrderBatchSerializer
EOF

# Step 4: Create urls.py
cat <<EOF > $URLS_FILE
from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import (
    OrderViewSet, OrderItemViewSet, ShipmentViewSet, ReturnViewSet, RefundViewSet,
    OrderCommunicationViewSet, RecurringOrderViewSet, OrderBatchViewSet
)

router = DefaultRouter()
router.register(r'orders', OrderViewSet)
router.register(r'order_items', OrderItemViewSet)
router.register(r'shipments', ShipmentViewSet)
router.register(r'returns', ReturnViewSet)
router.register(r'refunds', RefundViewSet)
router.register(r'order_communications', OrderCommunicationViewSet)
router.register(r'recurring_orders', RecurringOrderViewSet)
router.register(r'order_batches', OrderBatchViewSet)

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

echo "API setup for OrderManagement completed successfully."