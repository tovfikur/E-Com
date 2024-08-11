from django.contrib import admin
from .models import OrderTracking, TrackingUpdates, DeliveryRoutes, ProofOfDelivery, DeliveryNotifications, DeliveryIssues, CarrierIntegration, DeliveryHistory, DeliverySignatures

class OrderTrackingAdmin(admin.ModelAdmin):
    list_display = ('order_id', 'current_status', 'estimated_delivery_date', 'real_time_tracking_url', 'created_at', 'updated_at')
    search_fields = ('order_id', 'current_status')

class TrackingUpdatesAdmin(admin.ModelAdmin):
    list_display = ('update_id', 'order_id', 'status_update', 'timestamp', 'location', 'created_at', 'updated_at')
    search_fields = ('order_id', 'status_update')

class DeliveryRoutesAdmin(admin.ModelAdmin):
    list_display = ('route_id', 'order_id', 'route_details', 'map_url', 'created_at', 'updated_at')
    search_fields = ('order_id', 'route_details')

class ProofOfDeliveryAdmin(admin.ModelAdmin):
    list_display = ('pod_id', 'order_id', 'pod_details', 'pod_file_url', 'uploaded_at', 'created_at', 'updated_at')
    search_fields = ('order_id', 'pod_details')

class DeliveryNotificationsAdmin(admin.ModelAdmin):
    list_display = ('notification_id', 'order_id', 'notification_type', 'sent_at', 'created_at', 'updated_at')
    search_fields = ('order_id', 'notification_type')

class DeliveryIssuesAdmin(admin.ModelAdmin):
    list_display = ('issue_id', 'order_id', 'issue_description', 'reported_at', 'status', 'resolved_at', 'created_at', 'updated_at')
    search_fields = ('order_id', 'issue_description')

class CarrierIntegrationAdmin(admin.ModelAdmin):
    list_display = ('carrier_id', 'carrier_name', 'tracking_url', 'created_at', 'updated_at')
    search_fields = ('carrier_name',)

class DeliveryHistoryAdmin(admin.ModelAdmin):
    list_display = ('history_id', 'order_id', 'event_details', 'event_timestamp', 'created_at', 'updated_at')
    search_fields = ('order_id', 'event_details')

class DeliverySignaturesAdmin(admin.ModelAdmin):
    list_display = ('signature_id', 'order_id', 'signature_url', 'uploaded_at', 'created_at', 'updated_at')
    search_fields = ('order_id',)

admin.site.register(OrderTracking, OrderTrackingAdmin)
admin.site.register(TrackingUpdates, TrackingUpdatesAdmin)
admin.site.register(DeliveryRoutes, DeliveryRoutesAdmin)
admin.site.register(ProofOfDelivery, ProofOfDeliveryAdmin)
admin.site.register(DeliveryNotifications, DeliveryNotificationsAdmin)
admin.site.register(DeliveryIssues, DeliveryIssuesAdmin)
admin.site.register(CarrierIntegration, CarrierIntegrationAdmin)
admin.site.register(DeliveryHistory, DeliveryHistoryAdmin)
admin.site.register(DeliverySignatures, DeliverySignaturesAdmin)
