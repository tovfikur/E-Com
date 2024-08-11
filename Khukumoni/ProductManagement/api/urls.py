from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import (
    BrandViewSet, CategoryViewSet, ProductViewSet, MediaViewSet, PricingViewSet, DiscountViewSet
)

router = DefaultRouter()
router.register(r'brands', BrandViewSet)
router.register(r'categories', CategoryViewSet)
router.register(r'products', ProductViewSet, basename='product')
# router.register(r'images', MediaViewSet)
# router.register(r'pricings', PricingViewSet)
# router.register(r'discounts', DiscountViewSet)

urlpatterns = [
    path('', include(router.urls)),
]
