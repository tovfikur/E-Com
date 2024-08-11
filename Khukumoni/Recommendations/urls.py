from django.urls import path, include

urlpatterns = [
    path('api/', include('Recommendations.api.urls')),
]
