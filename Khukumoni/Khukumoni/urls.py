"""
URL configuration for Khukumoni project.

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/5.0/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path
from django.urls import include
from rest_framework_simplejwt.views import TokenObtainPairView, TokenRefreshView
from django.conf import settings
from django.conf.urls.static import static

urlpatterns = [
    path('WishlistManagement/', include('WishlistManagement.urls')),
    path('SubscriptionManagement/', include('SubscriptionManagement.urls')),
    path('SocialShare/', include('SocialShare.urls')),
    path('ShippingAndFulfillment/', include('ShippingAndFulfillment.urls')),
    path('SearchAndFiltering/', include('SearchAndFiltering.urls')),
    path('ReviewsAndRatings/', include('ReviewsAndRatings.urls')),
    path('Recommendations/', include('Recommendations.urls')),
    path('ProductManagement/', include('ProductManagement.urls')),
    path('PaymentProcessing/', include('PaymentProcessing.urls')),
    path('OrderTracking/', include('OrderTracking.urls')),
    path('OrderManagement/', include('OrderManagement.urls')),
    path('MarketingAndPromotions/', include('MarketingAndPromotions.urls')),
    path('LoyaltyProgram/', include('LoyaltyProgram.urls')),
    path('InventoryManagement/', include('InventoryManagement.urls')),
    path('GiftCardManagement/', include('GiftCardManagement.urls')),
    path('CustomerSupport/', include('CustomerSupport.urls')),
    path('CustomerManagement/', include('CustomerManagement.urls')),
    path('CartManagement/', include('CartManagement.urls')),
    path('AnalyticsAndReporting/', include('AnalyticsAndReporting.urls')),
    path('api-auth/', include('rest_framework.urls')),
    path('api/token/', TokenObtainPairView.as_view(), name='token_obtain_pair'),
    path('api/token/refresh/', TokenRefreshView.as_view(), name='token_refresh'),
    path('admin/', admin.site.urls),
]

if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
    urlpatterns += static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)




admin.site.site_header = 'Khukumoni Administration'
admin.site.site_title = 'Khukumoni Admin Portal'
admin.site.index_title = 'Welcome to Khukumoni Admin Area'

