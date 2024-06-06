#!/bin/bash

APP_NAME="PaymentProcessing"
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
    Payments, PaymentMethods, PaymentHistory, PaymentTokens,
    PaymentNotifications, PaymentGateways, RecurringPayments,
    Settlements, FraudDetection, SecureAuthentication
)

class PaymentsSerializer(serializers.ModelSerializer):
    class Meta:
        model = Payments
        fields = '__all__'

class PaymentMethodsSerializer(serializers.ModelSerializer):
    class Meta:
        model = PaymentMethods
        fields = '__all__'

class PaymentHistorySerializer(serializers.ModelSerializer):
    class Meta:
        model = PaymentHistory
        fields = '__all__'

class PaymentTokensSerializer(serializers.ModelSerializer):
    class Meta:
        model = PaymentTokens
        fields = '__all__'

class PaymentNotificationsSerializer(serializers.ModelSerializer):
    class Meta:
        model = PaymentNotifications
        fields = '__all__'

class PaymentGatewaysSerializer(serializers.ModelSerializer):
    class Meta:
        model = PaymentGateways
        fields = '__all__'

class RecurringPaymentsSerializer(serializers.ModelSerializer):
    class Meta:
        model = RecurringPayments
        fields = '__all__'

class SettlementsSerializer(serializers.ModelSerializer):
    class Meta:
        model = Settlements
        fields = '__all__'

class FraudDetectionSerializer(serializers.ModelSerializer):
    class Meta:
        model = FraudDetection
        fields = '__all__'

class SecureAuthenticationSerializer(serializers.ModelSerializer):
    class Meta:
        model = SecureAuthentication
        fields = '__all__'
EOF

# Create views.py
cat <<EOF > $VIEWS_FILE
from rest_framework import viewsets
from ..models import (
    Payments, PaymentMethods, PaymentHistory, PaymentTokens,
    PaymentNotifications, PaymentGateways, RecurringPayments,
    Settlements, FraudDetection, SecureAuthentication
)
from .serializers import (
    PaymentsSerializer, PaymentMethodsSerializer, PaymentHistorySerializer,
    PaymentTokensSerializer, PaymentNotificationsSerializer, PaymentGatewaysSerializer,
    RecurringPaymentsSerializer, SettlementsSerializer, FraudDetectionSerializer,
    SecureAuthenticationSerializer
)

class PaymentsViewSet(viewsets.ModelViewSet):
    queryset = Payments.objects.all()
    serializer_class = PaymentsSerializer

class PaymentMethodsViewSet(viewsets.ModelViewSet):
    queryset = PaymentMethods.objects.all()
    serializer_class = PaymentMethodsSerializer

class PaymentHistoryViewSet(viewsets.ModelViewSet):
    queryset = PaymentHistory.objects.all()
    serializer_class = PaymentHistorySerializer

class PaymentTokensViewSet(viewsets.ModelViewSet):
    queryset = PaymentTokens.objects.all()
    serializer_class = PaymentTokensSerializer

class PaymentNotificationsViewSet(viewsets.ModelViewSet):
    queryset = PaymentNotifications.objects.all()
    serializer_class = PaymentNotificationsSerializer

class PaymentGatewaysViewSet(viewsets.ModelViewSet):
    queryset = PaymentGateways.objects.all()
    serializer_class = PaymentGatewaysSerializer

class RecurringPaymentsViewSet(viewsets.ModelViewSet):
    queryset = RecurringPayments.objects.all()
    serializer_class = RecurringPaymentsSerializer

class SettlementsViewSet(viewsets.ModelViewSet):
    queryset = Settlements.objects.all()
    serializer_class = SettlementsSerializer

class FraudDetectionViewSet(viewsets.ModelViewSet):
    queryset = FraudDetection.objects.all()
    serializer_class = FraudDetectionSerializer

class SecureAuthenticationViewSet(viewsets.ModelViewSet):
    queryset = SecureAuthentication.objects.all()
    serializer_class = SecureAuthenticationSerializer
EOF

# Create urls.py
cat <<EOF > $URLS_FILE
from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import (
    PaymentsViewSet, PaymentMethodsViewSet, PaymentHistoryViewSet, PaymentTokensViewSet,
    PaymentNotificationsViewSet, PaymentGatewaysViewSet, RecurringPaymentsViewSet,
    SettlementsViewSet, FraudDetectionViewSet, SecureAuthenticationViewSet
)

router = DefaultRouter()
router.register(r'payments', PaymentsViewSet)
router.register(r'payment_methods', PaymentMethodsViewSet)
router.register(r'payment_history', PaymentHistoryViewSet)
router.register(r'payment_tokens', PaymentTokensViewSet)
router.register(r'payment_notifications', PaymentNotificationsViewSet)
router.register(r'payment_gateways', PaymentGatewaysViewSet)
router.register(r'recurring_payments', RecurringPaymentsViewSet)
router.register(r'settlements', SettlementsViewSet)
router.register(r'fraud_detection', FraudDetectionViewSet)
router.register(r'secure_authentication', SecureAuthenticationViewSet)

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

echo "API setup for PaymentProcessing completed successfully."
