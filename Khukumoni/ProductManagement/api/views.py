from rest_framework import viewsets
from UserManagement.utils import get_domain_from_request
from ..models import (
    Brand, Category, Product, Media, Pricing, Discount
)
from .serializers import (
    BrandSerializer, CategorySerializer, ProductSerializer, MediaSerializer, PricingSerializer, DiscountSerializer
)

from UserManagement.permissions import IsDomainAndUserPermitted

class BrandViewSet(viewsets.ModelViewSet):
    queryset = Brand.objects.all()
    serializer_class = BrandSerializer

    def get_queryset(self):
        return self.queryset.filter(user__domain=get_domain_from_request(self.request)) 
    

class CategoryViewSet(viewsets.ModelViewSet):
    queryset = Category.objects.all()
    serializer_class = CategorySerializer
     
    def get_queryset(self):
        return self.queryset.filter(user__domain=get_domain_from_request(self.request)) 


class ProductViewSet(viewsets.ModelViewSet):
    queryset = Product.objects.all()
    serializer_class = ProductSerializer
    permission_classes = [IsDomainAndUserPermitted]

    def get_queryset(self):
        return self.queryset.filter(user__domain=get_domain_from_request(self.request)) 



class MediaViewSet(viewsets.ModelViewSet):
    queryset = Media.objects.all()
    serializer_class = MediaSerializer

class PricingViewSet(viewsets.ModelViewSet):
    queryset = Pricing.objects.all()
    serializer_class = PricingSerializer

class DiscountViewSet(viewsets.ModelViewSet):
    queryset = Discount.objects.all()
    serializer_class = DiscountSerializer
