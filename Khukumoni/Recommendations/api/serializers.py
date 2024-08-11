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
