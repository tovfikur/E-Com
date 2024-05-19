#!/bin/bash

# Step 1: Create a Python virtual environment
python3 -m venv khukumoni_env

# Step 2: Activate the virtual environment
source khukumoni_env/bin/activate

# Step 3: Install necessary packages
pip install django djangorestframework djangorestframework-simplejwt django-cors-headers

# Step 4: Create a Django project named Khukumoni
django-admin startproject Khukumoni

# Navigate to the project directory
cd Khukumoni

# Step 5: Update Django project settings
SETTINGS_FILE="Khukumoni/settings.py"


# Add 'rest_framework' and 'corsheaders' to INSTALLED_APPS in settings.py
sed -i "/INSTALLED_APPS = \[/a \ \ \ \ 'rest_framework',\n\ \ \ \ 'rest_framework_simplejwt',\n\ \ \ \ 'corsheaders'," $SETTINGS_FILE


# Insert the import statements for static and media settings after existing imports
IMPORT_INSERT_LINE=$(grep -n "from pathlib import Path" "$SETTINGS_FILE" | cut -d: -f1)
if ! grep -q "from django.conf import settings" "$SETTINGS_FILE"; then
    sed -i "${IMPORT_INSERT_LINE}a import os" "$SETTINGS_FILE"
fi

# adding additional settings. 
echo "
# Added for JWT authentication
REST_FRAMEWORK = {
    'DEFAULT_AUTHENTICATION_CLASSES': [
        'rest_framework_simplejwt.authentication.JWTAuthentication',
    ],
}

# CORS settings
CORS_ALLOW_ALL_ORIGINS = True

# Static files settings
STATIC_URL = '/static/'
STATIC_ROOT = os.path.join(BASE_DIR, 'staticfiles')
STATICFILES_DIRS = [os.path.join(BASE_DIR, 'static')]

# Media files settings
MEDIA_URL = '/media/'
MEDIA_ROOT = os.path.join(BASE_DIR, 'media')
" >> $SETTINGS_FILE

# Add middleware for CORS
sed -i "/MIDDLEWARE = \[/a\ \ \ \ 'corsheaders.middleware.CorsMiddleware'," $SETTINGS_FILE

# Step 6: Update URL patterns for static and media files
URLS_FILE="Khukumoni/urls.py"


# Insert the import statements for static and media settings after existing imports
IMPORT_INSERT_LINE=$(grep -n "from django.urls import path" "$URLS_FILE" | cut -d: -f1)
if ! grep -q "from django.conf import settings" "$URLS_FILE"; then
    sed -i "${IMPORT_INSERT_LINE}a from django.conf import settings\nfrom django.conf.urls.static import static" "$URLS_FILE"
fi


# Adding static and media URL patterns
echo "
if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
    urlpatterns += static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)
" >> $URLS_FILE


# Add JWT and REST framework URL patterns
URLPATTERNS_INSERT_LINE=$(grep -n "urlpatterns = \[" "$URLS_FILE" | cut -d: -f1)
if ! grep -q "from rest_framework import routers" "$URLS_FILE"; then
    sed -i "${IMPORT_INSERT_LINE}a from django.urls import include\nfrom rest_framework_simplejwt.views import TokenObtainPairView, TokenRefreshView" "$URLS_FILE"
fi

# Append URL patterns for REST framework and JWT
# Find the line with 'urlpatterns =' and append the new paths
sed -i "/urlpatterns = \[/a \ \ \ \ path('api-auth/', include('rest_framework.urls')),\n\ \ \ \ path('api/token/', TokenObtainPairView.as_view(), name='token_obtain_pair'),\n\ \ \ \ path('api/token/refresh/', TokenRefreshView.as_view(), name='token_refresh')," "$URLS_FILE"


python manage.py migrate
echo "from django.contrib.auth.models import User; User.objects.create_superuser('admin', 'admin@localhost', 'admin')" | python manage.py shell
























## Product Management App ##

# Step 1: Create Django app
python manage.py startapp ProductManagement
sed -i "/INSTALLED_APPS = \[/a \ \ \ \ 'ProductManagement'," $SETTINGS_FILE

# Step 2: Create Django models for each table

# Product model
cat <<EOF > ProductManagement/models.py
from django.db import models

class Brand(models.Model):
    name = models.CharField(max_length=255)
    description = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.name

class Category(models.Model):
    name = models.CharField(max_length=255)
    description = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.name

class Product(models.Model):
    name = models.CharField(max_length=255)
    description = models.TextField()
    price = models.DecimalField(max_digits=10, decimal_places=2)
    brand = models.ForeignKey(Brand, on_delete=models.CASCADE)
    category = models.ForeignKey(Category, on_delete=models.CASCADE)
    status = models.CharField(max_length=255)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.name

class Inventory(models.Model):
    product = models.ForeignKey(Product, on_delete=models.CASCADE)
    quantity = models.IntegerField()
    adjusted_by = models.CharField(max_length=255)
    adjustment_reason = models.TextField()
    adjustment_time = models.DateTimeField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return f'{self.product.name} - {self.quantity}'

class Variant(models.Model):
    product = models.ForeignKey(Product, on_delete=models.CASCADE)
    name = models.CharField(max_length=255)
    price = models.DecimalField(max_digits=10, decimal_places=2)
    sku = models.CharField(max_length=255)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.name

class Image(models.Model):
    product = models.ForeignKey(Product, on_delete=models.CASCADE)
    url = models.CharField(max_length=255)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.url

class Video(models.Model):
    product = models.ForeignKey(Product, on_delete=models.CASCADE)
    url = models.CharField(max_length=255)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.url

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
EOF

# Step 3: Create Django admin registration for ProductManagement models
cat <<EOF > ProductManagement/admin.py
from django.contrib import admin
from .models import (
    Brand, Category, Product, Inventory, Variant, Image, Video, Pricing, Discount
)

class BrandAdmin(admin.ModelAdmin):
    list_display = ('name', 'description', 'created_at', 'updated_at')
    search_fields = ('name',)

class CategoryAdmin(admin.ModelAdmin):
    list_display = ('name', 'description', 'created_at', 'updated_at')
    search_fields = ('name',)

class ProductAdmin(admin.ModelAdmin):
    list_display = ('name', 'description', 'price', 'brand', 'category', 'status', 'created_at', 'updated_at')
    search_fields = ('name', 'description')
    list_filter = ('brand', 'category', 'status')

class InventoryAdmin(admin.ModelAdmin):
    list_display = ('product', 'quantity', 'adjusted_by', 'adjustment_reason', 'adjustment_time', 'created_at', 'updated_at')
    search_fields = ('product__name', 'adjusted_by')
    list_filter = ('adjusted_by',)

class VariantAdmin(admin.ModelAdmin):
    list_display = ('product', 'name', 'price', 'sku', 'created_at', 'updated_at')
    search_fields = ('name', 'sku')

class ImageAdmin(admin.ModelAdmin):
    list_display = ('product', 'url', 'created_at')
    search_fields = ('url',)

