from rest_framework import viewsets
from ..models import ( OrderTracking, TrackingUpdates, DeliveryRoutes, ProofOfDelivery, DeliveryNotifications,
DeliveryIssues, CarrierIntegration, DeliveryHistory, DeliverySignatures )
from .serializers import (
    DeliveryHistorySerializer,
    DeliveryIssuesSerializer,
    DeliveryNotificationsSerializer,
    DeliveryRoutesSerializer,
    DeliverySignaturesSerializer,
    OrderTrackingSerializer,
    ProofOfDeliverySerializer,
    TrackingUpdatesSerializer,
    CarrierIntegrationSerializer
)

class OrderTrackingViewSet(viewsets.ModelViewSet):
    queryset = OrderTracking.objects.all()
    serializer_class = OrderTrackingSerializer

class TrackingUpdatesViewSet(viewsets.ModelViewSet):
    queryset = TrackingUpdates.objects.all()
    serializer_class = TrackingUpdatesSerializer

class DeliveryRoutesViewSet(viewsets.ModelViewSet):
    queryset = DeliveryRoutes.objects.all()
    serializer_class = DeliveryRoutesSerializer

class ProofOfDeliveryViewSet(viewsets.ModelViewSet):
    queryset = ProofOfDelivery.objects.all()
    serializer_class = ProofOfDeliverySerializer

class DeliveryNotificationsViewSet(viewsets.ModelViewSet):
    queryset = DeliveryNotifications.objects.all()
    serializer_class = DeliveryNotificationsSerializer

class DeliveryIssuesViewSet(viewsets.ModelViewSet):
    queryset = DeliveryIssues.objects.all()
    serializer_class = DeliveryIssuesSerializer

class CarrierIntegrationViewSet(viewsets.ModelViewSet):
    queryset = CarrierIntegration.objects.all()
    serializer_class = CarrierIntegrationSerializer

class DeliveryHistoryViewSet(viewsets.ModelViewSet):
    queryset = DeliveryHistory.objects.all()
    serializer_class = DeliveryHistorySerializer

class DeliverySignaturesViewSet(viewsets.ModelViewSet):
    queryset = DeliverySignatures.objects.all()
    serializer_class = DeliverySignaturesSerializer
