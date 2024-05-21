#!/bin/bash

APP_NAME="ProductManagement"
PROJECT_NAME="Khukumoni"
API_DIR="../$PROJECT_NAME/$APP_NAME/api"
VIEWS_FILE="$API_DIR/views.py"
URLS_FILE="$API_DIR/urls.py"
SERIALIZERS_FILE="$API_DIR/serializers.py"
SETTINGS_FILE="../$PROJECT_NAME/$PROJECT_NAME/settings.py"
PROJECT_URLS_FILE="../$PROJECT_NAME/$PROJECT_NAME/urls.py"
APP_URLS_FILE="../$PROJECT_NAME/$APP_NAME/urls.py"

# Step 1: Create the api folder and files
mkdir -p $API_DIR
touch $API_DIR/__init__.py

# Step 2: Create serializers.py
cat <<EOF > $SERIALIZERS_FILE
from rest_framework import serializers
from ..models import (
    Brand, Category, Product, Variant, Image, Video, Pricing, Discount
)

class BrandSerializer(serializers.ModelSerializer):
    class Meta:
        model = Brand
        fields = '__all__'

class CategorySerializer(serializers.ModelSerializer):
    class Meta:
        model = Category
        fields = '__all__'

class ProductSerializer(serializers.ModelSerializer):
    class Meta:
        model = Product
        fields = '__all__'

class VariantSerializer(serializers.ModelSerializer):
    class Meta:
        model = Variant
        fields = '__all__'

class ImageSerializer(serializers.ModelSerializer):
    class Meta:
        model = Image
        fields = '__all__'

class VideoSerializer(serializers.ModelSerializer):
    class Meta:
        model = Video
        fields = '__all__'

class PricingSerializer(serializers.ModelSerializer):
    class Meta:
        model = Pricing
        fields = '__all__'

class DiscountSerializer(serializers.ModelSerializer):
    class Meta:
        model = Discount
        fields = '__all__'
EOF

# Step 3: Create views.py
cat <<EOF > $VIEWS_FILE
from rest_framework import viewsets
from ..models import (
    Brand, Category, Product, Variant, Image, Video, Pricing, Discount
)
from .serializers import (
    BrandSerializer, CategorySerializer, ProductSerializer,
    VariantSerializer, ImageSerializer, VideoSerializer, PricingSerializer, DiscountSerializer
)

class BrandViewSet(viewsets.ModelViewSet):
    queryset = Brand.objects.all()
    serializer_class = BrandSerializer

class CategoryViewSet(viewsets.ModelViewSet):
    queryset = Category.objects.all()
    serializer_class = CategorySerializer

class ProductViewSet(viewsets.ModelViewSet):
    queryset = Product.objects.all()
    serializer_class = ProductSerializer

class VariantViewSet(viewsets.ModelViewSet):
    queryset = Variant.objects.all()
    serializer_class = VariantSerializer

class ImageViewSet(viewsets.ModelViewSet):
    queryset = Image.objects.all()
    serializer_class = ImageSerializer

class VideoViewSet(viewsets.ModelViewSet):
    queryset = Video.objects.all()
    serializer_class = VideoSerializer

class PricingViewSet(viewsets.ModelViewSet):
    queryset = Pricing.objects.all()
    serializer_class = PricingSerializer

class DiscountViewSet(viewsets.ModelViewSet):
    queryset = Discount.objects.all()
    serializer_class = DiscountSerializer
EOF

# Step 4: Create urls.py
cat <<EOF > $URLS_FILE
from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import (
    BrandViewSet, CategoryViewSet, ProductViewSet,
    VariantViewSet, ImageViewSet, VideoViewSet, PricingViewSet, DiscountViewSet
)

router = DefaultRouter()
router.register(r'brands', BrandViewSet)
router.register(r'categories', CategoryViewSet)
router.register(r'products', ProductViewSet)
router.register(r'variants', VariantViewSet)
router.register(r'images', ImageViewSet)
router.register(r'videos', VideoViewSet)
router.register(r'pricings', PricingViewSet)
router.register(r'discounts', DiscountViewSet)

urlpatterns = [
    path('', include(router.urls)),
]
EOF

# Step 5: Ensure the main project urls.py file exists and include the api urls
if [ ! -f "$APP_URLS_FILE" ]; then
    # Create the main urls.py if it does not exist
    cat <<EOF > $APP_URLS_FILE
from django.urls import path, include

urlpatterns = [
    path('api/', include('$APP_NAME.api.urls')),
]
EOF
else
    # Add the api path if it's not already included
    if ! grep -q "path('api/', include('$APP_NAME.api.urls'))" "$APP_URLS_FILE"; then
        sed -i "/urlpatterns = \[/a \ \ \ \ path('api/', include('$APP_NAME.api.urls'))," $APP_URLS_FILE
    fi
fi

# Step 6: Add the app path to the main project urls.py if not already included
if ! grep -q "path('$APP_NAME/', include('$APP_NAME.urls'))" "$PROJECT_URLS_FILE"; then
    sed -i "/urlpatterns = \[/a \ \ \ \ path('$APP_NAME/', include('$APP_NAME.urls'))," $PROJECT_URLS_FILE
fi

echo "API setup for ProductManagement completed successfully."

