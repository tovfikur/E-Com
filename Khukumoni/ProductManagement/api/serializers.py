from rest_framework import serializers
from ..models import Product, Variant, Media, Pricing, Discount, Brand, Category
from django.core.exceptions import ObjectDoesNotExist

class BrandSerializer(serializers.ModelSerializer):
    class Meta:
        model = Brand
        exclude = ('user',)

class CategorySerializer(serializers.ModelSerializer):
    class Meta:
        model = Category
        exclude = ('user',)

class MediaSerializer(serializers.ModelSerializer):
    class Meta:
        model = Media
        exclude = ('user',)

class PricingSerializer(serializers.ModelSerializer):
    class Meta:
        model = Pricing
        fields = ('price', 'effective_date')

class DiscountSerializer(serializers.ModelSerializer):
    class Meta:
        model = Discount
        fields = '__all__'

class VariantSerializer(serializers.ModelSerializer):
    class Meta:
        model = Variant
        fields = '__all__'

class ProductSerializer(serializers.ModelSerializer):
    brand = BrandSerializer()
    category = CategorySerializer()
    discounts = DiscountSerializer(many=True, read_only=True)

    class Meta:
        model = Product
        exclude = ('user',)

    def get_variants(self, instance):
        try:
            variants = Variant.objects.filter(product=instance)
            serializer = VariantSerializer(variants, many=True)
            return serializer.data
        except ObjectDoesNotExist:
            return []

    def get_media(self, instance):
        try:
            media = Media.objects.filter(product=instance)
            serializer = MediaSerializer(media, many=True)
            return serializer.data
        except ObjectDoesNotExist:
            return []

    def get_latest_pricing(self, instance):
        try:
            latest_pricing = Pricing.objects.filter(product=instance).latest('effective_date')
            serializer = PricingSerializer(latest_pricing)
            return serializer.data
        except ObjectDoesNotExist:
            return {}

    def get_latest_discount(self, instance):
        try:
            latest_discount = Discount.objects.filter(product=instance).latest('start_date')
            serializer = DiscountSerializer(latest_discount)
            return serializer.data
        except ObjectDoesNotExist:
            return {}

    def to_representation(self, instance):
        representation = super().to_representation(instance)
        representation['variants'] = self.get_variants(instance)
        representation['media'] = self.get_media(instance)
        representation['latest_pricing'] = self.get_latest_pricing(instance)
        representation['latest_discount'] = self.get_latest_discount(instance)
        return representation
