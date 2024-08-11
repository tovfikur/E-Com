from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import OrderTrackingViewSet

router = DefaultRouter()
router.register(r'order_tracking', OrderTrackingViewSet)

urlpatterns = [
    path('', include(router.urls)),
]
