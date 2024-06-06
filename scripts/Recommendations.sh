#!/bin/bash

APP_NAME="Recommendations"
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
    PersonalizedRecommendation, SimilarProduct, TrendingProduct, NewArrival, Bestseller, 
    CrossSellProduct, UpSellProduct, FrequentlyBoughtTogether, CustomerBasedRecommendation, 
    DynamicPricingRecommendation, RecommendationRule, RealTimeRecommendationUpdate, 
    SegmentBasedRecommendation, FeedbackRecommendation, RecommendationPerformanceAnalytics, 
    CustomerSpecificRecommendation
)

class PersonalizedRecommendationSerializer(serializers.ModelSerializer):
    class Meta:
        model = PersonalizedRecommendation
        fields = '__all__'

class SimilarProductSerializer(serializers.ModelSerializer):
    class Meta:
        model = SimilarProduct
        fields = '__all__'

class TrendingProductSerializer(serializers.ModelSerializer):
    class Meta:
        model = TrendingProduct
        fields = '__all__'

class NewArrivalSerializer(serializers.ModelSerializer):
    class Meta:
        model = NewArrival
        fields = '__all__'

class BestsellerSerializer(serializers.ModelSerializer):
    class Meta:
        model = Bestseller
        fields = '__all__'

class CrossSellProductSerializer(serializers.ModelSerializer):
    class Meta:
        model = CrossSellProduct
        fields = '__all__'

class UpSellProductSerializer(serializers.ModelSerializer):
    class Meta:
        model = UpSellProduct
        fields = '__all__'

class FrequentlyBoughtTogetherSerializer(serializers.ModelSerializer):
    class Meta:
        model = FrequentlyBoughtTogether
        fields = '__all__'

class CustomerBasedRecommendationSerializer(serializers.ModelSerializer):
    class Meta:
        model = CustomerBasedRecommendation
        fields = '__all__'

class DynamicPricingRecommendationSerializer(serializers.ModelSerializer):
    class Meta:
        model = DynamicPricingRecommendation
        fields = '__all__'

class RecommendationRuleSerializer(serializers.ModelSerializer):
    class Meta:
        model = RecommendationRule
        fields = '__all__'

class RealTimeRecommendationUpdateSerializer(serializers.ModelSerializer):
    class Meta:
        model = RealTimeRecommendationUpdate
        fields = '__all__'

class SegmentBasedRecommendationSerializer(serializers.ModelSerializer):
    class Meta:
        model = SegmentBasedRecommendation
        fields = '__all__'

class FeedbackRecommendationSerializer(serializers.ModelSerializer):
    class Meta:
        model = FeedbackRecommendation
        fields = '__all__'

class RecommendationPerformanceAnalyticsSerializer(serializers.ModelSerializer):
    class Meta:
        model = RecommendationPerformanceAnalytics
        fields = '__all__'

class CustomerSpecificRecommendationSerializer(serializers.ModelSerializer):
    class Meta:
        model = CustomerSpecificRecommendation
        fields = '__all__'
EOF

# Create views.py
cat <<EOF > $VIEWS_FILE
from rest_framework import viewsets
from ..models import (
    PersonalizedRecommendation, SimilarProduct, TrendingProduct, NewArrival, Bestseller, 
    CrossSellProduct, UpSellProduct, FrequentlyBoughtTogether, CustomerBasedRecommendation, 
    DynamicPricingRecommendation, RecommendationRule, RealTimeRecommendationUpdate, 
    SegmentBasedRecommendation, FeedbackRecommendation, RecommendationPerformanceAnalytics, 
    CustomerSpecificRecommendation
)
from .serializers import (
    PersonalizedRecommendationSerializer, SimilarProductSerializer, TrendingProductSerializer, NewArrivalSerializer, 
    BestsellerSerializer, CrossSellProductSerializer, UpSellProductSerializer, FrequentlyBoughtTogetherSerializer, 
    CustomerBasedRecommendationSerializer, DynamicPricingRecommendationSerializer, RecommendationRuleSerializer, 
    RealTimeRecommendationUpdateSerializer, SegmentBasedRecommendationSerializer, FeedbackRecommendationSerializer, 
    RecommendationPerformanceAnalyticsSerializer, CustomerSpecificRecommendationSerializer
)

# Define viewsets for each model
class PersonalizedRecommendationViewSet(viewsets.ModelViewSet):
    queryset = PersonalizedRecommendation.objects.all()
    serializer_class = PersonalizedRecommendationSerializer

class SimilarProductViewSet(viewsets.ModelViewSet):
    queryset = SimilarProduct.objects.all()
    serializer_class = SimilarProductSerializer

