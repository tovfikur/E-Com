#!/bin/bash

APP_NAME="CartManagement"
PROJECT_NAME="Khukumoni"
API_DIR="../$PROJECT_NAME/$APP_NAME/api"
VIEWS_FILE="$API_DIR/views.py"
URLS_FILE="$API_DIR/urls.py"
SERIALIZERS_FILE="$API_DIR/serializers.py"
SETTINGS_FILE="../$PROJECT_NAME/$PROJECT_NAME/settings.py"
PROJECT_URLS_FILE="../$PROJECT_NAME/$PROJECT_NAME/urls.py"
APP_URLS_FILE="../$PROJECT_NAME/$APP_NAME/urls.py"

# Create the api folder and files
mkdir -p $API_DIR
touch $API_DIR/__init__.py

# Create serializers.py
cat <<EOF > $SERIALIZERS_FILE
from rest_framework import serializers
from ..models import (
    Cart, CartItems, CartItemDetails, CartDiscounts, CartPromotions, CartItemNotes,
    CartSharing, CartSaveForLater, CartExpiration, CartPersistence, CartRecommendations,
    CartRecovery, CartItemCustomization, CartItemSubscription
)

class CartSerializer(serializers.ModelSerializer):
    class Meta:
        model = Cart
        fields = '__all__'

class CartItemsSerializer(serializers.ModelSerializer):
    class Meta:
        model = CartItems
        fields = '__all__'

class CartItemDetailsSerializer(serializers.ModelSerializer):
    class Meta:
        model = CartItemDetails
        fields = '__all__'

class CartDiscountsSerializer(serializers.ModelSerializer):
    class Meta:
        model = CartDiscounts
        fields = '__all__'

class CartPromotionsSerializer(serializers.ModelSerializer):
    class Meta:
        model = CartPromotions
        fields = '__all__'

class CartItemNotesSerializer(serializers.ModelSerializer):
    class Meta:
        model = CartItemNotes
        fields = '__all__'

class CartSharingSerializer(serializers.ModelSerializer):
    class Meta:
        model = CartSharing
        fields = '__all__'

class CartSaveForLaterSerializer(serializers.ModelSerializer):
    class Meta:
        model = CartSaveForLater
        fields = '__all__'

class CartExpirationSerializer(serializers.ModelSerializer):
    class Meta:
        model = CartExpiration
        fields = '__all__'

class CartPersistenceSerializer(serializers.ModelSerializer):
    class Meta:
        model = CartPersistence
        fields = '__all__'

class CartRecommendationsSerializer(serializers.ModelSerializer):
    class Meta:
        model = CartRecommendations
        fields = '__all__'

class CartRecoverySerializer(serializers.ModelSerializer):
    class Meta:
        model = CartRecovery
        fields = '__all__'

class CartItemCustomizationSerializer(serializers.ModelSerializer):
    class Meta:
        model = CartItemCustomization
        fields = '__all__'

class CartItemSubscriptionSerializer(serializers.ModelSerializer):
    class Meta:
        model = CartItemSubscription
        fields = '__all__'
EOF

# Create views.py
cat <<EOF > $VIEWS_FILE
from rest_framework import viewsets
from ..models import (
    Cart, CartItems, CartItemDetails, CartDiscounts, CartPromotions, CartItemNotes,
    CartSharing, CartSaveForLater, CartExpiration, CartPersistence, CartRecommendations,
    CartRecovery, CartItemCustomization, CartItemSubscription
)
from .serializers import (
    CartSerializer, CartItemsSerializer, CartItemDetailsSerializer, CartDiscountsSerializer,
    CartPromotionsSerializer, CartItemNotesSerializer, CartSharingSerializer, CartSaveForLaterSerializer,
    CartExpirationSerializer, CartPersistenceSerializer, CartRecommendationsSerializer, CartRecoverySerializer,
    CartItemCustomizationSerializer, CartItemSubscriptionSerializer
)

# Define viewsets for each model
class CartViewSet(viewsets.ModelViewSet):
    queryset = Cart.objects.all()
    serializer_class = CartSerializer

