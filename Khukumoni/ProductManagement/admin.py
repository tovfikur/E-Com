from django.contrib import admin
from django import forms
from django.core.exceptions import ValidationError
from django_currentuser.middleware import get_current_authenticated_user
from UserManagement.mixins import UserFilteredAdminMixin
from .models import Brand, Category, Product, Variant, Media, Pricing, Discount



class MediaAdminForm(forms.ModelForm):
    class Meta:
        model = Media
        fields = ['file', 'url']

    def clean(self):
        cleaned_data = super().clean()
        file = cleaned_data.get('file')
        url = cleaned_data.get('url')

        if not file and not url:
            raise ValidationError("You must provide either a file or a URL.")

        return cleaned_data


class ProductAdminForm(forms.ModelForm):
    class Meta:
        model = Product
        fields = ['name', 'description', 'brand', 'category', 'status']

    def __init__(self, *args, **kwargs):
        user = get_current_authenticated_user()
        super().__init__(*args, **kwargs)
        if user:
            self.fields['brand'].queryset = Brand.objects.filter(user=user)
            self.fields['category'].queryset = Category.objects.filter(user=user)



class MediaInline(admin.TabularInline):
    model = Media
    form = MediaAdminForm
    extra = 1


class VariantInline(admin.TabularInline):
    model = Variant
    extra = 1


class PricingInline(admin.TabularInline):
    model = Pricing
    extra = 1


class DiscountInline(admin.TabularInline):
    model = Discount
    extra = 1


class ProductAdmin(UserFilteredAdminMixin, admin.ModelAdmin):
    form = ProductAdminForm
    list_display = ('user','name', 'description', 'brand', 'category', 'status')
    search_fields = ('name',)
    list_filter = ('brand', 'category')
    inlines = [PricingInline, VariantInline, MediaInline, DiscountInline]

    fieldsets = (
        (None, {
            'fields': ('name', 'description', 'brand', 'category', 'status')
        }),
    )


    def get_form(self, request, obj=None, **kwargs):
        form = super().get_form(request, obj, **kwargs)
        form.user = request.user
        return form
    

class BrandAdminForm(forms.ModelForm):
    class Meta:
        model = Brand
        fields = ['name', 'description']

    def __init__(self, *args, **kwargs):
        user = kwargs.pop('user', None)
        super().__init__(*args, **kwargs)
        if user:
            self.fields['brand'].queryset = Brand.objects.filter(user=user)

class BrandAdmin(UserFilteredAdminMixin, admin.ModelAdmin):
    form = BrandAdminForm
    list_display = ('name', 'description')
    search_fields = ('name',)

    def get_form(self, request, obj=None, **kwargs):
        kwargs['form'] = BrandAdminForm
        form = super().get_form(request, obj, **kwargs)
        form.user = request.user
        return form




class CategoryAdminForm(forms.ModelForm):
    class Meta:
        model = Category
        fields = ['name', 'description', 'brand']

    def __init__(self, *args, **kwargs):
        user = kwargs.pop('user', None)
        super().__init__(*args, **kwargs)
        if user:
            self.fields['brand'].queryset = Brand.objects.filter(user=user)

class CategoryAdmin(UserFilteredAdminMixin, admin.ModelAdmin):
    form = CategoryAdminForm
    list_display = ('name', 'description', 'brand')
    search_fields = ('name',)
    list_filter = ('brand',)

    def get_form(self, request, obj=None, **kwargs):
        kwargs['form'] = CategoryAdminForm
        form = super().get_form(request, obj, **kwargs)
        form.user = request.user
        return form



admin.site.register(Brand, BrandAdmin)
admin.site.register(Category, CategoryAdmin)
admin.site.register(Product, ProductAdmin)
