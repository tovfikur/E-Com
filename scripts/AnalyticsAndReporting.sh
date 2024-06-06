#!/bin/bash

APP_NAME="AnalyticsAndReporting"
PROJECT_NAME="Khukumoni"
API_DIR="../$PROJECT_NAME/$APP_NAME/api"
VIEWS_FILE="$API_DIR/views.py"
URLS_FILE="$API_DIR/urls.py"
SERIALIZERS_FILE="$API_DIR/serializers.py"
PROJECT_URLS_FILE="../$PROJECT_NAME/$PROJECT_NAME/urls.py"
APP_URLS_FILE="../$PROJECT_NAME/$APP_NAME/urls.py"

# Create the api folder and files
mkdir -p $API_DIR
touch $API_DIR/__init__.py

# Create serializers.py
cat <<EOF > $SERIALIZERS_FILE
from rest_framework import serializers
from ..models import (
    RevenueAnalytics, CustomerBehaviorAnalytics, ProductPerformanceAnalytics,
    OrderFulfillmentAnalytics, InventoryManagementAnalytics,
    MarketingCampaignAnalytics, CustomerServiceAnalytics,
    UserEngagementAnalytics, ConversionRateOptimizationAnalytics,
    FinancialReporting, DataVisualizationDashboards, CustomReporting
)

class RevenueAnalyticsSerializer(serializers.ModelSerializer):
    class Meta:
        model = RevenueAnalytics
        fields = '__all__'

class CustomerBehaviorAnalyticsSerializer(serializers.ModelSerializer):
    class Meta:
        model = CustomerBehaviorAnalytics
        fields = '__all__'

class ProductPerformanceAnalyticsSerializer(serializers.ModelSerializer):
    class Meta:
        model = ProductPerformanceAnalytics
        fields = '__all__'

class OrderFulfillmentAnalyticsSerializer(serializers.ModelSerializer):
    class Meta:
        model = OrderFulfillmentAnalytics
        fields = '__all__'

class InventoryManagementAnalyticsSerializer(serializers.ModelSerializer):
    class Meta:
        model = InventoryManagementAnalytics
        fields = '__all__'

class MarketingCampaignAnalyticsSerializer(serializers.ModelSerializer):
    class Meta:
        model = MarketingCampaignAnalytics
        fields = '__all__'

class CustomerServiceAnalyticsSerializer(serializers.ModelSerializer):
    class Meta:
        model = CustomerServiceAnalytics
        fields = '__all__'

class UserEngagementAnalyticsSerializer(serializers.ModelSerializer):
    class Meta:
        model = UserEngagementAnalytics
        fields = '__all__'

class ConversionRateOptimizationAnalyticsSerializer(serializers.ModelSerializer):
    class Meta:
        model = ConversionRateOptimizationAnalytics
        fields = '__all__'

class FinancialReportingSerializer(serializers.ModelSerializer):
    class Meta:
        model = FinancialReporting
        fields = '__all__'

class DataVisualizationDashboardsSerializer(serializers.ModelSerializer):
    class Meta:
        model = DataVisualizationDashboards
        fields = '__all__'

class CustomReportingSerializer(serializers.ModelSerializer):
    class Meta:
        model = CustomReporting
        fields = '__all__'
EOF

# Create views.py
cat <<EOF > $VIEWS_FILE
from rest_framework import viewsets
from ..models import (
    RevenueAnalytics, CustomerBehaviorAnalytics, ProductPerformanceAnalytics,
    OrderFulfillmentAnalytics, InventoryManagementAnalytics,
    MarketingCampaignAnalytics, CustomerServiceAnalytics,
    UserEngagementAnalytics, ConversionRateOptimizationAnalytics,
    FinancialReporting, DataVisualizationDashboards, CustomReporting
)
from .serializers import (
    RevenueAnalyticsSerializer, CustomerBehaviorAnalyticsSerializer, ProductPerformanceAnalyticsSerializer,
    OrderFulfillmentAnalyticsSerializer, InventoryManagementAnalyticsSerializer,
    MarketingCampaignAnalyticsSerializer, CustomerServiceAnalyticsSerializer,
    UserEngagementAnalyticsSerializer, ConversionRateOptimizationAnalyticsSerializer,
    FinancialReportingSerializer, DataVisualizationDashboardsSerializer, CustomReportingSerializer
)

