from django.urls import path, include

urlpatterns = [
    path('api/', include('OrderTracking.api.urls')),
]
