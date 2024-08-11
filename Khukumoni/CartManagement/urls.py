from django.urls import path, include

urlpatterns = [
    path('api/', include('CartManagement.api.urls')),
]
