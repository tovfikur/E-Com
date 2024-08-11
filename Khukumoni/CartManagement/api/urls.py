from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import ( CartViewSet, CartItemsViewSet, CartDiscountsViewSet, CartSaveForLaterViewSet,)

router = DefaultRouter()
router.register(r'cart', CartViewSet)
# router.register(r'cartitems', CartItemsViewSet)
# router.register(r'cartitemdetails', CartItemDetailsViewSet)
router.register(r'cartdiscounts', CartDiscountsViewSet)
# router.register(r'cartpromotions', CartPromotionsViewSet)
# router.register(r'cartitemnotes', CartItemNotesViewSet)
# router.register(r'cartsharing', CartSharingViewSet)
router.register(r'cartsaveforlater', CartSaveForLaterViewSet)
# router.register(r'cartpersistence', CartPersistenceViewSet)
# router.register(r'cartrecommendations', CartRecommendationsViewSet)
# router.register(r'cartrecovery', CartRecoveryViewSet)
# router.register(r'cartitemcustomization', CartItemCustomizationViewSet)
# router.register(r'cartitemsubscription', CartItemSubscriptionViewSet)

urlpatterns = [
    path('', include(router.urls)),
]
