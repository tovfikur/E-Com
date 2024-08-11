from rest_framework import serializers
from ..models import ( OrderTracking, TrackingUpdates, DeliveryRoutes, ProofOfDelivery, DeliveryNotifications, DeliveryIssues,
CarrierIntegration, DeliveryHistory, DeliverySignatures )

class OrderTrackingSerializer(serializers.ModelSerializer):
    class Meta:
        model = OrderTracking
        fields = '__all__'

class TrackingUpdatesSerializer(serializers.ModelSerializer):
    class Meta:
        model = TrackingUpdates
        fields = '__all__'

class DeliveryRoutesSerializer(serializers.ModelSerializer):
    class Meta:
        model = DeliveryRoutes
        fields = '__all__'

class ProofOfDeliverySerializer(serializers.ModelSerializer):
    class Meta:
        model = ProofOfDelivery
        fields = '__all__'

class DeliveryNotificationsSerializer(serializers.ModelSerializer):
    class Meta:
        model = DeliveryNotifications
        fields = '__all__'

class DeliveryIssuesSerializer(serializers.ModelSerializer):
    class Meta:
        model = DeliveryIssues
        fields = '__all__'

class CarrierIntegrationSerializer(serializers.ModelSerializer):
    class Meta:
        model = CarrierIntegration
        fields = '__all__'

class DeliveryHistorySerializer(serializers.ModelSerializer):
    class Meta:
        model = DeliveryHistory
        fields = '__all__'

class DeliverySignaturesSerializer(serializers.ModelSerializer):
    class Meta:
        model = DeliverySignatures
        fields = '__all__'