class VideoAdmin(admin.ModelAdmin):
    list_display = ('product', 'url', 'created_at')
    search_fields = ('url',)

class PricingAdmin(admin.ModelAdmin):
    list_display = ('product', 'price', 'effective_date')
    search_fields = ('product__name', 'price')

class DiscountAdmin(admin.ModelAdmin):
    list_display = ('product', 'discount_percentage', 'start_date', 'end_date')
    search_fields = ('product__name', 'discount_percentage')

admin.site.register(Brand, BrandAdmin)
admin.site.register(Category, CategoryAdmin)
admin.site.register(Product, ProductAdmin)
admin.site.register(Inventory, InventoryAdmin)
admin.site.register(Variant, VariantAdmin)
admin.site.register(Image, ImageAdmin)
admin.site.register(Video, VideoAdmin)
admin.site.register(Pricing, PricingAdmin)
admin.site.register(Discount, DiscountAdmin)
EOF


# Step 3: Create Django migrations
python manage.py makemigrations ProductManagement
























## Create Inventory Management ##

# Step 1: Create Django app
python manage.py startapp InventoryManagement
sed -i "/INSTALLED_APPS = \[/a \ \ \ \ 'InventoryManagement'," $SETTINGS_FILE
# Step 2: Create Django models for each table

# Inventory model
cat <<EOF > InventoryManagement/models.py
from django.db import models
from ProductManagement.models import Product

class InventoryLocation(models.Model):
    name = models.CharField(max_length=255)
    description = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class Inventory(models.Model):
    product = models.ForeignKey(Product, on_delete=models.CASCADE, related_name='inventory_items')
    location = models.ForeignKey(InventoryLocation, on_delete=models.CASCADE)
    quantity = models.IntegerField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class InventoryHistory(models.Model):
    product = models.ForeignKey(Product, on_delete=models.CASCADE, related_name='history_items')
    inventory = models.ForeignKey(Inventory, on_delete=models.CASCADE)
    action = models.CharField(max_length=255)
    quantity_changed = models.IntegerField()
    actor = models.CharField(max_length=255)
    timestamp = models.DateTimeField()

class StockAlert(models.Model):
    product = models.ForeignKey(Product, on_delete=models.CASCADE, related_name='stock_alerts')
    threshold_quantity = models.IntegerField()
    action_required = models.CharField(max_length=255)
    created_at = models.DateTimeField(auto_now_add=True)

class StockTransfer(models.Model):
    from_location = models.ForeignKey(InventoryLocation, on_delete=models.CASCADE, related_name='from_location')
    to_location = models.ForeignKey(InventoryLocation, on_delete=models.CASCADE, related_name='to_location')
    product = models.ForeignKey(Product, on_delete=models.CASCADE, related_name='stock_transfer')
    quantity_transferred = models.IntegerField()
    status = models.CharField(max_length=255)
    initiated_by = models.CharField(max_length=255)
    timestamp = models.DateTimeField()

class Batch(models.Model):
    product = models.ForeignKey(Product, on_delete=models.CASCADE, related_name='batches')
    batch_number = models.CharField(max_length=255)
    expiry_date = models.DateTimeField()
    quantity = models.IntegerField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class ExpiryManagement(models.Model):
    product = models.ForeignKey(Product, on_delete=models.CASCADE, related_name='expiry_managements')
    batch = models.ForeignKey(Batch, on_delete=models.CASCADE)
    expiry_date = models.DateTimeField()
    quantity = models.IntegerField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class InventoryReport(models.Model):
    report_type = models.CharField(max_length=255)
    report_data = models.JSONField()
    generated_at = models.DateTimeField()

class InventoryAdjustmentReason(models.Model):
    reason = models.CharField(max_length=255)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
EOF

# Step 1: Create Django admin registration for InventoryManagement models
cat <<EOF > InventoryManagement/admin.py
from django.contrib import admin
from .models import (
    InventoryLocation, Inventory, InventoryHistory, StockAlert, StockTransfer,
    Batch, ExpiryManagement, InventoryReport, InventoryAdjustmentReason
)

admin.site.register(InventoryLocation)
admin.site.register(Inventory)
admin.site.register(InventoryHistory)
admin.site.register(StockAlert)
admin.site.register(StockTransfer)
admin.site.register(Batch)
admin.site.register(ExpiryManagement)
admin.site.register(InventoryReport)
admin.site.register(InventoryAdjustmentReason)
EOF

# Step 3: Create Django migrations
python manage.py makemigrations InventoryManagement
































## Create Customer Management ##

# Step 1: Create Django app
python manage.py startapp CustomerManagement
sed -i "/INSTALLED_APPS = \[/a \ \ \ \ 'CustomerManagement'," $SETTINGS_FILE

# Step 2: Create Django models for each table

# Customers model
cat <<EOF > CustomerManagement/models.py
from django.db import models

class Customer(models.Model):
    first_name = models.CharField(max_length=255)
    last_name = models.CharField(max_length=255)
    email = models.EmailField()
    phone_number = models.CharField(max_length=20)
    address = models.CharField(max_length=255)
    city = models.CharField(max_length=255)
    state = models.CharField(max_length=255)
    country = models.CharField(max_length=255)
    postal_code = models.CharField(max_length=20)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return f'{self.first_name} {self.last_name}'

class CustomerPreference(models.Model):
    customer = models.ForeignKey(Customer, on_delete=models.CASCADE)
    preference_key = models.CharField(max_length=255)
    preference_value = models.CharField(max_length=255)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return f'{self.preference_key}: {self.preference_value}'

class CustomerTag(models.Model):
    customer = models.ForeignKey(Customer, on_delete=models.CASCADE)
    tag_name = models.CharField(max_length=255)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.tag_name

class CustomerNote(models.Model):
    customer = models.ForeignKey(Customer, on_delete=models.CASCADE)
    note = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.note[:50]

class Lead(models.Model):
    lead_name = models.CharField(max_length=255)
    contact_email = models.EmailField()
    contact_phone = models.CharField(max_length=20)
    company_name = models.CharField(max_length=255)
    source = models.CharField(max_length=255)
    status = models.CharField(max_length=255)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.lead_name

class Opportunity(models.Model):
    customer = models.ForeignKey(Customer, on_delete=models.CASCADE)
    opportunity_name = models.CharField(max_length=255)
    amount = models.DecimalField(max_digits=10, decimal_places=2)
    stage = models.CharField(max_length=255)
    close_date = models.DateTimeField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.opportunity_name

class Interaction(models.Model):
    customer = models.ForeignKey(Customer, on_delete=models.CASCADE)
    interaction_type = models.CharField(max_length=255)
    interaction_date = models.DateTimeField()
    notes = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return f'{self.interaction_type} on {self.interaction_date}'

class Task(models.Model):
    task_name = models.CharField(max_length=255)
    customer = models.ForeignKey(Customer, on_delete=models.CASCADE)
    due_date = models.DateTimeField()
    status = models.CharField(max_length=255)
    priority = models.CharField(max_length=255)
    assigned_to = models.IntegerField()  # Foreign key referencing users table
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.task_name

