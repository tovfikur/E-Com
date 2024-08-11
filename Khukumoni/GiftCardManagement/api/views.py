from rest_framework import viewsets
from ..models import GiftCards, GiftCardTransactions, GiftCardNotifications, POSIntegrationConfiguration,     GiftCardRedemptionOptions, GiftCardCustomizationOptions
from .serializers import (
    GiftCardsSerializer, GiftCardTransactionsSerializer,
    GiftCardNotificationsSerializer, POSIntegrationConfigurationSerializer,
    GiftCardRedemptionOptionsSerializer, GiftCardCustomizationOptionsSerializer
)

class GiftCardsViewSet(viewsets.ModelViewSet):
    queryset = GiftCards.objects.all()
    serializer_class = GiftCardsSerializer

class GiftCardTransactionsViewSet(viewsets.ModelViewSet):
    queryset = GiftCardTransactions.objects.all()
    serializer_class = GiftCardTransactionsSerializer

class GiftCardNotificationsViewSet(viewsets.ModelViewSet):
    queryset = GiftCardNotifications.objects.all()
    serializer_class = GiftCardNotificationsSerializer

class POSIntegrationConfigurationViewSet(viewsets.ModelViewSet):
    queryset = POSIntegrationConfiguration.objects.all()
    serializer_class = POSIntegrationConfigurationSerializer

class GiftCardRedemptionOptionsViewSet(viewsets.ModelViewSet):
    queryset = GiftCardRedemptionOptions.objects.all()
    serializer_class = GiftCardRedemptionOptionsSerializer

class GiftCardCustomizationOptionsViewSet(viewsets.ModelViewSet):
    queryset = GiftCardCustomizationOptions.objects.all()
    serializer_class = GiftCardCustomizationOptionsSerializer
