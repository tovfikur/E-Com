from rest_framework import serializers
from ProductManagement.models import Product
from ProductManagement.api.serializers import ProductSerializer
from ..models import (
    Cart, CartItem, CartDiscount, CartSharing, CartSaveForLater)


class CartItemsSerializer(serializers.ModelSerializer):
    product = ProductSerializer()
    class Meta:
        model = CartItem
        depth = 1
        # exclude = ['cart']
        fields = ['id', 'quantity', 'price', 'created_at', 'updated_at', 'product']


class CartSerializer(serializers.ModelSerializer):
    cart_items = CartItemsSerializer(many=True, read_only=True, source='cartitem_set')
    product_id = serializers.IntegerField(write_only=True)
    quantity = serializers.IntegerField(write_only=True)

    class Meta:
        model = Cart
        fields = ['id', 'user', 'session_key', 'created_at', 'updated_at', 'cart_items', 'product_id', 'quantity']

    def create(self, validated_data):
        product_id = validated_data.pop('product_id')
        quantity = validated_data.pop('quantity')

        product = Product.objects.get(id=product_id)
        request = self.context.get('request')

        cart = Cart.objects.get_or_create_cart(request)
        
        cart_item, created = CartItem.objects.get_or_create(
            cart=cart,
            product=product,
            defaults={'quantity': quantity, 'price': product.price}
        )

        if not created:
            cart_item.quantity += quantity
            cart_item.save()

        return cart

# class CartItemDetailsSerializer(serializers.ModelSerializer):
#     class Meta:
#         model = CartItemDetail
#         fields = '__all__'

class CartDiscountsSerializer(serializers.ModelSerializer):
    class Meta:
        model = CartDiscount
        fields = '__all__'

# class CartPromotionsSerializer(serializers.ModelSerializer):
#     class Meta:
#         model = CartPromotion
#         fields = '__all__'

# class CartItemNotesSerializer(serializers.ModelSerializer):
#     class Meta:
#         model = CartItemNote
#         fields = '__all__'

class CartSharingSerializer(serializers.ModelSerializer):
    class Meta:
        model = CartSharing
        fields = '__all__'

class CartSaveForLaterSerializer(serializers.ModelSerializer):
    class Meta:
        model = CartSaveForLater
        fields = '__all__'

# class CartExpirationSerializer(serializers.ModelSerializer):
#     class Meta:
#         model = CartExpiration
#         fields = '__all__'

# class CartPersistenceSerializer(serializers.ModelSerializer):
#     class Meta:
#         model = CartPersistence
#         fields = '__all__'

# class CartRecommendationsSerializer(serializers.ModelSerializer):
#     class Meta:
#         model = CartRecommendation
#         fields = '__all__'

# class CartRecoverySerializer(serializers.ModelSerializer):
#     class Meta:
#         model = CartRecovery
#         fields = '__all__'

# class CartItemCustomizationSerializer(serializers.ModelSerializer):
#     class Meta:
#         model = CartItemCustomization
#         fields = '__all__'

# class CartItemSubscriptionSerializer(serializers.ModelSerializer):
#     class Meta:
#         model = CartItemSubscription
#         fields = '__all__'