class RevenueAnalyticsViewSet(viewsets.ModelViewSet):
    queryset = RevenueAnalytics.objects.all()
    serializer_class = RevenueAnalyticsSerializer

class CustomerBehaviorAnalyticsViewSet(viewsets.ModelViewSet):
    queryset = CustomerBehaviorAnalytics.objects.all()
    serializer_class = CustomerBehaviorAnalyticsSerializer

class ProductPerformanceAnalyticsViewSet(viewsets.ModelViewSet):
    queryset = ProductPerformanceAnalytics.objects.all()
    serializer_class = ProductPerformanceAnalyticsSerializer

class OrderFulfillmentAnalyticsViewSet(viewsets.ModelViewSet):
    queryset = OrderFulfillmentAnalytics.objects.all()
    serializer_class = OrderFulfillmentAnalyticsSerializer

class InventoryManagementAnalyticsViewSet(viewsets.ModelViewSet):
    queryset = InventoryManagementAnalytics.objects.all()
    serializer_class = InventoryManagementAnalyticsSerializer

class MarketingCampaignAnalyticsViewSet(viewsets.ModelViewSet):
    queryset = MarketingCampaignAnalytics.objects.all()
    serializer_class = MarketingCampaignAnalyticsSerializer

class CustomerServiceAnalyticsViewSet(viewsets.ModelViewSet):
    queryset = CustomerServiceAnalytics.objects.all()
    serializer_class = CustomerServiceAnalyticsSerializer

class UserEngagementAnalyticsViewSet(viewsets.ModelViewSet):
    queryset = UserEngagementAnalytics.objects.all()
    serializer_class = UserEngagementAnalyticsSerializer

class ConversionRateOptimizationAnalyticsViewSet(viewsets.ModelViewSet):
    queryset = ConversionRateOptimizationAnalytics.objects.all()
    serializer_class = ConversionRateOptimizationAnalyticsSerializer

class FinancialReportingViewSet(viewsets.ModelViewSet):
    queryset = FinancialReporting.objects.all()
    serializer_class = FinancialReportingSerializer

class DataVisualizationDashboardsViewSet(viewsets.ModelViewSet):
    queryset = DataVisualizationDashboards.objects.all()
    serializer_class = DataVisualizationDashboardsSerializer

class CustomReportingViewSet(viewsets.ModelViewSet):
    queryset = CustomReporting.objects.all()
    serializer_class = CustomReportingSerializer
EOF

# Create urls.py
cat <<EOF > $URLS_FILE
from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import (
    RevenueAnalyticsViewSet, CustomerBehaviorAnalyticsViewSet, ProductPerformanceAnalyticsViewSet,
    OrderFulfillmentAnalyticsViewSet, InventoryManagementAnalyticsViewSet,
    MarketingCampaignAnalyticsViewSet, CustomerServiceAnalyticsViewSet,
    UserEngagementAnalyticsViewSet, ConversionRateOptimizationAnalyticsViewSet,
    FinancialReportingViewSet, DataVisualizationDashboardsViewSet, CustomReportingViewSet
)

router = DefaultRouter()
router.register(r'revenue_analytics', RevenueAnalyticsViewSet)
router.register(r'customer_behavior_analytics', CustomerBehaviorAnalyticsViewSet)
router.register(r'product_performance_analytics', ProductPerformanceAnalyticsViewSet)
router.register(r'order_fulfillment_analytics', OrderFulfillmentAnalyticsViewSet)
router.register(r'inventory_management_analytics', InventoryManagementAnalyticsViewSet)
router.register(r'marketing_campaign_analytics', MarketingCampaignAnalyticsViewSet)
router.register(r'customer_service_analytics', CustomerServiceAnalyticsViewSet)
router.register(r'user_engagement_analytics', UserEngagementAnalyticsViewSet)
router.register(r'cro_analytics', ConversionRateOptimizationAnalyticsViewSet)
router.register(r'financial_reporting', FinancialReportingViewSet)
router.register(r'dashboards', DataVisualizationDashboardsViewSet)
router.register(r'custom_reporting', CustomReportingViewSet)

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


echo "API setup for $APP_NAME completed."
