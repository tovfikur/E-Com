from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import (
    GiftCardsViewSet, GiftCardTransactionsViewSet,
    GiftCardNotificationsViewSet, POSIntegrationConfigurationViewSet,
    GiftCardRedemptionOptionsViewSet, GiftCardCustomizationOptionsViewSet
)

router = DefaultRouter()
router.register(r'gift_cards', GiftCardsViewSet)
router.register(r'gift_card_transactions', GiftCardTransactionsViewSet)
router.register(r'gift_card_notifications', GiftCardNotificationsViewSet)
router.register(r'pos_integration_configuration', POSIntegrationConfigurationViewSet)
router.register(r'gift_card_redemption_options', GiftCardRedemptionOptionsViewSet)
router.register(r'gift_card_customization_options', GiftCardCustomizationOptionsViewSet)

urlpatterns = [
    path('', include(router.urls)),
]
