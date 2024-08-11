from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import *

router = DefaultRouter()

# Register viewsets for each model

urlpatterns = [
    path('', include(router.urls)),
]
