#!/bin/bash

APP_NAME="GiftCardManagement"
PROJECT_NAME="YourProjectName"
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
from ..models import GiftCards, GiftCardTransactions, GiftCardNotifications, POSIntegrationConfiguration, \
    GiftCardRedemptionOptions, GiftCardCustomizationOptions

class GiftCardsSerializer(serializers.ModelSerializer):
    class Meta:
        model = GiftCards
        fields = '__all__'

class GiftCardTransactionsSerializer(serializers.ModelSerializer):
    class Meta:
        model = GiftCardTransactions
        fields = '__all__'

class GiftCardNotificationsSerializer(serializers.ModelSerializer):
    class Meta:
        model = GiftCardNotifications
        fields = '__all__'

class POSIntegrationConfigurationSerializer(serializers.ModelSerializer):
    class Meta:
        model = POSIntegrationConfiguration
        fields = '__all__'

class GiftCardRedemptionOptionsSerializer(serializers.ModelSerializer):
    class Meta:
        model = GiftCardRedemptionOptions
        fields = '__all__'

class GiftCardCustomizationOptionsSerializer(serializers.ModelSerializer):
    class Meta:
        model = GiftCardCustomizationOptions
        fields = '__all__'
EOF

# Step 3: Create views.py
cat <<EOF > $VIEWS_FILE
from rest_framework import viewsets
from ..models import GiftCards, GiftCardTransactions, GiftCardNotifications, POSIntegrationConfiguration, \
    GiftCardRedemptionOptions, GiftCardCustomizationOptions
from .serializers import GiftCardsSerializer

class GiftCardsViewSet(viewsets.ModelViewSet):
    queryset = GiftCards.objects.all()
    serializer_class = GiftCardsSerializer

class GiftCardTransactionsViewSet(viewsets.ModelViewSet):
    queryset = GiftCardTransactions.objects.all()
    serializer_class = GiftCardTransactionsSerializer

class GiftCardNotificationsViewSet(viewsets.ModelViewSet):
    queryset = GiftCardNotifications.objects.all()
    serializer_class = GiftCardNotificationsSerializer

class POSIntegrationConfigurationViewSet(viewsets.ModelViewSet):
    queryset = POSIntegrationConfiguration.objects.all()
    serializer_class = POSIntegrationConfigurationSerializer

class GiftCardRedemptionOptionsViewSet(viewsets.ModelViewSet):
    queryset = GiftCardRedemptionOptions.objects.all()
    serializer_class = GiftCardRedemptionOptionsSerializer

class GiftCardCustomizationOptionsViewSet(viewsets.ModelViewSet):
    queryset = GiftCardCustomizationOptions.objects.all()
    serializer_class = GiftCardCustomizationOptionsSerializer
EOF

# Step 4: Create urls.py
cat <<EOF > $URLS_FILE
from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import (
    GiftCardsViewSet, GiftCardTransactionsViewSet,
    GiftCardNotificationsViewSet, POSIntegrationConfigurationViewSet,
    GiftCardRedemptionOptionsViewSet, GiftCardCustomizationOptionsViewSet
)

router = DefaultRouter()
router.register(r'gift_cards', GiftCardsViewSet)
router.register(r'gift_card_transactions', GiftCardTransactionsViewSet)
router.register(r'gift_card_notifications', GiftCardNotificationsViewSet)
router.register(r'pos_integration_configuration', POSIntegrationConfigurationViewSet)
router.register(r'gift_card_redemption_options', GiftCardRedemptionOptionsViewSet)
router.register(r'gift_card_customization_options', GiftCardCustomizationOptionsViewSet)

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