class Segment(models.Model):
    segment_name = models.CharField(max_length=255)
    segment_criteria = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.segment_name

class Survey(models.Model):
    survey_name = models.CharField(max_length=255)
    survey_questions = models.JSONField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.survey_name

class Integration(models.Model):
    integration_name = models.CharField(max_length=255)
    integration_type = models.CharField(max_length=255)
    integration_key = models.CharField(max_length=255)
    integration_secret = models.CharField(max_length=255)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.integration_name

class NPSResponse(models.Model):
    customer = models.ForeignKey(Customer, on_delete=models.CASCADE)
    nps_score = models.IntegerField()
    feedback = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return f'NPS {self.nps_score}'

class LifecycleStage(models.Model):
    stage_name = models.CharField(max_length=255)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.stage_name

class CalendarEvent(models.Model):
    event_title = models.CharField(max_length=255)
    event_description = models.TextField()
    event_start = models.DateTimeField()
    event_end = models.DateTimeField()
    customer = models.ForeignKey(Customer, on_delete=models.CASCADE)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.event_title

class Document(models.Model):
    document_name = models.CharField(max_length=255)
    document_type = models.CharField(max_length=255)
    document_url = models.CharField(max_length=255)
    customer = models.ForeignKey(Customer, on_delete=models.CASCADE)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.document_name
EOF

# Step 3: Register models with Django admin
cat <<EOF > CustomerManagement/admin.py
from django.contrib import admin
from .models import (
    Customer, CustomerPreference, CustomerTag, CustomerNote, Lead,
    Opportunity, Interaction, Task, Segment, Survey, Integration,
    NPSResponse, LifecycleStage, CalendarEvent, Document
)

class CustomerAdmin(admin.ModelAdmin):
    list_display = ('first_name', 'last_name', 'email', 'phone_number', 'city', 'state', 'country', 'created_at', 'updated_at')
    search_fields = ('first_name', 'last_name', 'email', 'phone_number')
    list_filter = ('city', 'state', 'country')

class CustomerPreferenceAdmin(admin.ModelAdmin):
    list_display = ('customer', 'preference_key', 'preference_value', 'created_at', 'updated_at')
    search_fields = ('customer__first_name', 'customer__last_name', 'preference_key', 'preference_value')

class CustomerTagAdmin(admin.ModelAdmin):
    list_display = ('customer', 'tag_name', 'created_at', 'updated_at')
    search_fields = ('customer__first_name', 'customer__last_name', 'tag_name')

class CustomerNoteAdmin(admin.ModelAdmin):
    list_display = ('customer', 'note', 'created_at', 'updated_at')
    search_fields = ('customer__first_name', 'customer__last_name', 'note')

class LeadAdmin(admin.ModelAdmin):
    list_display = ('lead_name', 'contact_email', 'contact_phone', 'company_name', 'source', 'status', 'created_at', 'updated_at')
    search_fields = ('lead_name', 'contact_email', 'contact_phone', 'company_name', 'source', 'status')
    list_filter = ('status', 'source')

class OpportunityAdmin(admin.ModelAdmin):
    list_display = ('customer', 'opportunity_name', 'amount', 'stage', 'close_date', 'created_at', 'updated_at')
    search_fields = ('customer__first_name', 'customer__last_name', 'opportunity_name', 'amount', 'stage')
    list_filter = ('stage',)

class InteractionAdmin(admin.ModelAdmin):
    list_display = ('customer', 'interaction_type', 'interaction_date', 'notes', 'created_at', 'updated_at')
    search_fields = ('customer__first_name', 'customer__last_name', 'interaction_type', 'notes')
    list_filter = ('interaction_type', 'interaction_date')

class TaskAdmin(admin.ModelAdmin):
    list_display = ('task_name', 'customer', 'due_date', 'status', 'priority', 'assigned_to', 'created_at', 'updated_at')
    search_fields = ('task_name', 'customer__first_name', 'customer__last_name', 'status', 'priority')
    list_filter = ('status', 'priority', 'due_date')

class SegmentAdmin(admin.ModelAdmin):
    list_display = ('segment_name', 'segment_criteria', 'created_at', 'updated_at')
    search_fields = ('segment_name', 'segment_criteria')

class SurveyAdmin(admin.ModelAdmin):
    list_display = ('survey_name', 'created_at', 'updated_at')
    search_fields = ('survey_name',)

class IntegrationAdmin(admin.ModelAdmin):
    list_display = ('integration_name', 'integration_type', 'integration_key', 'integration_secret', 'created_at', 'updated_at')
    search_fields = ('integration_name', 'integration_type', 'integration_key', 'integration_secret')

class NPSResponseAdmin(admin.ModelAdmin):
    list_display = ('customer', 'nps_score', 'feedback', 'created_at', 'updated_at')
    search_fields = ('customer__first_name', 'customer__last_name', 'nps_score', 'feedback')

class LifecycleStageAdmin(admin.ModelAdmin):
    list_display = ('stage_name', 'created_at', 'updated_at')
    search_fields = ('stage_name',)

class CalendarEventAdmin(admin.ModelAdmin):
    list_display = ('event_title', 'event_description', 'event_start', 'event_end', 'customer', 'created_at', 'updated_at')
    search_fields = ('event_title', 'event_description', 'customer__first_name', 'customer__last_name')
    list_filter = ('event_start', 'event_end')

class DocumentAdmin(admin.ModelAdmin):
    list_display = ('document_name', 'document_type', 'document_url', 'customer', 'created_at', 'updated_at')
    search_fields = ('document_name', 'document_type', 'document_url', 'customer__first_name', 'customer__last_name')

admin.site.register(Customer, CustomerAdmin)
admin.site.register(CustomerPreference, CustomerPreferenceAdmin)
admin.site.register(CustomerTag, CustomerTagAdmin)
admin.site.register(CustomerNote, CustomerNoteAdmin)
admin.site.register(Lead, LeadAdmin)
admin.site.register(Opportunity, OpportunityAdmin)
admin.site.register(Interaction, InteractionAdmin)
admin.site.register(Task, TaskAdmin)
admin.site.register(Segment, SegmentAdmin)
admin.site.register(Survey, SurveyAdmin)
admin.site.register(Integration, IntegrationAdmin)
admin.site.register(NPSResponse, NPSResponseAdmin)
admin.site.register(LifecycleStage, LifecycleStageAdmin)
admin.site.register(CalendarEvent, CalendarEventAdmin)
admin.site.register(Document, DocumentAdmin)
EOF

# Step 3: Create Django migrations
python manage.py makemigrations CustomerManagement




























## Create Order Management ##

# Step 1: Create Django app
python manage.py startapp OrderManagement
sed -i "/INSTALLED_APPS = \[/a \ \ \ \ 'OrderManagement'," $SETTINGS_FILE

# Step 2: Create Django models for each table


# Orders model
cat <<EOF > OrderManagement/models.py
from django.db import models
from CustomerManagement.models import Customer
from ProductManagement.models import Product

