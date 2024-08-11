from django.urls import path, include

urlpatterns = [
    path('api/', include('ShippingAndFulfillment.api.urls')),
]
