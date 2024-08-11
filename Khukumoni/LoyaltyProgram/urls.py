from django.urls import path, include

urlpatterns = [
    path('api/', include('LoyaltyProgram.api.urls')),
]
