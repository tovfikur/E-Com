from django.urls import path, include

urlpatterns = [
    path('api/', include('SocialShare.api.urls')),
]
