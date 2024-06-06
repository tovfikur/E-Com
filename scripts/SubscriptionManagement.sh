#!/bin/bash

APP_NAME="SubscriptionManagement"
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
    Subscriptions, SubscriptionPlans, SubscriptionCancellationReasons,
    SubscriptionRenewalReminders, SubscriptionPaymentMethods, SubscriptionUsageTracking,
    SubscriptionAnalytics, SubscriptionDiscounts, SubscriptionCustomizationOptions
)

class SubscriptionsSerializer(serializers.ModelSerializer):
    class Meta:
        model = Subscriptions
        fields = '__all__'

class SubscriptionPlansSerializer(serializers.ModelSerializer):
    class Meta:
        model = SubscriptionPlans
        fields = '__all__'

class SubscriptionCancellationReasonsSerializer(serializers.ModelSerializer):
    class Meta:
        model = SubscriptionCancellationReasons
        fields = '__all__'

class SubscriptionRenewalRemindersSerializer(serializers.ModelSerializer):
    class Meta:
        model = SubscriptionRenewalReminders
        fields = '__all__'

class SubscriptionPaymentMethodsSerializer(serializers.ModelSerializer):
    class Meta:
        model = SubscriptionPaymentMethods
        fields = '__all__'

class SubscriptionUsageTrackingSerializer(serializers.ModelSerializer):
    class Meta:
        model = SubscriptionUsageTracking
        fields = '__all__'

class SubscriptionAnalyticsSerializer(serializers.ModelSerializer):
    class Meta:
        model = SubscriptionAnalytics
        fields = '__all__'

class SubscriptionDiscountsSerializer(serializers.ModelSerializer):
    class Meta:
        model = SubscriptionDiscounts
        fields = '__all__'

class SubscriptionCustomizationOptionsSerializer(serializers.ModelSerializer):
    class Meta:
        model = SubscriptionCustomizationOptions
        fields = '__all__'
EOF

# Create views.py
cat <<EOF > $VIEWS_FILE
from rest_framework import viewsets
from ..models import (
    Subscriptions, SubscriptionPlans, SubscriptionCancellationReasons,
    SubscriptionRenewalReminders, SubscriptionPaymentMethods, SubscriptionUsageTracking,
    SubscriptionAnalytics, SubscriptionDiscounts, SubscriptionCustomizationOptions
)
from .serializers import (
    SubscriptionsSerializer, SubscriptionPlansSerializer, SubscriptionCancellationReasonsSerializer,
    SubscriptionRenewalRemindersSerializer, SubscriptionPaymentMethodsSerializer,
    SubscriptionUsageTrackingSerializer, SubscriptionAnalyticsSerializer, SubscriptionDiscountsSerializer,
    SubscriptionCustomizationOptionsSerializer
)

# Define viewsets for each model
class SubscriptionsViewSet(viewsets.ModelViewSet):
    queryset = Subscriptions.objects.all()
    serializer_class = SubscriptionsSerializer

class SubscriptionPlansViewSet(viewsets.ModelViewSet):
    queryset = SubscriptionPlans.objects.all()
    serializer_class = SubscriptionPlansSerializer

class SubscriptionCancellationReasonsViewSet(viewsets.ModelViewSet):
    queryset = SubscriptionCancellationReasons.objects.all()
    serializer_class = SubscriptionCancellationReasonsSerializer

class SubscriptionRenewalRemindersViewSet(viewsets.ModelViewSet):
    queryset = SubscriptionRenewalReminders.objects.all()
    serializer_class = SubscriptionRenewalRemindersSerializer

class SubscriptionPaymentMethodsViewSet(viewsets.ModelViewSet):
    queryset = SubscriptionPaymentMethods.objects.all()
    serializer_class = SubscriptionPaymentMethodsSerializer

class SubscriptionAnalyticsViewSet(viewsets.ModelViewSet):
    queryset = SubscriptionAnalytics.objects.all()
    serializer_class = SubscriptionAnalyticsSerializer

class SubscriptionDiscountsViewSet(viewsets.ModelViewSet):
    queryset = SubscriptionDiscounts.objects.all()
    serializer_class = SubscriptionDiscountsSerializer

class SubscriptionCustomizationOptionsViewSet(viewsets.ModelViewSet):
    queryset = SubscriptionCustomizationOptions.objects.all()
    serializer_class = SubscriptionCustomizationOptionsSerializer

class SubscriptionUsageTrackingViewSet(viewsets.ModelViewSet):
    queryset = SubscriptionUsageTracking.objects.all()
    serializer_class = SubscriptionUsageTrackingSerializer

EOF

# Create urls.py
cat <<EOF > $URLS_FILE
from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import (
    SubscriptionsViewSet, SubscriptionPlansViewSet, SubscriptionCancellationReasonsViewSet,
    SubscriptionRenewalRemindersViewSet, SubscriptionPaymentMethodsViewSet, SubscriptionUsageTrackingViewSet,
    SubscriptionAnalyticsViewSet, SubscriptionDiscountsViewSet, SubscriptionCustomizationOptionsViewSet
)

router = DefaultRouter()
router.register(r'subscriptions', SubscriptionsViewSet)
router.register(r'subscriptionplans', SubscriptionPlansViewSet)
router.register(r'subscriptioncancellationreasons', SubscriptionCancellationReasonsViewSet)
router.register(r'subscriptionrenewalreminders', SubscriptionRenewalRemindersViewSet)
router.register(r'subscriptionpaymentmethods', SubscriptionPaymentMethodsViewSet)
router.register(r'subscriptionusagetracking', SubscriptionUsageTrackingViewSet)
router.register(r'subscriptionanalytics', SubscriptionAnalyticsViewSet)
router.register(r'subscriptiondiscounts', SubscriptionDiscountsViewSet)
router.register(r'subscriptioncustomizationoptions', SubscriptionCustomizationOptionsViewSet)

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


# Display success message
echo "API setup for $APP_NAME completed."