class Order(models.Model):
    customer = models.ForeignKey(Customer, on_delete=models.CASCADE)
    order_date = models.DateTimeField()
    status = models.CharField(max_length=255)
    total_amount = models.DecimalField(max_digits=10, decimal_places=2)
    payment_status = models.CharField(max_length=255)
    shipping_address = models.CharField(max_length=255)
    billing_address = models.CharField(max_length=255)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return f'Order {self.id} - {self.customer}'

class OrderItem(models.Model):
    order = models.ForeignKey(Order, on_delete=models.CASCADE)
    product = models.ForeignKey(Product, on_delete=models.CASCADE)
    quantity = models.IntegerField()
    unit_price = models.DecimalField(max_digits=10, decimal_places=2)
    total_price = models.DecimalField(max_digits=10, decimal_places=2)

    def __str__(self):
        return f'{self.product.name} (x{self.quantity})'

class Shipment(models.Model):
    order = models.ForeignKey(Order, on_delete=models.CASCADE)
    shipping_method = models.CharField(max_length=255)
    tracking_number = models.CharField(max_length=255)
    shipping_date = models.DateTimeField()
    delivery_date = models.DateTimeField()

    def __str__(self):
        return f'Shipment for Order {self.order.id}'

class Return(models.Model):
    order = models.ForeignKey(Order, on_delete=models.CASCADE)
    return_reason = models.TextField()
    return_status = models.CharField(max_length=255)
    return_date = models.DateTimeField()

    def __str__(self):
        return f'Return for Order {self.order.id}'

class Refund(models.Model):
    order = models.ForeignKey(Order, on_delete=models.CASCADE)
    refund_amount = models.DecimalField(max_digits=10, decimal_places=2)
    refund_reason = models.TextField()
    refund_status = models.CharField(max_length=255)
    refund_date = models.DateTimeField()

    def __str__(self):
        return f'Refund for Order {self.order.id}'

class OrderCommunication(models.Model):
    order = models.ForeignKey(Order, on_delete=models.CASCADE)
    recipient_email = models.CharField(max_length=255)
    subject = models.CharField(max_length=255)
    message_body = models.TextField()
    sent_at = models.DateTimeField()

    def __str__(self):
        return f'Communication for Order {self.order.id}'

class RecurringOrder(models.Model):
    customer = models.ForeignKey(Customer, on_delete=models.CASCADE)
    start_date = models.DateTimeField()
    end_date = models.DateTimeField()
    frequency = models.CharField(max_length=255)

    def __str__(self):
        return f'Recurring Order for {self.customer}'

class OrderBatch(models.Model):
    batch_type = models.CharField(max_length=255)
    batch_data = models.JSONField()
    processed_at = models.DateTimeField()

    def __str__(self):
        return f'Order Batch {self.id} - {self.batch_type}'
EOF

# Step 3: Register models with Django admin
cat <<EOF > OrderManagement/admin.py
from django.contrib import admin
from .models import (
    Order, OrderItem, Shipment, Return, Refund, OrderCommunication,
    RecurringOrder, OrderBatch
)

class OrderAdmin(admin.ModelAdmin):
    list_display = ('id', 'customer', 'order_date', 'status', 'total_amount', 'payment_status', 'created_at', 'updated_at')
    search_fields = ('customer__first_name', 'customer__last_name', 'status', 'payment_status')
    list_filter = ('status', 'payment_status', 'order_date')

class OrderItemAdmin(admin.ModelAdmin):
    list_display = ('order', 'product', 'quantity', 'unit_price', 'total_price')
    search_fields = ('order__id', 'product__name')
    list_filter = ('order__order_date',)

class ShipmentAdmin(admin.ModelAdmin):
    list_display = ('order', 'shipping_method', 'tracking_number', 'shipping_date', 'delivery_date')
    search_fields = ('order__id', 'shipping_method', 'tracking_number')
    list_filter = ('shipping_date', 'delivery_date')

class ReturnAdmin(admin.ModelAdmin):
    list_display = ('order', 'return_reason', 'return_status', 'return_date')
    search_fields = ('order__id', 'return_status')
    list_filter = ('return_status', 'return_date')

class RefundAdmin(admin.ModelAdmin):
    list_display = ('order', 'refund_amount', 'refund_reason', 'refund_status', 'refund_date')
    search_fields = ('order__id', 'refund_status')
    list_filter = ('refund_status', 'refund_date')

class OrderCommunicationAdmin(admin.ModelAdmin):
    list_display = ('order', 'recipient_email', 'subject', 'sent_at')
    search_fields = ('order__id', 'recipient_email', 'subject')
    list_filter = ('sent_at',)

class RecurringOrderAdmin(admin.ModelAdmin):
    list_display = ('customer', 'start_date', 'end_date', 'frequency')
    search_fields = ('customer__first_name', 'customer__last_name', 'frequency')
    list_filter = ('start_date', 'end_date', 'frequency')

class OrderBatchAdmin(admin.ModelAdmin):
    list_display = ('batch_type', 'processed_at')
    search_fields = ('batch_type',)
    list_filter = ('processed_at',)

admin.site.register(Order, OrderAdmin)
admin.site.register(OrderItem, OrderItemAdmin)
admin.site.register(Shipment, ShipmentAdmin)
admin.site.register(Return, ReturnAdmin)
admin.site.register(Refund, RefundAdmin)
admin.site.register(OrderCommunication, OrderCommunicationAdmin)
admin.site.register(RecurringOrder, RecurringOrderAdmin)
admin.site.register(OrderBatch, OrderBatchAdmin)
EOF
# Step 3: Create Django migrations
python manage.py makemigrations OrderManagement

























## Payment Processing App ##


# Step 1: Create Django app
python manage.py startapp PaymentProcessing
sed -i "/INSTALLED_APPS = \[/a \ \ \ \ 'PaymentProcessing'," $SETTINGS_FILE

# Step 2: Create Django models for each table

# Payments model
cat <<EOF > PaymentProcessing/models.py
from django.db import models
from CustomerManagement.models import Customer

class Payments(models.Model):
    payment_id = models.AutoField(primary_key=True)
    order_id = models.ForeignKey('OrderManagement.Order', on_delete=models.CASCADE)
    customer_id = models.ForeignKey(Customer, on_delete=models.CASCADE)
    amount = models.DecimalField(max_digits=10, decimal_places=2)
    currency = models.CharField(max_length=255)
    status = models.CharField(max_length=255)
    payment_method_id = models.ForeignKey('PaymentMethods', on_delete=models.CASCADE)
    transaction_id = models.CharField(max_length=255)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
      return f"Payment ID: {self.payment_id}, Amount: {self.amount}, Status: {self.status}"


class PaymentMethods(models.Model):
    payment_method_id = models.AutoField(primary_key=True)
    customer_id = models.ForeignKey(Customer, on_delete=models.CASCADE)
    method_type = models.CharField(max_length=255)
    details = models.JSONField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
      return f"Payment Method ID: {self.payment_method_id}, Type: {self.method_type}"