class CartItemsViewSet(viewsets.ModelViewSet):
    queryset = CartItems.objects.all()
    serializer_class = CartItemsSerializer
 
class CartItemDetailsViewSet(viewsets.ModelViewSet):
    queryset = CartItemDetails.objects.all()
    serializer_class = CartItemDetailsSerializer

class CartDiscountsViewSet(viewsets.ModelViewSet):
    queryset = CartDiscounts.objects.all()
    serializer_class = CartDiscountsSerializer

class CartPromotionsViewSet(viewsets.ModelViewSet):
    queryset = CartPromotions.objects.all()
    serializer_class = CartPromotionsSerializer

class CartItemNotesViewSet(viewsets.ModelViewSet):
    queryset = CartItemNotes.objects.all()
    serializer_class = CartItemNotesSerializer

class CartSharingViewSet(viewsets.ModelViewSet):
    queryset = CartSharing.objects.all()
    serializer_class = CartSharingSerializer

class CartSaveForLaterViewSet(viewsets.ModelViewSet):
    queryset = CartSaveForLater.objects.all()
    serializer_class = CartSaveForLaterSerializer

class CartExpirationViewSet(viewsets.ModelViewSet):
    queryset = CartExpiration.objects.all()
    serializer_class = CartExpirationSerializer

class CartPersistenceViewSet(viewsets.ModelViewSet):
    queryset = CartPersistence.objects.all()
    serializer_class = CartPersistenceSerializer

class CartRecommendationsViewSet(viewsets.ModelViewSet):
    queryset = CartRecommendations.objects.all()
    serializer_class = CartRecommendationsSerializer

class CartRecoveryViewSet(viewsets.ModelViewSet):
    queryset = CartRecovery.objects.all()
    serializer_class = CartRecoverySerializer

class CartItemCustomizationViewSet(viewsets.ModelViewSet):
    queryset = CartItemCustomization.objects.all()
    serializer_class = CartItemCustomizationSerializer

class CartItemSubscriptionViewSet(viewsets.ModelViewSet):
    queryset = CartItemSubscription.objects.all()
    serializer_class = CartItemSubscriptionSerializer

EOF

# Create urls.py
cat <<EOF > $URLS_FILE
from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import (
    CartViewSet, CartItemsViewSet, CartItemDetailsViewSet, CartDiscountsViewSet, CartPromotionsViewSet,
    CartItemNotesViewSet, CartSharingViewSet, CartSaveForLaterViewSet, CartExpirationViewSet,
    CartPersistenceViewSet, CartRecommendationsViewSet, CartRecoveryViewSet, CartItemCustomizationViewSet,
    CartItemSubscriptionViewSet
)

router = DefaultRouter()
router.register(r'cart', CartViewSet)
router.register(r'cartitems', CartItemsViewSet)
router.register(r'cartitemdetails', CartItemDetailsViewSet)
router.register(r'cartdiscounts', CartDiscountsViewSet)
router.register(r'cartpromotions', CartPromotionsViewSet)
router.register(r'cartitemnotes', CartItemNotesViewSet)
router.register(r'cartsharing', CartSharingViewSet)
router.register(r'cartsaveforlater', CartSaveForLaterViewSet)
router.register(r'cartpersistence', CartPersistenceViewSet)
router.register(r'cartrecommendations', CartRecommendationsViewSet)
router.register(r'cartrecovery', CartRecoveryViewSet)
router.register(r'cartitemcustomization', CartItemCustomizationViewSet)
router.register(r'cartitemsubscription', CartItemSubscriptionViewSet)

urlpatterns = [
    path('', include(router.urls)),
]
EOF

# Ensure the main project urls.py file exists and include the api urls
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

# Add the app path to the main project urls.py if not already included
if ! grep -q "path('$APP_NAME/', include('$APP_NAME.urls'))" "$PROJECT_URLS_FILE"; then
    sed -i "/urlpatterns = \[/a \ \ \ \ path('$APP_NAME/', include('$APP_NAME.urls'))," $PROJECT_URLS_FILE
fi

echo "API setup for $APP_NAME completed successfully."
