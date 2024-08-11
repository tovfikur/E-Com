from django.urls import path, include

urlpatterns = [
    path('api/', include('WishlistManagement.api.urls')),
]