class PaymentHistory(models.Model):
    history_id = models.AutoField(primary_key=True)
    payment_id = models.ForeignKey(Payments, on_delete=models.CASCADE)
    event_type = models.CharField(max_length=255)
    event_details = models.JSONField()
    event_date = models.DateTimeField()

    def __str__(self):
      return f"History ID: {self.history_id}, Payment ID: {self.payment_id}, Event Type: {self.event_type}"


class PaymentTokens(models.Model):
    token_id = models.AutoField(primary_key=True)
    customer_id = models.ForeignKey(Customer, on_delete=models.CASCADE)
    token_type = models.CharField(max_length=255)
    token_value = models.CharField(max_length=255)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
      return f"Token ID: {self.token_id}, Type: {self.token_type}"


class PaymentNotifications(models.Model):
    notification_id = models.AutoField(primary_key=True)
    transaction_id = models.CharField(max_length=255)
    notification_type = models.CharField(max_length=255)
    notification_details = models.JSONField()
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
      return f"Notification ID: {self.notification_id}, Transaction ID: {self.transaction_id}, Type: {self.notification_type}"


class PaymentGateways(models.Model):
    gateway_id = models.AutoField(primary_key=True)
    gateway_name = models.CharField(max_length=255)
    configuration = models.JSONField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
      return f"Gateway ID: {self.gateway_id}, Name: {self.gateway_name}"


class RecurringPayments(models.Model):
    subscription_id = models.AutoField(primary_key=True)
    customer_id = models.ForeignKey(Customer, on_delete=models.CASCADE)
    order_id = models.ForeignKey('OrderManagement.Order', on_delete=models.CASCADE)
    amount = models.DecimalField(max_digits=10, decimal_places=2)
    frequency = models.CharField(max_length=255)
    status = models.CharField(max_length=255)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
      return f"Subscription ID: {self.subscription_id}, Amount: {self.amount}, Status: {self.status}"


class Settlements(models.Model):
    settlement_id = models.AutoField(primary_key=True)
    gateway_id = models.ForeignKey(PaymentGateways, on_delete=models.CASCADE)
    amount = models.DecimalField(max_digits=10, decimal_places=2)
    currency = models.CharField(max_length=255)
    status = models.CharField(max_length=255)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
      return f"Settlement ID: {self.settlement_id}, Gateway ID: {self.gateway_id}, Amount: {self.amount}, Status: {self.status}"


class FraudDetection(models.Model):
    fraud_id = models.AutoField(primary_key=True)
    transaction_id = models.CharField(max_length=255)
    customer_id = models.ForeignKey(Customer, on_delete=models.CASCADE)
    fraud_score = models.IntegerField()
    fraud_alert = models.CharField(max_length=255)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
      return f"Fraud ID: {self.fraud_id}, Transaction ID: {self.transaction_id}, Score: {self.fraud_score}, Alert: {self.fraud_alert}"


class SecureAuthentication(models.Model):
    auth_id = models.AutoField(primary_key=True)
    transaction_id = models.CharField(max_length=255)
    customer_id = models.ForeignKey(Customer, on_delete=models.CASCADE)
    status = models.CharField(max_length=255)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    
    def __str__(self):
      return f"Auth ID: {self.auth_id}, Transaction ID: {self.transaction_id}, Status: {self.status}"


EOF

# Step 3: Register models with Django admin
cat <<EOF > PaymentProcessing/admin.py
from django.contrib import admin
from .models import (
    Payments, PaymentMethods, PaymentHistory, PaymentTokens,
    PaymentNotifications, PaymentGateways, RecurringPayments,
    Settlements, FraudDetection, SecureAuthentication
)


# Customize admin display for each model
class PaymentAdmin(admin.ModelAdmin):
    list_display = ('payment_id', 'order_id', 'customer_id', 'amount', 'status', 'created_at', 'updated_at')
    list_filter = ('status', 'created_at')
    search_fields = ('order_id__id', 'customer_id__first_name', 'customer_id__last_name', 'transaction_id')

class PaymentMethodsAdmin(admin.ModelAdmin):
    list_display = ('payment_method_id', 'customer_id', 'method_type', 'created_at', 'updated_at')
    list_filter = ('method_type', 'created_at')
    search_fields = ('customer_id__first_name', 'customer_id__last_name', 'method_type')

class PaymentHistoryAdmin(admin.ModelAdmin):
    list_display = ('history_id', 'payment_id', 'event_type', 'event_date')
    list_filter = ('event_type', 'event_date')
    search_fields = ('payment_id__payment_id',)

class PaymentTokensAdmin(admin.ModelAdmin):
    list_display = ('token_id', 'customer_id', 'token_type', 'created_at', 'updated_at')
    list_filter = ('token_type', 'created_at')
    search_fields = ('customer_id__first_name', 'customer_id__last_name', 'token_type')

class PaymentNotificationsAdmin(admin.ModelAdmin):
    list_display = ('notification_id', 'transaction_id', 'notification_type', 'created_at')
    list_filter = ('notification_type', 'created_at')
    search_fields = ('transaction_id',)

class PaymentGatewaysAdmin(admin.ModelAdmin):
    list_display = ('gateway_id', 'gateway_name', 'created_at', 'updated_at')
    search_fields = ('gateway_name',)

class RecurringPaymentsAdmin(admin.ModelAdmin):
    list_display = ('subscription_id', 'customer_id', 'order_id', 'amount', 'status', 'created_at', 'updated_at')
    list_filter = ('status', 'created_at')
    search_fields = ('customer_id__first_name', 'customer_id__last_name')

class SettlementsAdmin(admin.ModelAdmin):
    list_display = ('settlement_id', 'gateway_id', 'amount', 'status', 'created_at', 'updated_at')
    list_filter = ('status', 'created_at')
    search_fields = ('gateway_id__gateway_name',)

class FraudDetectionAdmin(admin.ModelAdmin):
    list_display = ('fraud_id', 'transaction_id', 'customer_id', 'fraud_score', 'fraud_alert', 'created_at', 'updated_at')
    list_filter = ('fraud_score', 'fraud_alert', 'created_at')
    search_fields = ('customer_id__first_name', 'customer_id__last_name', 'transaction_id')

class SecureAuthenticationAdmin(admin.ModelAdmin):
    list_display = ('auth_id', 'transaction_id', 'customer_id', 'status', 'created_at', 'updated_at')
    list_filter = ('status', 'created_at')
    search_fields = ('customer_id__first_name', 'customer_id__last_name', 'transaction_id')

# Register models with custom admin displays
admin.site.register(Payments, PaymentAdmin)
admin.site.register(PaymentMethods, PaymentMethodsAdmin)
admin.site.register(PaymentHistory, PaymentHistoryAdmin)
admin.site.register(PaymentTokens, PaymentTokensAdmin)
admin.site.register(PaymentNotifications, PaymentNotificationsAdmin)
admin.site.register(PaymentGateways, PaymentGatewaysAdmin)
admin.site.register(RecurringPayments, RecurringPaymentsAdmin)
admin.site.register(Settlements, SettlementsAdmin)
admin.site.register(FraudDetection, FraudDetectionAdmin)
admin.site.register(SecureAuthentication, SecureAuthenticationAdmin)
EOF

