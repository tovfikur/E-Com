from django.contrib import admin
from .models import (
    PersonalizedRecommendation, SimilarProduct, TrendingProduct, NewArrival, Bestseller, 
    CrossSellProduct, UpSellProduct, FrequentlyBoughtTogether, CustomerBasedRecommendation, 
    DynamicPricingRecommendation, RecommendationRule, RealTimeRecommendationUpdate, 
    SegmentBasedRecommendation, FeedbackRecommendation, RecommendationPerformanceAnalytics, 
    CustomerSpecificRecommendation
)

class PersonalizedRecommendationAdmin(admin.ModelAdmin):
    list_display = ('recommendation_id', 'customer_id', 'created_at', 'updated_at')
    search_fields = ('customer_id',)

class SimilarProductAdmin(admin.ModelAdmin):
    list_display = ('recommendation_id', 'product_id', 'created_at', 'updated_at')
    search_fields = ('product_id',)

class TrendingProductAdmin(admin.ModelAdmin):
    list_display = ('recommendation_id', 'created_at', 'updated_at')

class NewArrivalAdmin(admin.ModelAdmin):
    list_display = ('recommendation_id', 'category_id', 'created_at', 'updated_at')
    search_fields = ('category_id',)

class BestsellerAdmin(admin.ModelAdmin):
    list_display = ('recommendation_id', 'category_id', 'created_at', 'updated_at')
    search_fields = ('category_id',)

class CrossSellProductAdmin(admin.ModelAdmin):
    list_display = ('recommendation_id', 'product_id', 'created_at', 'updated_at')
    search_fields = ('product_id',)

class UpSellProductAdmin(admin.ModelAdmin):
    list_display = ('recommendation_id', 'product_id', 'created_at', 'updated_at')
    search_fields = ('product_id',)

class FrequentlyBoughtTogetherAdmin(admin.ModelAdmin):
    list_display = ('recommendation_id', 'product_id', 'created_at', 'updated_at')
    search_fields = ('product_id',)

class CustomerBasedRecommendationAdmin(admin.ModelAdmin):
    list_display = ('recommendation_id', 'customer_id', 'recommendation_type', 'created_at', 'updated_at')
    search_fields = ('customer_id', 'recommendation_type')

class DynamicPricingRecommendationAdmin(admin.ModelAdmin):
    list_display = ('recommendation_id', 'customer_id', 'created_at', 'updated_at')
    search_fields = ('customer_id',)

class RecommendationRuleAdmin(admin.ModelAdmin):
    list_display = ('rule_id', 'created_at', 'updated_at')

class RealTimeRecommendationUpdateAdmin(admin.ModelAdmin):
    list_display = ('update_id', 'customer_id', 'created_at', 'updated_at')
    search_fields = ('customer_id',)

class SegmentBasedRecommendationAdmin(admin.ModelAdmin):
    list_display = ('segment_id', 'created_at', 'updated_at')

class FeedbackRecommendationAdmin(admin.ModelAdmin):
    list_display = ('feedback_id', 'product_id', 'created_at', 'updated_at')
    search_fields = ('product_id',)

class RecommendationPerformanceAnalyticsAdmin(admin.ModelAdmin):
    list_display = ('analytics_id', 'product_id', 'views', 'conversions', 'click_through_rate', 'created_at', 'updated_at')
    search_fields = ('product_id',)

class CustomerSpecificRecommendationAdmin(admin.ModelAdmin):
    list_display = ('recommendation_id', 'customer_id', 'created_at', 'updated_at')
    search_fields = ('customer_id',)

admin.site.register(PersonalizedRecommendation, PersonalizedRecommendationAdmin)
admin.site.register(SimilarProduct, SimilarProductAdmin)
admin.site.register(TrendingProduct, TrendingProductAdmin)
admin.site.register(NewArrival, NewArrivalAdmin)
admin.site.register(Bestseller, BestsellerAdmin)
admin.site.register(CrossSellProduct, CrossSellProductAdmin)
admin.site.register(UpSellProduct, UpSellProductAdmin)
admin.site.register(FrequentlyBoughtTogether, FrequentlyBoughtTogetherAdmin)
admin.site.register(CustomerBasedRecommendation, CustomerBasedRecommendationAdmin)
admin.site.register(DynamicPricingRecommendation, DynamicPricingRecommendationAdmin)
admin.site.register(RecommendationRule, RecommendationRuleAdmin)
admin.site.register(RealTimeRecommendationUpdate, RealTimeRecommendationUpdateAdmin)
admin.site.register(SegmentBasedRecommendation, SegmentBasedRecommendationAdmin)
admin.site.register(FeedbackRecommendation, FeedbackRecommendationAdmin)
admin.site.register(RecommendationPerformanceAnalytics, RecommendationPerformanceAnalyticsAdmin)
admin.site.register(CustomerSpecificRecommendation, CustomerSpecificRecommendationAdmin)
