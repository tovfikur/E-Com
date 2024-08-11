from django.urls import path, include

urlpatterns = [
    path('api/', include('AnalyticsAndReporting.api.urls')),
]