# Step 4: Create Django migrations
python manage.py makemigrations PaymentProcessing


















# Step 1: Create Django app
python manage.py startapp ShippingAndFulfillment
sed -i "/INSTALLED_APPS = \[/a \ \ \ \ 'ShippingAndFulfillment'," $SETTINGS_FILE

# Step 2: Create Django models for each table

# Shipping Addresses model
cat <<EOF > ShippingAndFulfillment/models.py
from django.db import models
from CustomerManagement.models import Customer
from OrderManagement.models import Order

class ShippingAddresses(models.Model):
    address_id = models.AutoField(primary_key=True)
    customer_id = models.ForeignKey(Customer, on_delete=models.CASCADE)
    recipient_name = models.CharField(max_length=255)
    street_address = models.CharField(max_length=255)
    city = models.CharField(max_length=255)
    state = models.CharField(max_length=255)
    postal_code = models.CharField(max_length=20)
    country = models.CharField(max_length=255)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class ShippingLabels(models.Model):
    label_id = models.AutoField(primary_key=True)
    order_id = models.ForeignKey(Order, on_delete=models.CASCADE)
    carrier_id = models.ForeignKey('ShippingCarriers', on_delete=models.CASCADE)
    label_type = models.CharField(max_length=255)
    label_url = models.CharField(max_length=255)
    customization_settings = models.JSONField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class PackageTracking(models.Model):
    tracking_id = models.AutoField(primary_key=True)
    order_id = models.ForeignKey(Order, on_delete=models.CASCADE)
    tracking_number = models.CharField(max_length=255)
    carrier_id = models.ForeignKey('ShippingCarriers', on_delete=models.CASCADE)
    status = models.CharField(max_length=255)
    tracking_updates = models.JSONField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class ShippingCarriers(models.Model):
    carrier_id = models.AutoField(primary_key=True)
    carrier_name = models.CharField(max_length=255)
    carrier_details = models.JSONField()
    settings = models.JSONField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class ShippingInsurance(models.Model):
    insurance_id = models.AutoField(primary_key=True)
    order_id = models.ForeignKey(Order, on_delete=models.CASCADE)
    coverage_amount = models.DecimalField(max_digits=10, decimal_places=2)
    claim_status = models.CharField(max_length=255)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

# Define the remaining models similarly...

EOF


# Step 3: Register models with Django admin
cat <<EOF > ShippingAndFulfillment/admin.py
from django.contrib import admin
from .models import (
    ShippingAddresses, ShippingLabels, PackageTracking,
    ShippingCarriers, ShippingInsurance
)

@admin.register(ShippingAddresses)
class ShippingAddressesAdmin(admin.ModelAdmin):
    list_display = ('address_id', 'customer_id', 'recipient_name', 'street_address', 'city', 'state', 'postal_code', 'country', 'created_at', 'updated_at')
    search_fields = ('recipient_name', 'street_address', 'city', 'state', 'postal_code', 'country')


@admin.register(ShippingLabels)
class ShippingLabelsAdmin(admin.ModelAdmin):
    list_display = ('label_id', 'order_id', 'carrier_id', 'label_type', 'label_url', 'created_at', 'updated_at')
    search_fields = ('label_type',)


@admin.register(PackageTracking)
class PackageTrackingAdmin(admin.ModelAdmin):
    list_display = ('tracking_id', 'order_id', 'tracking_number', 'carrier_id', 'status', 'created_at', 'updated_at')
    search_fields = ('tracking_number', 'status')


@admin.register(ShippingCarriers)
class ShippingCarriersAdmin(admin.ModelAdmin):
    list_display = ('carrier_id', 'carrier_name', 'created_at', 'updated_at')
    search_fields = ('carrier_name',)


@admin.register(ShippingInsurance)
class ShippingInsuranceAdmin(admin.ModelAdmin):
    list_display = ('insurance_id', 'order_id', 'coverage_amount', 'claim_status', 'created_at', 'updated_at')
    search_fields = ('claim_status',)

EOF

# Step 4: Create Django migrations
python manage.py makemigrations ShippingAndFulfillment






















# Step 1: Create Django app
python manage.py startapp SearchAndFiltering
sed -i "/INSTALLED_APPS = \[/a \ \ \ \ 'SearchAndFiltering'," $SETTINGS_FILE

# Step 2: Create Django models for each table

# Advanced Search History model
cat <<EOF > SearchAndFiltering/models.py
from django.db import models
from django.contrib.auth.models import User

class AdvancedSearchHistory(models.Model):
    search_id = models.IntegerField(primary_key=True)
    search_type = models.CharField(max_length=255)
    search_query = models.CharField(max_length=255)
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    timestamp = models.DateTimeField()

class AttributeValues(models.Model):
    value_id = models.IntegerField(primary_key=True)
    attribute_id = models.IntegerField()
    value = models.CharField(max_length=255)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class SavedSearches(models.Model):
    saved_search_id = models.IntegerField(primary_key=True)
    search_type = models.CharField(max_length=255)
    search_query = models.CharField(max_length=255)
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    saved_at = models.DateTimeField()

class SearchHistory(models.Model):
    history_id = models.IntegerField(primary_key=True)
    search_type = models.CharField(max_length=255)
    search_query = models.CharField(max_length=255)
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    timestamp = models.DateTimeField()

class SearchIndex(models.Model):
    index_id = models.IntegerField(primary_key=True)
    search_type = models.CharField(max_length=255)
    item_id = models.IntegerField()
    indexed_at = models.DateTimeField()
    updated_at = models.DateTimeField()

class SearchFiltersPersistence(models.Model):
    persistence_id = models.IntegerField(primary_key=True)
    search_type = models.CharField(max_length=255)
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    filter_settings = models.JSONField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class SearchResultsExportHistory(models.Model):
    export_id = models.IntegerField(primary_key=True)
    search_type = models.CharField(max_length=255)
    export_query = models.CharField(max_length=255)
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    exported_at = models.DateTimeField()

class SearchRelevanceRanking(models.Model):
    ranking_id = models.IntegerField(primary_key=True)
    search_type = models.CharField(max_length=255)
    ranking_settings = models.JSONField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
EOF

# Step 3: Register models with Django admin
cat <<EOF > SearchAndFiltering/admin.py
from django.contrib import admin
from .models import (
    AdvancedSearchHistory, AttributeValues, SavedSearches, SearchHistory,
    SearchIndex, SearchFiltersPersistence, SearchResultsExportHistory,
    SearchRelevanceRanking
)

@admin.register(AdvancedSearchHistory)
class AdvancedSearchHistoryAdmin(admin.ModelAdmin):
    list_display = ('search_id', 'search_type', 'search_query', 'user', 'timestamp')
    search_fields = ('search_type', 'search_query', 'user__username')

@admin.register(AttributeValues)
class AttributeValuesAdmin(admin.ModelAdmin):
    list_display = ('value_id', 'attribute_id', 'value', 'created_at', 'updated_at')
    search_fields = ('value',)

