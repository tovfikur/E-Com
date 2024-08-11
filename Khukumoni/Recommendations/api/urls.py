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
