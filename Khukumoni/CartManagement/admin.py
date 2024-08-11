from django.contrib import admin
from .models import Cart, CartItem, CartDiscount, CartSharing, CartSaveForLater

@admin.register(Cart)
class CartAdmin(admin.ModelAdmin):
    list_display = ('id', 'user', 'created_at', 'updated_at')
    search_fields = ('user__username',)
    list_filter = ('created_at', 'updated_at')

@admin.register(CartItem)
class CartItemAdmin(admin.ModelAdmin):
    list_display = ('id', 'cart', 'product', 'quantity', 'price', 'created_at', 'updated_at')
    search_fields = ('cart__user__username', 'product__name')
    list_filter = ('created_at', 'updated_at')

@admin.register(CartDiscount)
class CartDiscountAdmin(admin.ModelAdmin):
    list_display = ('id', 'cart', 'discount_code', 'discount_amount', 'created_at', 'updated_at')
    search_fields = ('cart__user__username', 'discount_code')
    list_filter = ('created_at', 'updated_at')

@admin.register(CartSharing)
class CartSharingAdmin(admin.ModelAdmin):
    list_display = ('id', 'cart', 'shared_with_user', 'status', 'created_at', 'updated_at')
    search_fields = ('cart__user__username', 'shared_with_user__username')
    list_filter = ('created_at', 'updated_at', 'status')

@admin.register(CartSaveForLater)
class CartSaveForLaterAdmin(admin.ModelAdmin):
    list_display = ('id', 'user', 'product', 'created_at', 'updated_at')
    search_fields = ('user__username', 'product__name')
    list_filter = ('created_at', 'updated_at')