@admin.register(SavedSearches)
class SavedSearchesAdmin(admin.ModelAdmin):
    list_display = ('saved_search_id', 'search_type', 'search_query', 'user', 'saved_at')
    search_fields = ('search_type', 'search_query', 'user__username')

@admin.register(SearchHistory)
class SearchHistoryAdmin(admin.ModelAdmin):
    list_display = ('history_id', 'search_type', 'search_query', 'user', 'timestamp')
    search_fields = ('search_type', 'search_query', 'user__username')

@admin.register(SearchIndex)
class SearchIndexAdmin(admin.ModelAdmin):
    list_display = ('index_id', 'search_type', 'item_id', 'indexed_at', 'updated_at')
    search_fields = ('search_type', 'item_id')

@admin.register(SearchFiltersPersistence)
class SearchFiltersPersistenceAdmin(admin.ModelAdmin):
    list_display = ('persistence_id', 'search_type', 'user', 'created_at', 'updated_at')
    search_fields = ('search_type', 'user__username')

@admin.register(SearchResultsExportHistory)
class SearchResultsExportHistoryAdmin(admin.ModelAdmin):
    list_display = ('export_id', 'search_type', 'export_query', 'user', 'exported_at')
    search_fields = ('search_type', 'export_query', 'user__username')

@admin.register(SearchRelevanceRanking)
class SearchRelevanceRankingAdmin(admin.ModelAdmin):
    list_display = ('ranking_id', 'search_type', 'created_at', 'updated_at')
    search_fields = ('search_type',)

EOF

# Step 4: Create Django migrations
python manage.py makemigrations SearchAndFiltering
















# Step 1: Create Django app
python manage.py startapp MarketingAndPromotions
sed -i "/INSTALLED_APPS = \[/a \ \ \ \ 'MarketingAndPromotions'," $SETTINGS_FILE

# Step 2: Create Django models for each table

# Promotion Rules model
cat <<EOF > MarketingAndPromotions/models.py
from django.db import models

class PromotionRules(models.Model):
    rule_id = models.IntegerField(primary_key=True)
    rule_name = models.CharField(max_length=255)
    rule_description = models.TextField()
    conditions = models.JSONField()
    actions = models.JSONField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class PromotionCoupons(models.Model):
    coupon_id = models.IntegerField(primary_key=True)
    coupon_code = models.CharField(max_length=255)
    discount_type = models.CharField(max_length=255)
    discount_value = models.DecimalField(max_digits=10, decimal_places=2)
    max_uses = models.IntegerField()
    uses_counter = models.IntegerField()
    expiration_date = models.DateTimeField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class PromotionSegments(models.Model):
    segment_id = models.IntegerField(primary_key=True)
    segment_name = models.CharField(max_length=255)
    segment_criteria = models.JSONField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class PromotionAnalytics(models.Model):
    analytics_id = models.IntegerField(primary_key=True)
    promotion_id = models.IntegerField()
    sales = models.DecimalField(max_digits=10, decimal_places=2)
    conversions = models.IntegerField()
    engagement = models.IntegerField()
    roi = models.DecimalField(max_digits=10, decimal_places=2)
    analytics_date = models.DateField()

class PromotionTargeting(models.Model):
    targeting_id = models.IntegerField(primary_key=True)
    promotion_id = models.IntegerField()
    target_type = models.CharField(max_length=255)
    target_details = models.JSONField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class PromotionABTesting(models.Model):
    test_id = models.IntegerField(primary_key=True)
    test_name = models.CharField(max_length=255)
    test_description = models.TextField()
    test_settings = models.JSONField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class PromotionContent(models.Model):
    content_id = models.IntegerField(primary_key=True)
    promotion_id = models.IntegerField()
    content_type = models.CharField(max_length=255)
    content_details = models.JSONField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class PromotionPersonalization(models.Model):
    personalization_id = models.IntegerField(primary_key=True)
    promotion_id = models.IntegerField()
    personalization_details = models.JSONField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class PromotionCollaborationHistory(models.Model):
    collaboration_id = models.IntegerField(primary_key=True)
    promotion_id = models.IntegerField()
    action = models.CharField(max_length=255)
    user_id = models.IntegerField()
    timestamp = models.DateTimeField()

class PromotionAutomation(models.Model):
    automation_id = models.IntegerField(primary_key=True)
    automation_name = models.CharField(max_length=255)
    automation_type = models.CharField(max_length=255)
    automation_details = models.JSONField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class PromotionIntegrations(models.Model):
    integration_id = models.IntegerField(primary_key=True)
    integration_name = models.CharField(max_length=255)
    integration_details = models.JSONField()
    enabled = models.BooleanField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
EOF

# Step 3: Register models with Django admin
cat <<EOF > MarketingAndPromotions/admin.py
from django.contrib import admin
from .models import (
    PromotionRules, PromotionCoupons, PromotionSegments, PromotionAnalytics,
    PromotionTargeting, PromotionABTesting, PromotionContent,
    PromotionPersonalization, PromotionCollaborationHistory,
    PromotionAutomation, PromotionIntegrations
)

@admin.register(PromotionRules)
class PromotionRulesAdmin(admin.ModelAdmin):
    list_display = ('rule_id', 'rule_name', 'rule_description', 'created_at', 'updated_at')
    search_fields = ('rule_name',)

@admin.register(PromotionCoupons)
class PromotionCouponsAdmin(admin.ModelAdmin):
    list_display = ('coupon_id', 'coupon_code', 'discount_type', 'discount_value', 'max_uses', 'uses_counter', 'expiration_date', 'created_at', 'updated_at')
    search_fields = ('coupon_code',)

@admin.register(PromotionSegments)
class PromotionSegmentsAdmin(admin.ModelAdmin):
    list_display = ('segment_id', 'segment_name', 'segment_criteria', 'created_at', 'updated_at')
    search_fields = ('segment_name',)

# Register other models similarly...

EOF

# Step 4: Create Django migrations
python manage.py makemigrations MarketingAndPromotions













# Step 1: Create Django app
python manage.py startapp AnalyticsAndReporting
sed -i "/INSTALLED_APPS = \[/a \ \ \ \ 'AnalyticsAndReporting'," $SETTINGS_FILE

# Step 2: Create Django models for each table

# Revenue Analytics model
cat <<EOF > AnalyticsAndReporting/models.py
from django.db import models

class RevenueAnalytics(models.Model):
    analytics_id = models.AutoField(primary_key=True)
    date = models.DateField()
    revenue = models.DecimalField(max_digits=10, decimal_places=2)
    profit = models.DecimalField(max_digits=10, decimal_places=2)
    sales_channels = models.JSONField()
    sales_by_region = models.JSONField()

class CustomerBehaviorAnalytics(models.Model):
    analytics_id = models.AutoField(primary_key=True)
    date = models.DateField()
    customer_acquisition = models.IntegerField()
    customer_retention = models.IntegerField()
    customer_lifetime_value = models.DecimalField(max_digits=10, decimal_places=2)
    customer_segments = models.JSONField()