class TrendingProductViewSet(viewsets.ModelViewSet):
    queryset = TrendingProduct.objects.all()
    serializer_class = TrendingProductSerializer

class NewArrivalViewSet(viewsets.ModelViewSet):
    queryset = NewArrival.objects.all()
    serializer_class = NewArrivalSerializer

class BestsellerViewSet(viewsets.ModelViewSet):
    queryset = Bestseller.objects.all()
    serializer_class = BestsellerSerializer

class CrossSellProductViewSet(viewsets.ModelViewSet):
    queryset = CrossSellProduct.objects.all()
    serializer_class = CrossSellProductSerializer

class UpSellProductViewSet(viewsets.ModelViewSet):
    queryset = UpSellProduct.objects.all()
    serializer_class = UpSellProductSerializer

class FrequentlyBoughtTogetherViewSet(viewsets.ModelViewSet):
    queryset = FrequentlyBoughtTogether.objects.all()
    serializer_class = FrequentlyBoughtTogetherSerializer

class CustomerBasedRecommendationViewSet(viewsets.ModelViewSet):
    queryset = CustomerBasedRecommendation.objects.all()
    serializer_class = CustomerBasedRecommendationSerializer

class DynamicPricingRecommendationViewSet(viewsets.ModelViewSet):
    queryset = DynamicPricingRecommendation.objects.all()
    serializer_class = DynamicPricingRecommendationSerializer

class RecommendationRuleViewSet(viewsets.ModelViewSet):
    queryset = RecommendationRule.objects.all()
    serializer_class = RecommendationRuleSerializer

class RealTimeRecommendationUpdateViewSet(viewsets.ModelViewSet):
    queryset = RealTimeRecommendationUpdate.objects.all()
    serializer_class = RealTimeRecommendationUpdateSerializer

class SegmentBasedRecommendationViewSet(viewsets.ModelViewSet):
    queryset = SegmentBasedRecommendation.objects.all()
    serializer_class = SegmentBasedRecommendationSerializer

class FeedbackRecommendationViewSet(viewsets.ModelViewSet):
    queryset = FeedbackRecommendation.objects.all()
    serializer_class = FeedbackRecommendationSerializer

class RecommendationPerformanceAnalyticsViewSet(viewsets.ModelViewSet):
    queryset = RecommendationPerformanceAnalytics.objects.all()
    serializer_class = RecommendationPerformanceAnalyticsSerializer

class CustomerSpecificRecommendationViewSet(viewsets.ModelViewSet):
    queryset = CustomerSpecificRecommendation.objects.all()
    serializer_class = CustomerSpecificRecommendationSerializer
EOF

# Create urls.py
cat <<EOF > $URLS_FILE
from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import (
    PersonalizedRecommendationViewSet, SimilarProductViewSet, TrendingProductViewSet, NewArrivalViewSet, 
    BestsellerViewSet, CrossSellProductViewSet, UpSellProductViewSet, FrequentlyBoughtTogetherViewSet, 
    CustomerBasedRecommendationViewSet, DynamicPricingRecommendationViewSet, RecommendationRuleViewSet, 
    RealTimeRecommendationUpdateViewSet, SegmentBasedRecommendationViewSet, FeedbackRecommendationViewSet, 
    RecommendationPerformanceAnalyticsViewSet, CustomerSpecificRecommendationViewSet
)

router = DefaultRouter()
router.register(r'personalized-recommendations', PersonalizedRecommendationViewSet)
router.register(r'similar-products', SimilarProductViewSet)
router.register(r'trending-products', TrendingProductViewSet)
router.register(r'new-arrivals', NewArrivalViewSet)
router.register(r'bestsellers', BestsellerViewSet)
router.register(r'cross-sell-products', CrossSellProductViewSet)
router.register(r'up-sell-products', UpSellProductViewSet)
router.register(r'frequently-bought-together', FrequentlyBoughtTogetherViewSet)
router.register(r'customer-based-recommendations', CustomerBasedRecommendationViewSet)
router.register(r'dynamic-pricing-recommendations', DynamicPricingRecommendationViewSet)
router.register(r'recommendation-rules', RecommendationRuleViewSet)
router.register(r'real-time-recommendation-updates', RealTimeRecommendationUpdateViewSet)
router.register(r'segment-based-recommendations', SegmentBasedRecommendationViewSet)
router.register(r'feedback-recommendations', FeedbackRecommendationViewSet)
router.register(r'recommendation-performance-analytics', RecommendationPerformanceAnalyticsViewSet)
router.register(r'customer-specific-recommendations', CustomerSpecificRecommendationViewSet)

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