from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import (
    ShippingAddressViewSet, ShippingLabelViewSet, PackageTrackingViewSet,
    ShippingCarrierViewSet, ShippingInsuranceViewSet, ShippingZoneViewSet,
    ShippingPreferenceViewSet, ShippingNotificationViewSet, DeliveryScheduleViewSet,
    LocationViewSet, ShippingCostViewSet, ShippingRestrictionViewSet, OrderRestrictionViewSet
)

router = DefaultRouter()
router.register(r'shipping_address', ShippingAddressViewSet)
router.register(r'shipping_label', ShippingLabelViewSet)
router.register(r'package_tracking', PackageTrackingViewSet)
router.register(r'shipping_carrier', ShippingCarrierViewSet)
router.register(r'shipping_insurance', ShippingInsuranceViewSet)
router.register(r'shipping_zone', ShippingZoneViewSet)
router.register(r'shipping_preference', ShippingPreferenceViewSet)
router.register(r'shipping_notification', ShippingNotificationViewSet)
router.register(r'delivery_schedule', DeliveryScheduleViewSet)
router.register(r'location', LocationViewSet)
router.register(r'shipping_cost', ShippingCostViewSet)
router.register(r'shipping_restriction', ShippingRestrictionViewSet)
router.register(r'order_restriction', OrderRestrictionViewSet)

urlpatterns = [
    path('', include(router.urls)),
]