class ProductPerformanceAnalytics(models.Model):
    analytics_id = models.AutoField(primary_key=True)
    date = models.DateField()
    product_views = models.IntegerField()
    product_purchases = models.IntegerField()
    product_feedback = models.JSONField()
    product_recommendations = models.JSONField()

class OrderFulfillmentAnalytics(models.Model):
    analytics_id = models.AutoField(primary_key=True)
    date = models.DateField()
    fulfillment_speed = models.DecimalField(max_digits=10, decimal_places=2)
    fulfillment_accuracy = models.DecimalField(max_digits=10, decimal_places=2)
    fulfillment_costs = models.DecimalField(max_digits=10, decimal_places=2)

class InventoryManagementAnalytics(models.Model):
    analytics_id = models.AutoField(primary_key=True)
    date = models.DateField()
    inventory_turnover = models.DecimalField(max_digits=10, decimal_places=2)
    inventory_age = models.DecimalField(max_digits=10, decimal_places=2)
    inventory_levels = models.JSONField()
    inventory_valuation = models.DecimalField(max_digits=10, decimal_places=2)

class MarketingCampaignAnalytics(models.Model):
    analytics_id = models.AutoField(primary_key=True)
    date = models.DateField()
    campaign_performance = models.JSONField()
    channel_effectiveness = models.JSONField()
    marketing_roi = models.DecimalField(max_digits=10, decimal_places=2)

class CustomerServiceAnalytics(models.Model):
    analytics_id = models.AutoField(primary_key=True)
    date = models.DateField()
    support_tickets = models.IntegerField()
    feedback_sentiment = models.JSONField()
    satisfaction_scores = models.JSONField()

class UserEngagementAnalytics(models.Model):
    analytics_id = models.AutoField(primary_key=True)
    date = models.DateField()
    user_activity = models.JSONField()
    user_retention = models.DecimalField(max_digits=10, decimal_places=2)
    churn_rate = models.DecimalField(max_digits=10, decimal_places=2)

class ConversionRateOptimizationAnalytics(models.Model):
    analytics_id = models.AutoField(primary_key=True)
    date = models.DateField()
    conversion_funnel = models.JSONField()
    ab_testing_results = models.JSONField()
    landing_page_performance = models.JSONField()

class FinancialReporting(models.Model):
    report_id = models.AutoField(primary_key=True)
    report_type = models.CharField(max_length=255)
    report_details = models.JSONField()
    generated_at = models.DateTimeField()

class DataVisualizationDashboards(models.Model):
    dashboard_id = models.AutoField(primary_key=True)
    dashboard_name = models.CharField(max_length=255)
    dashboard_content = models.JSONField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class CustomReporting(models.Model):
    report_id = models.AutoField(primary_key=True)
    report_name = models.CharField(max_length=255)
    report_details = models.JSONField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
EOF

# Step 3: Register models with Django admin
cat <<EOF > AnalyticsAndReporting/admin.py
from django.contrib import admin
from .models import (
    RevenueAnalytics, CustomerBehaviorAnalytics, ProductPerformanceAnalytics,
    OrderFulfillmentAnalytics, InventoryManagementAnalytics,
    MarketingCampaignAnalytics, CustomerServiceAnalytics,
    UserEngagementAnalytics, ConversionRateOptimizationAnalytics,
    FinancialReporting, DataVisualizationDashboards, CustomReporting
)

@admin.register(RevenueAnalytics)
class RevenueAnalyticsAdmin(admin.ModelAdmin):
    list_display = ('analytics_id', 'date', 'revenue', 'profit', 'sales_channels', 'sales_by_region')
    search_fields = ('date',)

@admin.register(CustomerBehaviorAnalytics)
class CustomerBehaviorAnalyticsAdmin(admin.ModelAdmin):
    list_display = ('analytics_id', 'date', 'customer_acquisition', 'customer_retention', 'customer_lifetime_value', 'customer_segments')
    search_fields = ('date',)

@admin.register(ProductPerformanceAnalytics)
class ProductPerformanceAnalyticsAdmin(admin.ModelAdmin):
    list_display = ('analytics_id', 'date', 'product_views', 'product_purchases', 'product_feedback', 'product_recommendations')
    search_fields = ('date',)

@admin.register(OrderFulfillmentAnalytics)
class OrderFulfillmentAnalyticsAdmin(admin.ModelAdmin):
    list_display = ('analytics_id', 'date', 'fulfillment_speed', 'fulfillment_accuracy', 'fulfillment_costs')
    search_fields = ('date',)

@admin.register(InventoryManagementAnalytics)
class InventoryManagementAnalyticsAdmin(admin.ModelAdmin):
    list_display = ('analytics_id', 'date', 'inventory_turnover', 'inventory_age', 'inventory_levels', 'inventory_valuation')
    search_fields = ('date',)

@admin.register(MarketingCampaignAnalytics)
class MarketingCampaignAnalyticsAdmin(admin.ModelAdmin):
    list_display = ('analytics_id', 'date', 'campaign_performance', 'channel_effectiveness', 'marketing_roi')
    search_fields = ('date',)

@admin.register(CustomerServiceAnalytics)
class CustomerServiceAnalyticsAdmin(admin.ModelAdmin):
    list_display = ('analytics_id', 'date', 'support_tickets', 'feedback_sentiment', 'satisfaction_scores')
    search_fields = ('date',)

@admin.register(UserEngagementAnalytics)
class UserEngagementAnalyticsAdmin(admin.ModelAdmin):
    list_display = ('analytics_id', 'date', 'user_activity', 'user_retention', 'churn_rate')
    search_fields = ('date',)

@admin.register(ConversionRateOptimizationAnalytics)
class ConversionRateOptimizationAnalyticsAdmin(admin.ModelAdmin):
    list_display = ('analytics_id', 'date', 'conversion_funnel', 'ab_testing_results', 'landing_page_performance')
    search_fields = ('date',)

@admin.register(FinancialReporting)
class FinancialReportingAdmin(admin.ModelAdmin):
    list_display = ('report_id', 'report_type', 'report_details', 'generated_at')
    search_fields = ('report_type',)

@admin.register(DataVisualizationDashboards)
class DataVisualizationDashboardsAdmin(admin.ModelAdmin):
    list_display = ('dashboard_id', 'dashboard_name', 'dashboard_content', 'created_at', 'updated_at')
    search_fields = ('dashboard_name',)

@admin.register(CustomReporting)
class CustomReportingAdmin(admin.ModelAdmin):
    list_display = ('report_id', 'report_name', 'report_details', 'created_at', 'updated_at')
    search_fields = ('report_name',)

EOF

# Step 4: Create Django migrations
python manage.py makemigrations AnalyticsAndReporting





# Step 4: Apply migrations
python manage.py migrate



# Deactivate the virtual environment
deactivate

echo "Setup is complete. Activate your virtual environment with 'source khukumoni_env/bin/activate' and run the server with 'python manage.py runserver'."
