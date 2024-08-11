from django.db import models
from django.core.exceptions import ValidationError
from django.utils import timezone
from datetime import datetime
from django.conf import settings
from django_currentuser.db.models import CurrentUserField

class CommonInfo(models.Model):
    user = CurrentUserField()

    class Meta:
        abstract = True


class Brand(CommonInfo):
    name = models.CharField(max_length=255)
    description = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.name

class Category(CommonInfo):
    name = models.CharField(max_length=255)
    description = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    brand = models.ForeignKey(Brand, on_delete=models.CASCADE, null=True, blank=True)

    def __str__(self):
        return self.name

class Product(CommonInfo):
    name = models.CharField(max_length=255)
    description = models.TextField()
    brand = models.ForeignKey(Brand, on_delete=models.CASCADE)
    category = models.ForeignKey(Category, on_delete=models.CASCADE)
    status = models.CharField(max_length=255)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)


    @property
    def price(self):
        pricing = self.pricing_set.filter(effective_date__lte=timezone.now()).order_by('-effective_date').first()
        return pricing.price if pricing else None

    def __str__(self):
        return self.name

class Variant(models.Model):
    product = models.ForeignKey(Product, on_delete=models.CASCADE)
    name = models.CharField(max_length=255)
    price = models.DecimalField(max_digits=10, decimal_places=2)
    sku = models.CharField(max_length=255)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.name

class Media(CommonInfo):
    product = models.ForeignKey(Product, on_delete=models.CASCADE)
    file = models.FileField(upload_to='media/', null=True, blank=True)
    url = models.URLField(max_length=255, null=True, blank=True)
    created_at = models.DateTimeField(auto_now_add=True)
    
    def clean(self):
        if not self.file and not self.url:
            raise ValidationError("Either file or URL must be provided.")
        if self.file and self.url:
            raise ValidationError("Only one of file or URL can be provided.")


    def __str__(self):
        return self.url or str(self.file)

class Pricing(models.Model):
    product = models.ForeignKey(Product, on_delete=models.CASCADE)
    price = models.DecimalField(max_digits=10, decimal_places=2)
    effective_date = models.DateTimeField()

    def __str__(self):
        return f'{self.product.name} - {self.price}'

class Discount(models.Model):
    product = models.ForeignKey(Product, on_delete=models.CASCADE)
    discount_percentage = models.DecimalField(max_digits=5, decimal_places=2)
    start_date = models.DateTimeField()
    end_date = models.DateTimeField()

    def __str__(self):
        return f'{self.product.name} - {self.discount_percentage}%'
