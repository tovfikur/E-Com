from django.urls import path, include

urlpatterns = [
    path('api/', include('PaymentProcessing.api.urls')),
]
