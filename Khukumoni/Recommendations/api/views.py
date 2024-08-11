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
