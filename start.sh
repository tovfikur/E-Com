#!/bin/bash


# Colors
GREEN='\033[0;32m'  # Green color
RED='\033[0;31m'    # Red color
NC='\033[0m'        # No color (default)

# Symbols
CHECK_MARK='\xE2\x9C\x94'  # Check mark symbol
CROSS_MARK='\xE2\x9D\x8C'   # Cross mark symbol
# Function to print a centered, bold, and large header

function print_header() {
  text="$1" 
  tput bold;
  num_cols=$(tput cols); 
  padding=$(( (num_cols - ${#text}) / 2 ));
  for ((i=0; i<$padding; i++)); do
    printf " ";
  done
  printf "%s\n" "$text"
  tput sgr0;
}

# Step 1: Create a Python virtual environment
python3 -m venv .env

# Step 2: Activate the virtual environment
source .env/bin/activate

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


echo "


admin.site.site_header = 'Khukumoni Administration'
admin.site.site_title = 'Khukumoni Admin Portal'
admin.site.index_title = 'Welcome to Khukumoni Admin Area'
"  >> $URLS_FILE


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



## Frontend App ##

# Step 1: Create Django app
python manage.py startapp frontend
sed -i "/INSTALLED_APPS = \[/a \ \ \ \ 'frontend'," $SETTINGS_FILE



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
    Brand, Category, Product, Variant, Image, Video, Pricing, Discount
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
admin.site.register(Variant, VariantAdmin)
admin.site.register(Image, ImageAdmin)
admin.site.register(Video, VideoAdmin)
admin.site.register(Pricing, PricingAdmin)
admin.site.register(Discount, DiscountAdmin)
EOF


# Step 4: Create Django migrations
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

# Step 3: Create Django admin registration for InventoryManagement models
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

# Step 4: Create Django migrations
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

# Step 4: Create Django migrations
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
    list_display = (Order, 'product', 'quantity', 'unit_price', 'total_price')
    search_fields = ('order__id', 'product__name')
    list_filter = ('order__order_date',)

class ShipmentAdmin(admin.ModelAdmin):
    list_display = (Order, 'shipping_method', 'tracking_number', 'shipping_date', 'delivery_date')
    search_fields = ('order__id', 'shipping_method', 'tracking_number')
    list_filter = ('shipping_date', 'delivery_date')

class ReturnAdmin(admin.ModelAdmin):
    list_display = (Order, 'return_reason', 'return_status', 'return_date')
    search_fields = ('order__id', 'return_status')
    list_filter = ('return_status', 'return_date')

class RefundAdmin(admin.ModelAdmin):
    list_display = (Order, 'refund_amount', 'refund_reason', 'refund_status', 'refund_date')
    search_fields = ('order__id', 'refund_status')
    list_filter = ('refund_status', 'refund_date')

class OrderCommunicationAdmin(admin.ModelAdmin):
    list_display = (Order, 'recipient_email', 'subject', 'sent_at')
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
# Step 4: Create Django migrations
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


## Creating Shipping and fullfillment app ##

# Step 1: Create Django app
python manage.py startapp ShippingAndFulfillment
sed -i "/INSTALLED_APPS = \[/a \ \ \ \ 'ShippingAndFulfillment'," $SETTINGS_FILE

# Step 2: Create Django models for each table

# Shipping Addresses model
cat <<EOF > ShippingAndFulfillment/models.py
from django.db import models
from CustomerManagement.models import Customer
from OrderManagement.models import Order


class ShippingAddress(models.Model):
    address_id = models.AutoField(primary_key=True)
    recipient_name = models.CharField(max_length=255)
    street_address = models.CharField(max_length=255)
    city = models.CharField(max_length=255)
    state = models.CharField(max_length=255)
    postal_code = models.CharField(max_length=20)
    country = models.CharField(max_length=255)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class ShippingLabel(models.Model):
    label_id = models.AutoField(primary_key=True)
    order_id = models.ForeignKey(Order, on_delete=models.CASCADE)
    label_type = models.CharField(max_length=255)
    label_url = models.CharField(max_length=255)
    customization_settings = models.JSONField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class PackageTracking(models.Model):
    tracking_id = models.AutoField(primary_key=True)
    order_id = models.ForeignKey(Order, on_delete=models.CASCADE)
    tracking_number = models.CharField(max_length=255)
    carrier_id = models.ForeignKey('ShippingCarrier', on_delete=models.CASCADE)
    status = models.CharField(max_length=255)
    tracking_updates = models.JSONField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class ShippingCarrier(models.Model):
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

class ShippingZone(models.Model):
    zone_id = models.AutoField(primary_key=True)
    name = models.CharField(max_length=255)
    description = models.CharField(max_length=255)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class ShippingPreference(models.Model):
    preference_id = models.AutoField(primary_key=True)
    preference_name = models.CharField(max_length=255)
    preference_value = models.JSONField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class ShippingNotification(models.Model):
    notification_id = models.AutoField(primary_key=True)
    order_id = models.ForeignKey(Order, on_delete=models.CASCADE)
    enabled = models.BooleanField(default=True)
    email = models.EmailField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class DeliverySchedule(models.Model):
    schedule_id = models.AutoField(primary_key=True)
    order_id = models.ForeignKey(Order, on_delete=models.CASCADE)
    delivery_date = models.DateField()
    delivery_time = models.TimeField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class Location(models.Model):
    location_id = models.AutoField(primary_key=True)
    name = models.CharField(max_length=255)
    address_id = models.ForeignKey('ShippingAddress', on_delete=models.CASCADE)
    location_type = models.CharField(max_length=255)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class ShippingCost(models.Model):
    cost_id = models.AutoField(primary_key=True)
    order_id = models.ForeignKey(Order, on_delete=models.CASCADE)
    cost = models.DecimalField(max_digits=10, decimal_places=2)
    estimation_method = models.CharField(max_length=255)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class ShippingRestriction(models.Model):
    restriction_id = models.AutoField(primary_key=True)
    description = models.CharField(max_length=255)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class OrderRestriction(models.Model):
    order_id = models.ForeignKey(Order, on_delete=models.CASCADE)
    restriction_id = models.ForeignKey('ShippingRestriction', on_delete=models.CASCADE)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

EOF


# Step 3: Register models with Django admin
cat <<EOF > ShippingAndFulfillment/admin.py
from django.contrib import admin
from .models import (
    ShippingAddress, ShippingLabel, PackageTracking,
    ShippingCarrier, ShippingInsurance, ShippingZone, ShippingPreference,
    ShippingNotification, DeliverySchedule, Location, ShippingCost,
    ShippingRestriction, OrderRestriction
)


@admin.register(ShippingAddress)
class ShippingAddressAdmin(admin.ModelAdmin):
    list_display = ('address_id', 'recipient_name', 'street_address', 'city', 'state', 'postal_code', 'country', 'created_at', 'updated_at')
    search_fields = ('recipient_name', 'street_address', 'city', 'state', 'postal_code', 'country')

@admin.register(ShippingLabel)
class ShippingLabelAdmin(admin.ModelAdmin):
    list_display = ('label_id', 'order_id', 'label_type', 'label_url', 'created_at', 'updated_at')
    search_fields = ('label_type',)

@admin.register(PackageTracking)
class PackageTrackingAdmin(admin.ModelAdmin):
    list_display = ('tracking_id', 'order_id', 'tracking_number', 'carrier_id', 'status', 'created_at', 'updated_at')
    search_fields = ('tracking_number', 'status')

@admin.register(ShippingCarrier)
class ShippingCarrierAdmin(admin.ModelAdmin):
    list_display = ('carrier_id', 'carrier_name', 'created_at', 'updated_at')
    search_fields = ('carrier_name',)

@admin.register(ShippingInsurance)
class ShippingInsuranceAdmin(admin.ModelAdmin):
    list_display = ('insurance_id', 'order_id', 'coverage_amount', 'claim_status', 'created_at', 'updated_at')
    search_fields = ('claim_status',)

@admin.register(ShippingZone)
class ShippingZoneAdmin(admin.ModelAdmin):
    list_display = ('zone_id', 'name', 'description', 'created_at', 'updated_at')
    search_fields = ('name', 'description')

@admin.register(ShippingPreference)
class ShippingPreferenceAdmin(admin.ModelAdmin):
    list_display = ('preference_id', 'preference_name', 'preference_value', 'created_at', 'updated_at')
    search_fields = ('preference_name',)

@admin.register(ShippingNotification)
class ShippingNotificationAdmin(admin.ModelAdmin):
    list_display = ('notification_id', 'order_id', 'enabled', 'email', 'created_at', 'updated_at')
    search_fields = ('email',)

@admin.register(DeliverySchedule)
class DeliveryScheduleAdmin(admin.ModelAdmin):
    list_display = ('schedule_id', 'order_id', 'delivery_date', 'delivery_time', 'created_at', 'updated_at')
    search_fields = ('delivery_date', 'delivery_time')

@admin.register(Location)
class LocationAdmin(admin.ModelAdmin):
    list_display = ('location_id', 'name', 'address_id', 'location_type', 'created_at', 'updated_at')
    search_fields = ('name', 'location_type')

@admin.register(ShippingCost)
class ShippingCostAdmin(admin.ModelAdmin):
    list_display = ('cost_id', 'order_id', 'cost', 'estimation_method', 'created_at', 'updated_at')
    search_fields = ('estimation_method',)

@admin.register(ShippingRestriction)
class ShippingRestrictionAdmin(admin.ModelAdmin):
    list_display = ('restriction_id', 'description', 'created_at', 'updated_at')
    search_fields = ('description',)

@admin.register(OrderRestriction)
class OrderRestrictionAdmin(admin.ModelAdmin):
    list_display = ('order_id', 'restriction_id', 'created_at', 'updated_at')
    search_fields = ('order_id',)

EOF

# Step 4: Create Django migrations
python manage.py makemigrations ShippingAndFulfillment



## Creating Search and filtering app ##

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



## Creating Markeign and promotions app##

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
    search_fields = ('rule_name', 'rule_description')

@admin.register(PromotionCoupons)
class PromotionCouponsAdmin(admin.ModelAdmin):
    list_display = ('coupon_id', 'coupon_code', 'discount_type', 'discount_value', 'max_uses', 'uses_counter', 'expiration_date', 'created_at', 'updated_at')
    search_fields = ('coupon_code',)

@admin.register(PromotionSegments)
class PromotionSegmentsAdmin(admin.ModelAdmin):
    list_display = ('segment_id', 'segment_name', 'created_at', 'updated_at')
    search_fields = ('segment_name',)

@admin.register(PromotionAnalytics)
class PromotionAnalyticsAdmin(admin.ModelAdmin):
    list_display = ('analytics_id', 'promotion_id', 'sales', 'conversions', 'engagement', 'roi', 'analytics_date')
    search_fields = ('promotion_id',)

@admin.register(PromotionTargeting)
class PromotionTargetingAdmin(admin.ModelAdmin):
    list_display = ('targeting_id', 'promotion_id', 'target_type', 'created_at', 'updated_at')
    search_fields = ('promotion_id',)

@admin.register(PromotionABTesting)
class PromotionABTestingAdmin(admin.ModelAdmin):
    list_display = ('test_id', 'test_name', 'test_description', 'created_at', 'updated_at')
    search_fields = ('test_name',)

@admin.register(PromotionContent)
class PromotionContentAdmin(admin.ModelAdmin):
    list_display = ('content_id', 'promotion_id', 'content_type', 'created_at', 'updated_at')
    search_fields = ('promotion_id',)

@admin.register(PromotionPersonalization)
class PromotionPersonalizationAdmin(admin.ModelAdmin):
    list_display = ('personalization_id', 'promotion_id', 'created_at', 'updated_at')
    search_fields = ('promotion_id',)

@admin.register(PromotionCollaborationHistory)
class PromotionCollaborationHistoryAdmin(admin.ModelAdmin):
    list_display = ('collaboration_id', 'promotion_id', 'action', 'user_id', 'timestamp')
    search_fields = ('promotion_id',)

@admin.register(PromotionAutomation)
class PromotionAutomationAdmin(admin.ModelAdmin):
    list_display = ('automation_id', 'automation_name', 'automation_type', 'created_at', 'updated_at')
    search_fields = ('automation_name',)

@admin.register(PromotionIntegrations)
class PromotionIntegrationsAdmin(admin.ModelAdmin):
    list_display = ('integration_id', 'integration_name', 'enabled', 'created_at', 'updated_at')
    search_fields = ('integration_name',)

EOF

# Step 4: Create Django migrations
python manage.py makemigrations MarketingAndPromotions



## Creating Analytics and Reporting app ##

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


## Creating Wishlist Management ##

# Step 1: Create Django app
python manage.py startapp WishlistManagement

# Add the new app to INSTALLED_APPS in settings.py
sed -i "/INSTALLED_APPS = \[/a \ \ \ \ 'WishlistManagement'," $SETTINGS_FILE

# Step 2: Create Django models for each table

# Wishlist models
cat <<EOF > WishlistManagement/models.py
from django.db import models

class Wishlist(models.Model):
    wishlist_id = models.AutoField(primary_key=True)
    user_id = models.IntegerField()
    name = models.CharField(max_length=255)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    privacy_setting = models.CharField(max_length=20)

class WishlistItem(models.Model):
    item_id = models.AutoField(primary_key=True)
    wishlist_id = models.ForeignKey(Wishlist, on_delete=models.CASCADE)
    product_id = models.IntegerField()
    added_at = models.DateTimeField(auto_now_add=True)

class WishlistSharing(models.Model):
    share_id = models.AutoField(primary_key=True)
    wishlist_id = models.ForeignKey(Wishlist, on_delete=models.CASCADE)
    shared_with = models.CharField(max_length=255)
    shared_at = models.DateTimeField(auto_now_add=True)

class WishlistPrivacy(models.Model):
    privacy_id = models.AutoField(primary_key=True)
    wishlist_id = models.ForeignKey(Wishlist, on_delete=models.CASCADE)
    setting = models.CharField(max_length=20)
    updated_at = models.DateTimeField(auto_now=True)

class WishlistNotification(models.Model):
    notification_id = models.AutoField(primary_key=True)
    wishlist_id = models.ForeignKey(Wishlist, on_delete=models.CASCADE)
    user_id = models.IntegerField()
    subscribed = models.BooleanField(default=False)
    subscribed_at = models.DateTimeField(auto_now_add=True)

class WishlistCollaborator(models.Model):
    collaboration_id = models.AutoField(primary_key=True)
    wishlist_id = models.ForeignKey(Wishlist, on_delete=models.CASCADE)
    collaborator_id = models.IntegerField()
    role = models.CharField(max_length=20)
    status = models.CharField(max_length=20)
    invited_at = models.DateTimeField(auto_now_add=True)
    accepted_at = models.DateTimeField(null=True, blank=True)

class WishlistNote(models.Model):
    note_id = models.AutoField(primary_key=True)
    wishlist_id = models.ForeignKey(Wishlist, on_delete=models.CASCADE)
    item_id = models.ForeignKey(WishlistItem, on_delete=models.CASCADE)
    note = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class WishlistRating(models.Model):
    rating_id = models.AutoField(primary_key=True)
    wishlist_id = models.ForeignKey(Wishlist, on_delete=models.CASCADE)
    item_id = models.ForeignKey(WishlistItem, on_delete=models.CASCADE)
    rating = models.IntegerField()
    rated_at = models.DateTimeField(auto_now_add=True)

class WishlistReview(models.Model):
    review_id = models.AutoField(primary_key=True)
    wishlist_id = models.ForeignKey(Wishlist, on_delete=models.CASCADE)
    item_id = models.ForeignKey(WishlistItem, on_delete=models.CASCADE)
    review = models.TextField()
    reviewed_at = models.DateTimeField(auto_now_add=True)

class WishlistImportExport(models.Model):
    operation_id = models.AutoField(primary_key=True)
    wishlist_id = models.ForeignKey(Wishlist, on_delete=models.CASCADE)
    operation_type = models.CharField(max_length=20)
    status = models.CharField(max_length=20)
    created_at = models.DateTimeField(auto_now_add=True)
    completed_at = models.DateTimeField(null=True, blank=True)

class WishlistRecommendation(models.Model):
    recommendation_id = models.AutoField(primary_key=True)
    wishlist_id = models.ForeignKey(Wishlist, on_delete=models.CASCADE)
    recommendations = models.JSONField()
    generated_at = models.DateTimeField(auto_now_add=True)

class WishlistAnalytics(models.Model):
    analytics_id = models.AutoField(primary_key=True)
    wishlist_id = models.ForeignKey(Wishlist, on_delete=models.CASCADE)
    views = models.IntegerField()
    engagement = models.IntegerField()
    conversion_rate = models.DecimalField(max_digits=10, decimal_places=2)
    updated_at = models.DateTimeField(auto_now=True)

class WishlistSetting(models.Model):
    setting_id = models.AutoField(primary_key=True)
    wishlist_id = models.ForeignKey(Wishlist, on_delete=models.CASCADE)
    settings = models.JSONField()
    updated_at = models.DateTimeField(auto_now=True)

class WishlistSync(models.Model):
    sync_id = models.AutoField(primary_key=True)
    user_id = models.IntegerField()
    devices = models.JSONField()
    last_synced_at = models.DateTimeField(auto_now=True)

class WishlistBackupRestore(models.Model):
    backup_restore_id = models.AutoField(primary_key=True)
    wishlist_id = models.ForeignKey(Wishlist, on_delete=models.CASCADE)
    operation_type = models.CharField(max_length=20)
    status = models.CharField(max_length=20)
    created_at = models.DateTimeField(auto_now_add=True)
    completed_at = models.DateTimeField(null=True, blank=True)
EOF

# Step 3: Register models with Django admin
cat <<EOF > WishlistManagement/admin.py
from django.contrib import admin
from .models import (
    Wishlist, WishlistItem, WishlistSharing, WishlistPrivacy, WishlistNotification, 
    WishlistCollaborator, WishlistNote, WishlistRating, WishlistReview, 
    WishlistImportExport, WishlistRecommendation, WishlistAnalytics, WishlistSetting, 
    WishlistSync, WishlistBackupRestore
)

class WishlistAdmin(admin.ModelAdmin):
    list_display = ('wishlist_id', 'user_id', 'name', 'privacy_setting', 'created_at', 'updated_at')
    search_fields = ('name', 'user_id')
    list_filter = ('privacy_setting',)

class WishlistItemAdmin(admin.ModelAdmin):
    list_display = ('item_id', 'wishlist_id', 'product_id', 'added_at')
    search_fields = ('wishlist_id', 'product_id')

class WishlistSharingAdmin(admin.ModelAdmin):
    list_display = ('share_id', 'wishlist_id', 'shared_with', 'shared_at')
    search_fields = ('wishlist_id', 'shared_with')

class WishlistPrivacyAdmin(admin.ModelAdmin):
    list_display = ('privacy_id', 'wishlist_id', 'setting', 'updated_at')
    search_fields = ('wishlist_id', 'setting')

class WishlistNotificationAdmin(admin.ModelAdmin):
    list_display = ('notification_id', 'wishlist_id', 'user_id', 'subscribed', 'subscribed_at')
    search_fields = ('wishlist_id', 'user_id')

class WishlistCollaboratorAdmin(admin.ModelAdmin):
    list_display = ('collaboration_id', 'wishlist_id', 'collaborator_id', 'role', 'status', 'invited_at', 'accepted_at')
    search_fields = ('wishlist_id', 'collaborator_id', 'role', 'status')

class WishlistNoteAdmin(admin.ModelAdmin):
    list_display = ('note_id', 'wishlist_id', 'item_id', 'note', 'created_at', 'updated_at')
    search_fields = ('wishlist_id', 'item_id')

class WishlistRatingAdmin(admin.ModelAdmin):
    list_display = ('rating_id', 'wishlist_id', 'item_id', 'rating', 'rated_at')
    search_fields = ('wishlist_id', 'item_id')

class WishlistReviewAdmin(admin.ModelAdmin):
    list_display = ('review_id', 'wishlist_id', 'item_id', 'review', 'reviewed_at')
    search_fields = ('wishlist_id', 'item_id')

class WishlistImportExportAdmin(admin.ModelAdmin):
    list_display = ('operation_id', 'wishlist_id', 'operation_type', 'status', 'created_at', 'completed_at')
    search_fields = ('wishlist_id', 'operation_type')

class WishlistRecommendationAdmin(admin.ModelAdmin):
    list_display = ('recommendation_id', 'wishlist_id', 'recommendations', 'generated_at')
    search_fields = ('wishlist_id',)

class WishlistAnalyticsAdmin(admin.ModelAdmin):
    list_display = ('analytics_id', 'wishlist_id', 'views', 'engagement', 'conversion_rate', 'updated_at')
    search_fields = ('wishlist_id',)

class WishlistSettingAdmin(admin.ModelAdmin):
    list_display = ('setting_id', 'wishlist_id', 'settings', 'updated_at')
    search_fields = ('wishlist_id',)

class WishlistSyncAdmin(admin.ModelAdmin):
    list_display = ('sync_id', 'user_id', 'devices', 'last_synced_at')
    search_fields = ('user_id',)

class WishlistBackupRestoreAdmin(admin.ModelAdmin):
    list_display = ('backup_restore_id', 'wishlist_id', 'operation_type', 'status', 'created_at', 'completed_at')
    search_fields = ('wishlist_id', 'operation_type')

admin.site.register(Wishlist, WishlistAdmin)
admin.site.register(WishlistItem, WishlistItemAdmin)
admin.site.register(WishlistSharing, WishlistSharingAdmin)
admin.site.register(WishlistPrivacy, WishlistPrivacyAdmin)
admin.site.register(WishlistNotification, WishlistNotificationAdmin)
admin.site.register(WishlistCollaborator, WishlistCollaboratorAdmin)
admin.site.register(WishlistNote, WishlistNoteAdmin)
admin.site.register(WishlistRating, WishlistRatingAdmin)
admin.site.register(WishlistReview, WishlistReviewAdmin)
admin.site.register(WishlistImportExport, WishlistImportExportAdmin)
admin.site.register(WishlistRecommendation, WishlistRecommendationAdmin)
admin.site.register(WishlistAnalytics, WishlistAnalyticsAdmin)
admin.site.register(WishlistSetting, WishlistSettingAdmin)
admin.site.register(WishlistSync, WishlistSyncAdmin)
admin.site.register(WishlistBackupRestore, WishlistBackupRestoreAdmin)
EOF

# Step 4: Create Django migrations
python manage.py makemigrations WishlistManagement



## Creating Review and Ratings app ##

# Step 1: Create Django app
python manage.py startapp ReviewsAndRatings

# Add the new app to INSTALLED_APPS in settings.py
sed -i "/INSTALLED_APPS = \[/a \ \ \ \ 'ReviewsAndRatings'," $SETTINGS_FILE

# Step 2: Create Django models for each table

# Reviews and Ratings models
cat <<EOF > ReviewsAndRatings/models.py
from django.db import models

class Review(models.Model):
    review_id = models.AutoField(primary_key=True)
    product_id = models.IntegerField()
    user_id = models.IntegerField()
    rating = models.IntegerField()
    review_text = models.TextField()
    status = models.CharField(max_length=20)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class ReviewReply(models.Model):
    reply_id = models.AutoField(primary_key=True)
    review_id = models.ForeignKey(Review, on_delete=models.CASCADE)
    user_id = models.IntegerField()
    reply_text = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class ReviewFilter(models.Model):
    filter_id = models.AutoField(primary_key=True)
    criteria = models.CharField(max_length=255)
    sort_order = models.CharField(max_length=20)
    created_at = models.DateTimeField(auto_now_add=True)

class ReviewReport(models.Model):
    report_id = models.AutoField(primary_key=True)
    review_id = models.ForeignKey(Review, on_delete=models.CASCADE)
    report_reason = models.CharField(max_length=255)
    status = models.CharField(max_length=20)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class ReviewNotification(models.Model):
    notification_id = models.AutoField(primary_key=True)
    user_id = models.IntegerField()
    subscribed = models.BooleanField(default=False)
    created_at = models.DateTimeField(auto_now_add=True)

class ReviewAnalytics(models.Model):
    analytics_id = models.AutoField(primary_key=True)
    review_id = models.ForeignKey(Review, on_delete=models.CASCADE)
    views = models.IntegerField()
    engagement = models.IntegerField()
    sentiment = models.CharField(max_length=255)
    trend = models.CharField(max_length=255)
    updated_at = models.DateTimeField(auto_now=True)

class ReviewImportExport(models.Model):
    operation_id = models.AutoField(primary_key=True)
    operation_type = models.CharField(max_length=20)
    date_range = models.CharField(max_length=255)
    status = models.CharField(max_length=20)
    created_at = models.DateTimeField(auto_now_add=True)
    completed_at = models.DateTimeField(null=True, blank=True)

class ReviewResponseTemplate(models.Model):
    template_id = models.AutoField(primary_key=True)
    template_name = models.CharField(max_length=255)
    template_text = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class ReviewAggregation(models.Model):
    aggregation_id = models.AutoField(primary_key=True)
    product_id = models.IntegerField()
    summary = models.TextField()
    sentiment = models.CharField(max_length=255)
    trends = models.TextField()
    updated_at = models.DateTimeField(auto_now=True)

class ReviewIntegration(models.Model):
    integration_id = models.AutoField(primary_key=True)
    platform_name = models.CharField(max_length=255)
    details = models.JSONField()
    status = models.CharField(max_length=20)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class ReviewGamification(models.Model):
    gamification_id = models.AutoField(primary_key=True)
    settings = models.JSONField()
    leaderboard = models.JSONField()
    rewards = models.JSONField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class ReviewAuthentication(models.Model):
    auth_id = models.AutoField(primary_key=True)
    review_id = models.ForeignKey(Review, on_delete=models.CASCADE)
    verification_token = models.CharField(max_length=255)
    status = models.CharField(max_length=20)
    created_at = models.DateTimeField(auto_now_add=True)
    verified_at = models.DateTimeField(null=True, blank=True)
EOF

# Step 3: Register models with Django admin
cat <<EOF > ReviewsAndRatings/admin.py
from django.contrib import admin
from .models import (
    Review, ReviewReply, ReviewFilter, ReviewReport, ReviewNotification, 
    ReviewAnalytics, ReviewImportExport, ReviewResponseTemplate, ReviewAggregation, 
    ReviewIntegration, ReviewGamification, ReviewAuthentication
)

class ReviewAdmin(admin.ModelAdmin):
    list_display = ('review_id', 'product_id', 'user_id', 'rating', 'status', 'created_at', 'updated_at')
    search_fields = ('product_id', 'user_id', 'status')
    list_filter = ('status',)

class ReviewReplyAdmin(admin.ModelAdmin):
    list_display = ('reply_id', 'review_id', 'user_id', 'reply_text', 'created_at', 'updated_at')
    search_fields = ('review_id', 'user_id')

class ReviewFilterAdmin(admin.ModelAdmin):
    list_display = ('filter_id', 'criteria', 'sort_order', 'created_at')
    search_fields = ('criteria',)

class ReviewReportAdmin(admin.ModelAdmin):
    list_display = ('report_id', 'review_id', 'report_reason', 'status', 'created_at', 'updated_at')
    search_fields = ('review_id', 'status')
    list_filter = ('status',)

class ReviewNotificationAdmin(admin.ModelAdmin):
    list_display = ('notification_id', 'user_id', 'subscribed', 'created_at')
    search_fields = ('user_id',)

class ReviewAnalyticsAdmin(admin.ModelAdmin):
    list_display = ('analytics_id', 'review_id', 'views', 'engagement', 'sentiment', 'trend', 'updated_at')
    search_fields = ('review_id',)

class ReviewImportExportAdmin(admin.ModelAdmin):
    list_display = ('operation_id', 'operation_type', 'date_range', 'status', 'created_at', 'completed_at')
    search_fields = ('operation_type', 'status')

class ReviewResponseTemplateAdmin(admin.ModelAdmin):
    list_display = ('template_id', 'template_name', 'template_text', 'created_at', 'updated_at')
    search_fields = ('template_name',)

class ReviewAggregationAdmin(admin.ModelAdmin):
    list_display = ('aggregation_id', 'product_id', 'summary', 'sentiment', 'trends', 'updated_at')
    search_fields = ('product_id', 'sentiment')

class ReviewIntegrationAdmin(admin.ModelAdmin):
    list_display = ('integration_id', 'platform_name', 'details', 'status', 'created_at', 'updated_at')
    search_fields = ('platform_name', 'status')

class ReviewGamificationAdmin(admin.ModelAdmin):
    list_display = ('gamification_id', 'settings', 'leaderboard', 'rewards', 'created_at', 'updated_at')
    search_fields = ('settings',)

class ReviewAuthenticationAdmin(admin.ModelAdmin):
    list_display = ('auth_id', 'review_id', 'verification_token', 'status', 'created_at', 'verified_at')
    search_fields = ('review_id', 'status')

admin.site.register(Review, ReviewAdmin)
admin.site.register(ReviewReply, ReviewReplyAdmin)
admin.site.register(ReviewFilter, ReviewFilterAdmin)
admin.site.register(ReviewReport, ReviewReportAdmin)
admin.site.register(ReviewNotification, ReviewNotificationAdmin)
admin.site.register(ReviewAnalytics, ReviewAnalyticsAdmin)
admin.site.register(ReviewImportExport, ReviewImportExportAdmin)
admin.site.register(ReviewResponseTemplate, ReviewResponseTemplateAdmin)
admin.site.register(ReviewAggregation, ReviewAggregationAdmin)
admin.site.register(ReviewIntegration, ReviewIntegrationAdmin)
admin.site.register(ReviewGamification, ReviewGamificationAdmin)
admin.site.register(ReviewAuthentication, ReviewAuthenticationAdmin)
EOF

# Step 4: Create Django migrations
python manage.py makemigrations ReviewsAndRatings


## Creating Recommendation app ##

# Step 1: Create Django app
python manage.py startapp Recommendations

# Add the new app to INSTALLED_APPS in settings.py
sed -i "/INSTALLED_APPS = \[/a \ \ \ \ 'Recommendations'," $SETTINGS_FILE

# Step 2: Create Django models for each table

# Recommendations models
cat <<EOF > Recommendations/models.py
from django.db import models

class PersonalizedRecommendation(models.Model):
    recommendation_id = models.AutoField(primary_key=True)
    customer_id = models.IntegerField()
    product_ids = models.JSONField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class SimilarProduct(models.Model):
    recommendation_id = models.AutoField(primary_key=True)
    product_id = models.IntegerField()
    similar_product_ids = models.JSONField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class TrendingProduct(models.Model):
    recommendation_id = models.AutoField(primary_key=True)
    product_ids = models.JSONField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class NewArrival(models.Model):
    recommendation_id = models.AutoField(primary_key=True)
    category_id = models.IntegerField()
    product_ids = models.JSONField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class Bestseller(models.Model):
    recommendation_id = models.AutoField(primary_key=True)
    category_id = models.IntegerField()
    product_ids = models.JSONField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class CrossSellProduct(models.Model):
    recommendation_id = models.AutoField(primary_key=True)
    product_id = models.IntegerField()
    cross_sell_product_ids = models.JSONField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class UpSellProduct(models.Model):
    recommendation_id = models.AutoField(primary_key=True)
    product_id = models.IntegerField()
    up_sell_product_ids = models.JSONField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class FrequentlyBoughtTogether(models.Model):
    recommendation_id = models.AutoField(primary_key=True)
    product_id = models.IntegerField()
    frequently_bought_together_product_ids = models.JSONField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class CustomerBasedRecommendation(models.Model):
    recommendation_id = models.AutoField(primary_key=True)
    customer_id = models.IntegerField()
    product_ids = models.JSONField()
    recommendation_type = models.CharField(max_length=50)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class DynamicPricingRecommendation(models.Model):
    recommendation_id = models.AutoField(primary_key=True)
    customer_id = models.IntegerField()
    product_ids = models.JSONField()
    pricing_details = models.JSONField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class RecommendationRule(models.Model):
    rule_id = models.AutoField(primary_key=True)
    rule_details = models.JSONField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class RealTimeRecommendationUpdate(models.Model):
    update_id = models.AutoField(primary_key=True)
    customer_id = models.IntegerField()
    product_ids = models.JSONField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class SegmentBasedRecommendation(models.Model):
    segment_id = models.AutoField(primary_key=True)
    product_ids = models.JSONField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class FeedbackRecommendation(models.Model):
    feedback_id = models.AutoField(primary_key=True)
    product_id = models.IntegerField()
    feedback_details = models.JSONField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class RecommendationPerformanceAnalytics(models.Model):
    analytics_id = models.AutoField(primary_key=True)
    product_id = models.IntegerField()
    views = models.IntegerField()
    conversions = models.IntegerField()
    click_through_rate = models.FloatField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class CustomerSpecificRecommendation(models.Model):
    recommendation_id = models.AutoField(primary_key=True)
    customer_id = models.IntegerField()
    product_ids = models.JSONField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
EOF

# Step 3: Register models with Django admin
cat <<EOF > Recommendations/admin.py
from django.contrib import admin
from .models import (
    PersonalizedRecommendation, SimilarProduct, TrendingProduct, NewArrival, Bestseller, 
    CrossSellProduct, UpSellProduct, FrequentlyBoughtTogether, CustomerBasedRecommendation, 
    DynamicPricingRecommendation, RecommendationRule, RealTimeRecommendationUpdate, 
    SegmentBasedRecommendation, FeedbackRecommendation, RecommendationPerformanceAnalytics, 
    CustomerSpecificRecommendation
)

class PersonalizedRecommendationAdmin(admin.ModelAdmin):
    list_display = ('recommendation_id', 'customer_id', 'created_at', 'updated_at')
    search_fields = ('customer_id',)

class SimilarProductAdmin(admin.ModelAdmin):
    list_display = ('recommendation_id', 'product_id', 'created_at', 'updated_at')
    search_fields = ('product_id',)

class TrendingProductAdmin(admin.ModelAdmin):
    list_display = ('recommendation_id', 'created_at', 'updated_at')

class NewArrivalAdmin(admin.ModelAdmin):
    list_display = ('recommendation_id', 'category_id', 'created_at', 'updated_at')
    search_fields = ('category_id',)

class BestsellerAdmin(admin.ModelAdmin):
    list_display = ('recommendation_id', 'category_id', 'created_at', 'updated_at')
    search_fields = ('category_id',)

class CrossSellProductAdmin(admin.ModelAdmin):
    list_display = ('recommendation_id', 'product_id', 'created_at', 'updated_at')
    search_fields = ('product_id',)

class UpSellProductAdmin(admin.ModelAdmin):
    list_display = ('recommendation_id', 'product_id', 'created_at', 'updated_at')
    search_fields = ('product_id',)

class FrequentlyBoughtTogetherAdmin(admin.ModelAdmin):
    list_display = ('recommendation_id', 'product_id', 'created_at', 'updated_at')
    search_fields = ('product_id',)

class CustomerBasedRecommendationAdmin(admin.ModelAdmin):
    list_display = ('recommendation_id', 'customer_id', 'recommendation_type', 'created_at', 'updated_at')
    search_fields = ('customer_id', 'recommendation_type')

class DynamicPricingRecommendationAdmin(admin.ModelAdmin):
    list_display = ('recommendation_id', 'customer_id', 'created_at', 'updated_at')
    search_fields = ('customer_id',)

class RecommendationRuleAdmin(admin.ModelAdmin):
    list_display = ('rule_id', 'created_at', 'updated_at')

class RealTimeRecommendationUpdateAdmin(admin.ModelAdmin):
    list_display = ('update_id', 'customer_id', 'created_at', 'updated_at')
    search_fields = ('customer_id',)

class SegmentBasedRecommendationAdmin(admin.ModelAdmin):
    list_display = ('segment_id', 'created_at', 'updated_at')

class FeedbackRecommendationAdmin(admin.ModelAdmin):
    list_display = ('feedback_id', 'product_id', 'created_at', 'updated_at')
    search_fields = ('product_id',)

class RecommendationPerformanceAnalyticsAdmin(admin.ModelAdmin):
    list_display = ('analytics_id', 'product_id', 'views', 'conversions', 'click_through_rate', 'created_at', 'updated_at')
    search_fields = ('product_id',)

class CustomerSpecificRecommendationAdmin(admin.ModelAdmin):
    list_display = ('recommendation_id', 'customer_id', 'created_at', 'updated_at')
    search_fields = ('customer_id',)

admin.site.register(PersonalizedRecommendation, PersonalizedRecommendationAdmin)
admin.site.register(SimilarProduct, SimilarProductAdmin)
admin.site.register(TrendingProduct, TrendingProductAdmin)
admin.site.register(NewArrival, NewArrivalAdmin)
admin.site.register(Bestseller, BestsellerAdmin)
admin.site.register(CrossSellProduct, CrossSellProductAdmin)
admin.site.register(UpSellProduct, UpSellProductAdmin)
admin.site.register(FrequentlyBoughtTogether, FrequentlyBoughtTogetherAdmin)
admin.site.register(CustomerBasedRecommendation, CustomerBasedRecommendationAdmin)
admin.site.register(DynamicPricingRecommendation, DynamicPricingRecommendationAdmin)
admin.site.register(RecommendationRule, RecommendationRuleAdmin)
admin.site.register(RealTimeRecommendationUpdate, RealTimeRecommendationUpdateAdmin)
admin.site.register(SegmentBasedRecommendation, SegmentBasedRecommendationAdmin)
admin.site.register(FeedbackRecommendation, FeedbackRecommendationAdmin)
admin.site.register(RecommendationPerformanceAnalytics, RecommendationPerformanceAnalyticsAdmin)
admin.site.register(CustomerSpecificRecommendation, CustomerSpecificRecommendationAdmin)
EOF

# Step 4: Create Django migrations
python manage.py makemigrations Recommendations

## Creating Cart Management app ##

# Step 1: Create Django app
python manage.py startapp CartManagement

# Add the new app to INSTALLED_APPS in settings.py
sed -i "/INSTALLED_APPS = \[/a \ \ \ \ 'CartManagement'," $SETTINGS_FILE

# Step 2: Create Django models for each table

# Cart Management models
cat <<EOF > CartManagement/models.py
from django.db import models
from django.contrib.auth.models import User

class Cart(models.Model):
    cart_id = models.AutoField(primary_key=True)
    user_id = models.IntegerField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class CartItems(models.Model):
    item_id = models.AutoField(primary_key=True)
    cart_id = models.IntegerField()
    product_id = models.IntegerField()
    quantity = models.IntegerField()
    price = models.DecimalField(max_digits=10, decimal_places=2)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class CartItemDetails(models.Model):
    detail_id = models.AutoField(primary_key=True)
    item_id = models.IntegerField()
    product_name = models.CharField(max_length=255)
    product_description = models.TextField()
    product_image_url = models.CharField(max_length=255)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class CartDiscounts(models.Model):
    discount_id = models.AutoField(primary_key=True)
    cart_id = models.IntegerField()
    discount_code = models.CharField(max_length=50)
    discount_amount = models.DecimalField(max_digits=10, decimal_places=2)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class CartPromotions(models.Model):
    promotion_id = models.AutoField(primary_key=True)
    cart_id = models.IntegerField()
    promotion_code = models.CharField(max_length=50)
    promotion_amount = models.DecimalField(max_digits=10, decimal_places=2)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class CartItemNotes(models.Model):
    note_id = models.AutoField(primary_key=True)
    item_id = models.IntegerField()
    note_text = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class CartSharing(models.Model):
    share_id = models.AutoField(primary_key=True)
    cart_id = models.IntegerField()
    shared_with_user_id = models.IntegerField()
    status = models.CharField(max_length=50)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class CartSaveForLater(models.Model):
    save_for_later_id = models.AutoField(primary_key=True)
    user_id = models.IntegerField()
    product_id = models.IntegerField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class CartExpiration(models.Model):
    cart_id = models.OneToOneField(Cart, on_delete=models.CASCADE, primary_key=True)
    expiration_date = models.DateTimeField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class CartPersistence(models.Model):
    user_id = models.OneToOneField(User, on_delete=models.CASCADE, primary_key=True)
    is_persistent = models.BooleanField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class CartRecommendations(models.Model):
    recommendation_id = models.AutoField(primary_key=True)
    user_id = models.IntegerField()
    recommended_product_ids = models.JSONField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class CartRecovery(models.Model):
    recovery_id = models.AutoField(primary_key=True)
    user_id = models.IntegerField()
    recovery_status = models.CharField(max_length=50)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class CartItemCustomization(models.Model):
    customization_id = models.AutoField(primary_key=True)
    item_id = models.IntegerField()
    customization_details = models.JSONField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class CartItemSubscription(models.Model):
    subscription_id = models.AutoField(primary_key=True)
    item_id = models.IntegerField()
    subscription_status = models.CharField(max_length=50)
    recurring_billing_details = models.JSONField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
EOF

# Step 3: Register models with Django admin
cat <<EOF > CartManagement/admin.py
from django.contrib import admin
from .models import Cart, CartItems, CartItemDetails, CartDiscounts, CartPromotions, \
                    CartItemNotes, CartSharing, CartSaveForLater, CartExpiration, \
                    CartPersistence, CartRecommendations, CartRecovery, \
                    CartItemCustomization, CartItemSubscription

@admin.register(Cart)
class CartAdmin(admin.ModelAdmin):
    list_display = ('cart_id', 'user_id', 'created_at', 'updated_at')

@admin.register(CartItems)
class CartItemsAdmin(admin.ModelAdmin):
    list_display = ('item_id', 'cart_id', 'product_id', 'quantity', 'price', 'created_at', 'updated_at')

@admin.register(CartItemDetails)
class CartItemDetailsAdmin(admin.ModelAdmin):
    list_display = ('detail_id', 'item_id', 'product_name', 'product_description', 'product_image_url', 'created_at', 'updated_at')

@admin.register(CartDiscounts)
class CartDiscountsAdmin(admin.ModelAdmin):
    list_display = ('discount_id', 'cart_id', 'discount_code', 'discount_amount', 'created_at', 'updated_at')

@admin.register(CartPromotions)
class CartPromotionsAdmin(admin.ModelAdmin):
    list_display = ('promotion_id', 'cart_id', 'promotion_code', 'promotion_amount', 'created_at', 'updated_at')

@admin.register(CartItemNotes)
class CartItemNotesAdmin(admin.ModelAdmin):
    list_display = ('note_id', 'item_id', 'note_text', 'created_at', 'updated_at')

@admin.register(CartSharing)
class CartSharingAdmin(admin.ModelAdmin):
    list_display = ('share_id', 'cart_id', 'shared_with_user_id', 'status', 'created_at', 'updated_at')

@admin.register(CartSaveForLater)
class CartSaveForLaterAdmin(admin.ModelAdmin):
    list_display = ('save_for_later_id', 'user_id', 'product_id', 'created_at', 'updated_at')

@admin.register(CartExpiration)
class CartExpirationAdmin(admin.ModelAdmin):
    list_display = ('cart_id', 'expiration_date', 'created_at', 'updated_at')

@admin.register(CartPersistence)
class CartPersistenceAdmin(admin.ModelAdmin):
    list_display = ('user_id', 'is_persistent', 'created_at', 'updated_at')

@admin.register(CartRecommendations)
class CartRecommendationsAdmin(admin.ModelAdmin):
    list_display = ('recommendation_id', 'user_id', 'recommended_product_ids', 'created_at', 'updated_at')

@admin.register(CartRecovery)
class CartRecoveryAdmin(admin.ModelAdmin):
    list_display = ('recovery_id', 'user_id', 'recovery_status', 'created_at', 'updated_at')

@admin.register(CartItemCustomization)
class CartItemCustomizationAdmin(admin.ModelAdmin):
    list_display = ('customization_id', 'item_id', 'customization_details', 'created_at', 'updated_at')

@admin.register(CartItemSubscription)
class CartItemSubscriptionAdmin(admin.ModelAdmin):
    list_display = ('subscription_id', 'item_id', 'subscription_status', 'recurring_billing_details', 'created_at', 'updated_at')

EOF

# Step 4: Create Django migrations
python manage.py makemigrations CartManagement



## Creating Subscription Management app ##

# Step 1: Create Django app
python manage.py startapp SubscriptionManagement
sed -i "/INSTALLED_APPS = \[/a \ \ \ \ 'SubscriptionManagement'," $SETTINGS_FILE

# Step 2: Create Django models for each table

# subscription management tables 
cat <<EOF > SubscriptionManagement/models.py
from django.db import models

class Subscriptions(models.Model):
    subscription_id = models.AutoField(primary_key=True)
    user_id = models.IntegerField()
    plan_id = models.IntegerField()
    start_date = models.DateTimeField()
    end_date = models.DateTimeField()
    status = models.CharField(max_length=50)
    billing_cycle = models.CharField(max_length=50)
    next_billing_date = models.DateTimeField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class SubscriptionPlans(models.Model):
    plan_id = models.AutoField(primary_key=True)
    plan_name = models.CharField(max_length=255)
    description = models.TextField()
    price = models.DecimalField(max_digits=10, decimal_places=2)
    currency = models.CharField(max_length=10)
    billing_cycle = models.CharField(max_length=50)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class SubscriptionCancellationReasons(models.Model):
    reason_id = models.AutoField(primary_key=True)
    reason_text = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class SubscriptionRenewalReminders(models.Model):
    reminder_id = models.AutoField(primary_key=True)
    user_id = models.IntegerField()
    reminder_date = models.DateTimeField()
    reminder_status = models.CharField(max_length=50)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class SubscriptionPaymentMethods(models.Model):
    method_id = models.AutoField(primary_key=True)
    user_id = models.IntegerField()
    payment_method_type = models.CharField(max_length=50)
    payment_details = models.JSONField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class SubscriptionUsageTracking(models.Model):
    usage_id = models.AutoField(primary_key=True)
    subscription_id = models.IntegerField()
    usage_details = models.JSONField()
    usage_date = models.DateTimeField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class SubscriptionAnalytics(models.Model):
    analytics_id = models.AutoField(primary_key=True)
    subscription_id = models.IntegerField()
    metric_name = models.CharField(max_length=255)
    metric_value = models.DecimalField(max_digits=10, decimal_places=2)
    metric_date = models.DateTimeField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class SubscriptionDiscounts(models.Model):
    discount_id = models.AutoField(primary_key=True)
    subscription_id = models.IntegerField()
    discount_code = models.CharField(max_length=50)
    discount_amount = models.DecimalField(max_digits=10, decimal_places=2)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class SubscriptionCustomizationOptions(models.Model):
    option_id = models.AutoField(primary_key=True)
    subscription_id = models.IntegerField()
    option_name = models.CharField(max_length=255)
    option_value = models.CharField(max_length=255)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
EOF


# Step 3: Register models with Django admin

cat <<EOF > SubscriptionManagement/admin.py
from django.contrib import admin
from .models import (
    Subscriptions, SubscriptionPlans, SubscriptionCancellationReasons,
    SubscriptionRenewalReminders, SubscriptionPaymentMethods,
    SubscriptionUsageTracking, SubscriptionAnalytics, SubscriptionDiscounts,
    SubscriptionCustomizationOptions
)

@admin.register(Subscriptions)
class SubscriptionsAdmin(admin.ModelAdmin):
    list_display = ('subscription_id', 'user_id', 'plan_id', 'start_date', 'end_date', 'status', 'billing_cycle', 'next_billing_date', 'created_at', 'updated_at')
    search_fields = ('user_id', 'plan_id', 'status', 'billing_cycle')
    list_filter = ('status', 'billing_cycle')

@admin.register(SubscriptionPlans)
class SubscriptionPlansAdmin(admin.ModelAdmin):
    list_display = ('plan_id', 'plan_name', 'description', 'price', 'currency', 'billing_cycle', 'created_at', 'updated_at')
    search_fields = ('plan_name', 'description', 'price', 'currency', 'billing_cycle')
    list_filter = ('currency', 'billing_cycle')

@admin.register(SubscriptionCancellationReasons)
class SubscriptionCancellationReasonsAdmin(admin.ModelAdmin):
    list_display = ('reason_id', 'reason_text', 'created_at', 'updated_at')
    search_fields = ('reason_text',)
    list_filter = ('created_at', 'updated_at')

@admin.register(SubscriptionRenewalReminders)
class SubscriptionRenewalRemindersAdmin(admin.ModelAdmin):
    list_display = ('reminder_id', 'user_id', 'reminder_date', 'reminder_status', 'created_at', 'updated_at')
    search_fields = ('user_id', 'reminder_status')
    list_filter = ('reminder_status', 'created_at', 'updated_at')

@admin.register(SubscriptionPaymentMethods)
class SubscriptionPaymentMethodsAdmin(admin.ModelAdmin):
    list_display = ('method_id', 'user_id', 'payment_method_type', 'payment_details', 'created_at', 'updated_at')
    search_fields = ('user_id', 'payment_method_type')
    list_filter = ('payment_method_type', 'created_at', 'updated_at')

@admin.register(SubscriptionUsageTracking)
class SubscriptionUsageTrackingAdmin(admin.ModelAdmin):
    list_display = ('usage_id', 'subscription_id', 'usage_details', 'usage_date', 'created_at', 'updated_at')
    search_fields = ('subscription_id',)
    list_filter = ('usage_date', 'created_at', 'updated_at')

@admin.register(SubscriptionAnalytics)
class SubscriptionAnalyticsAdmin(admin.ModelAdmin):
    list_display = ('analytics_id', 'subscription_id', 'metric_name', 'metric_value', 'metric_date', 'created_at', 'updated_at')
    search_fields = ('subscription_id', 'metric_name')
    list_filter = ('metric_name', 'metric_date', 'created_at', 'updated_at')

@admin.register(SubscriptionDiscounts)
class SubscriptionDiscountsAdmin(admin.ModelAdmin):
    list_display = ('discount_id', 'subscription_id', 'discount_code', 'discount_amount', 'created_at', 'updated_at')
    search_fields = ('subscription_id', 'discount_code')
    list_filter = ('created_at', 'updated_at')

@admin.register(SubscriptionCustomizationOptions)
class SubscriptionCustomizationOptionsAdmin(admin.ModelAdmin):
    list_display = ('option_id', 'subscription_id', 'option_name', 'option_value', 'created_at', 'updated_at')
    search_fields = ('subscription_id', 'option_name', 'option_value')
    list_filter = ('created_at', 'updated_at')
EOF

# Step 4: Create Django migrations
python manage.py makemigrations SubscriptionManagement

# Display success message
echo "SubscriptionManagement app created with models and registered in Django admin."



## Creating Gift Card Management app ##

# Step 1: Create Django app
python manage.py startapp GiftCardManagement
sed -i "/INSTALLED_APPS = \[/a \ \ \ \ 'GiftCardManagement'," $SETTINGS_FILE

# Step 2: Create Django models for each table

# gift card management tables. 
cat <<EOF > GiftCardManagement/models.py
from django.db import models

class GiftCards(models.Model):
    gift_card_id = models.AutoField(primary_key=True)
    recipient_id = models.IntegerField()
    card_code = models.CharField(max_length=50)
    balance = models.DecimalField(max_digits=10, decimal_places=2)
    activation_date = models.DateTimeField()
    expiration_date = models.DateTimeField()
    status = models.CharField(max_length=50)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class GiftCardTransactions(models.Model):
    transaction_id = models.AutoField(primary_key=True)
    gift_card_id = models.IntegerField()
    transaction_type = models.CharField(max_length=50)
    amount = models.DecimalField(max_digits=10, decimal_places=2)
    transaction_date = models.DateTimeField()
    transaction_details = models.JSONField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class GiftCardNotifications(models.Model):
    notification_id = models.AutoField(primary_key=True)
    user_id = models.IntegerField()
    gift_card_id = models.IntegerField()
    subscription_status = models.CharField(max_length=50)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class POSIntegrationConfiguration(models.Model):
    pos_id = models.AutoField(primary_key=True)
    pos_name = models.CharField(max_length=255)
    configuration_details = models.JSONField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class GiftCardRedemptionOptions(models.Model):
    redemption_id = models.AutoField(primary_key=True)
    gift_card_id = models.IntegerField()
    redemption_option = models.CharField(max_length=255)
    redemption_details = models.JSONField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class GiftCardCustomizationOptions(models.Model):
    customization_id = models.AutoField(primary_key=True)
    gift_card_id = models.IntegerField()
    customization_option = models.CharField(max_length=255)
    customization_value = models.CharField(max_length=255)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
EOF

# Step 3: Register models with Django admin
cat <<EOF > GiftCardManagement/admin.py
from django.contrib import admin
from .models import (
    GiftCards, GiftCardTransactions, GiftCardNotifications,
    POSIntegrationConfiguration, GiftCardRedemptionOptions,
    GiftCardCustomizationOptions
)

@admin.register(GiftCards)
class GiftCardsAdmin(admin.ModelAdmin):
    list_display = ('gift_card_id', 'recipient_id', 'card_code', 'balance', 'activation_date', 'expiration_date', 'status', 'created_at', 'updated_at')
    search_fields = ('recipient_id', 'card_code', 'status')
    list_filter = ('status', 'activation_date', 'expiration_date')

@admin.register(GiftCardTransactions)
class GiftCardTransactionsAdmin(admin.ModelAdmin):
    list_display = ('transaction_id', 'gift_card_id', 'transaction_type', 'amount', 'transaction_date', 'created_at', 'updated_at')
    search_fields = ('gift_card_id', 'transaction_type')
    list_filter = ('transaction_type', 'transaction_date')

@admin.register(GiftCardNotifications)
class GiftCardNotificationsAdmin(admin.ModelAdmin):
    list_display = ('notification_id', 'user_id', 'gift_card_id', 'subscription_status', 'created_at', 'updated_at')
    search_fields = ('user_id', 'gift_card_id', 'subscription_status')
    list_filter = ('subscription_status', 'created_at', 'updated_at')

@admin.register(POSIntegrationConfiguration)
class POSIntegrationConfigurationAdmin(admin.ModelAdmin):
    list_display = ('pos_id', 'pos_name', 'created_at', 'updated_at')
    search_fields = ('pos_name',)
    list_filter = ('created_at', 'updated_at')

@admin.register(GiftCardRedemptionOptions)
class GiftCardRedemptionOptionsAdmin(admin.ModelAdmin):
    list_display = ('redemption_id', 'gift_card_id', 'redemption_option', 'created_at', 'updated_at')
    search_fields = ('gift_card_id', 'redemption_option')
    list_filter = ('created_at', 'updated_at')

@admin.register(GiftCardCustomizationOptions)
class GiftCardCustomizationOptionsAdmin(admin.ModelAdmin):
    list_display = ('customization_id', 'gift_card_id', 'customization_option', 'customization_value', 'created_at', 'updated_at')
    search_fields = ('gift_card_id', 'customization_option', 'customization_value')
    list_filter = ('created_at', 'updated_at')
EOF

# Step 4: Create Django migrations
python manage.py makemigrations GiftCardManagement

# Display success message
echo "GiftCardManagement app created with models and registered in Django admin."




# Create Django app
python manage.py startapp OrderTracking
sed -i "/INSTALLED_APPS = \[/a \ \ \ \ 'OrderTracking'," $SETTINGS_FILE

# Add the models to models.py
cat <<EOF > OrderTracking/models.py
from django.db import models

class OrderTracking(models.Model):
    order_id = models.IntegerField(primary_key=True)
    current_status = models.CharField(max_length=255)
    estimated_delivery_date = models.DateTimeField()
    real_time_tracking_url = models.CharField(max_length=255)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class TrackingUpdates(models.Model):
    update_id = models.AutoField(primary_key=True)
    order_id = models.ForeignKey(OrderTracking, on_delete=models.CASCADE)
    status_update = models.CharField(max_length=255)
    timestamp = models.DateTimeField()
    location = models.CharField(max_length=255)
    additional_info = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class DeliveryRoutes(models.Model):
    route_id = models.AutoField(primary_key=True)
    order_id = models.ForeignKey(OrderTracking, on_delete=models.CASCADE)
    route_details = models.JSONField()
    map_url = models.CharField(max_length=255)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class ProofOfDelivery(models.Model):
    pod_id = models.AutoField(primary_key=True)
    order_id = models.ForeignKey(OrderTracking, on_delete=models.CASCADE)
    pod_details = models.TextField()
    pod_file_url = models.CharField(max_length=255)
    uploaded_at = models.DateTimeField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class DeliveryNotifications(models.Model):
    notification_id = models.AutoField(primary_key=True)
    order_id = models.ForeignKey(OrderTracking, on_delete=models.CASCADE)
    notification_type = models.CharField(max_length=255)
    sent_at = models.DateTimeField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class DeliveryIssues(models.Model):
    issue_id = models.AutoField(primary_key=True)
    order_id = models.ForeignKey(OrderTracking, on_delete=models.CASCADE)
    issue_description = models.TextField()
    reported_at = models.DateTimeField()
    status = models.CharField(max_length=50)
    resolution_details = models.TextField(null=True, blank=True)
    resolved_at = models.DateTimeField(null=True, blank=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class CarrierIntegration(models.Model):
    carrier_id = models.AutoField(primary_key=True)
    carrier_name = models.CharField(max_length=255)
    tracking_url = models.CharField(max_length=255)
    additional_details = models.JSONField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class DeliveryHistory(models.Model):
    history_id = models.AutoField(primary_key=True)
    order_id = models.ForeignKey(OrderTracking, on_delete=models.CASCADE)
    event_details = models.TextField()
    event_timestamp = models.DateTimeField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class DeliverySignatures(models.Model):
    signature_id = models.AutoField(primary_key=True)
    order_id = models.ForeignKey(OrderTracking, on_delete=models.CASCADE)
    signature_url = models.CharField(max_length=255)
    uploaded_at = models.DateTimeField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
EOF



# Add the admin registration to admin.py
cat <<EOF > OrderTracking/admin.py
from django.contrib import admin
from .models import OrderTracking, TrackingUpdates, DeliveryRoutes, ProofOfDelivery, DeliveryNotifications, DeliveryIssues, CarrierIntegration, DeliveryHistory, DeliverySignatures

class OrderTrackingAdmin(admin.ModelAdmin):
    list_display = ('order_id', 'current_status', 'estimated_delivery_date', 'real_time_tracking_url', 'created_at', 'updated_at')
    search_fields = ('order_id', 'current_status')

class TrackingUpdatesAdmin(admin.ModelAdmin):
    list_display = ('update_id', 'order_id', 'status_update', 'timestamp', 'location', 'created_at', 'updated_at')
    search_fields = ('order_id', 'status_update')

class DeliveryRoutesAdmin(admin.ModelAdmin):
    list_display = ('route_id', 'order_id', 'route_details', 'map_url', 'created_at', 'updated_at')
    search_fields = ('order_id', 'route_details')

class ProofOfDeliveryAdmin(admin.ModelAdmin):
    list_display = ('pod_id', 'order_id', 'pod_details', 'pod_file_url', 'uploaded_at', 'created_at', 'updated_at')
    search_fields = ('order_id', 'pod_details')

class DeliveryNotificationsAdmin(admin.ModelAdmin):
    list_display = ('notification_id', 'order_id', 'notification_type', 'sent_at', 'created_at', 'updated_at')
    search_fields = ('order_id', 'notification_type')

class DeliveryIssuesAdmin(admin.ModelAdmin):
    list_display = ('issue_id', 'order_id', 'issue_description', 'reported_at', 'status', 'resolved_at', 'created_at', 'updated_at')
    search_fields = ('order_id', 'issue_description')

class CarrierIntegrationAdmin(admin.ModelAdmin):
    list_display = ('carrier_id', 'carrier_name', 'tracking_url', 'created_at', 'updated_at')
    search_fields = ('carrier_name',)

class DeliveryHistoryAdmin(admin.ModelAdmin):
    list_display = ('history_id', 'order_id', 'event_details', 'event_timestamp', 'created_at', 'updated_at')
    search_fields = ('order_id', 'event_details')

class DeliverySignaturesAdmin(admin.ModelAdmin):
    list_display = ('signature_id', 'order_id', 'signature_url', 'uploaded_at', 'created_at', 'updated_at')
    search_fields = ('order_id',)

admin.site.register(OrderTracking, OrderTrackingAdmin)
admin.site.register(TrackingUpdates, TrackingUpdatesAdmin)
admin.site.register(DeliveryRoutes, DeliveryRoutesAdmin)
admin.site.register(ProofOfDelivery, ProofOfDeliveryAdmin)
admin.site.register(DeliveryNotifications, DeliveryNotificationsAdmin)
admin.site.register(DeliveryIssues, DeliveryIssuesAdmin)
admin.site.register(CarrierIntegration, CarrierIntegrationAdmin)
admin.site.register(DeliveryHistory, DeliveryHistoryAdmin)
admin.site.register(DeliverySignatures, DeliverySignaturesAdmin)
EOF

# Create Django migrations
python manage.py makemigrations OrderTracking

# Display success message
echo "OrderTracking app created with models and registered in Django admin."


# Create Django app
python manage.py startapp CustomerSupport
sed -i "/INSTALLED_APPS = \[/a \ \ \ \ 'CustomerSupport'," $SETTINGS_FILE

# Add the models to models.py
cat <<EOF > CustomerSupport/models.py
from django.db import models

class LiveChatSession(models.Model):
    session_id = models.AutoField(primary_key=True)
    customer_id = models.IntegerField()
    agent_id = models.IntegerField()
    start_time = models.DateTimeField()
    end_time = models.DateTimeField()
    status = models.CharField(max_length=50)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class ChatHistory(models.Model):
    message_id = models.AutoField(primary_key=True)
    session_id = models.ForeignKey(LiveChatSession, on_delete=models.CASCADE)
    sender_id = models.IntegerField()
    message_content = models.TextField()
    sent_at = models.DateTimeField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class AgentAvailability(models.Model):
    agent_id = models.IntegerField(primary_key=True)
    available = models.BooleanField()
    available_from = models.DateTimeField()
    available_to = models.DateTimeField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class SupportTicket(models.Model):
    ticket_id = models.AutoField(primary_key=True)
    customer_id = models.IntegerField()
    subject = models.CharField(max_length=255)
    description = models.TextField()
    status = models.CharField(max_length=50)
    priority = models.CharField(max_length=50)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class FAQ(models.Model):
    faq_id = models.AutoField(primary_key=True)
    question = models.CharField(max_length=255)
    answer = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class KnowledgeBaseArticle(models.Model):
    article_id = models.AutoField(primary_key=True)
    title = models.CharField(max_length=255)
    content = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class CustomerFeedback(models.Model):
    feedback_id = models.AutoField(primary_key=True)
    customer_id = models.IntegerField()
    ticket_id = models.IntegerField()
    feedback_text = models.TextField()
    response = models.TextField()
    submitted_at = models.DateTimeField()
    responded_at = models.DateTimeField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class Escalation(models.Model):
    escalation_id = models.AutoField(primary_key=True)
    ticket_id = models.IntegerField()
    escalated_to = models.CharField(max_length=255)
    reason = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class SupportAnalytics(models.Model):
    analytics_id = models.AutoField(primary_key=True)
    type = models.CharField(max_length=50)
    data = models.JSONField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class SupportAvailability(models.Model):
    date = models.DateField(primary_key=True)
    availability = models.JSONField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class SupportLanguage(models.Model):
    language_id = models.AutoField(primary_key=True)
    language_code = models.CharField(max_length=10)
    language_name = models.CharField(max_length=255)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class SupportResource(models.Model):
    resource_id = models.AutoField(primary_key=True)
    type = models.CharField(max_length=50)
    title = models.CharField(max_length=255)
    content = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class AgentPerformance(models.Model):
    agent_id = models.IntegerField(primary_key=True)
    performance_data = models.JSONField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class SupportIntegration(models.Model):
    integration_id = models.AutoField(primary_key=True)
    type = models.CharField(max_length=50)
    details = models.JSONField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
EOF


# Add the admin registration to admin.py
cat <<EOF > CustomerSupport/admin.py
from django.contrib import admin
from .models import LiveChatSession, ChatHistory, AgentAvailability, SupportTicket, FAQ, KnowledgeBaseArticle, CustomerFeedback, Escalation, SupportAnalytics, SupportAvailability, SupportLanguage, SupportResource, AgentPerformance, SupportIntegration

class LiveChatSessionAdmin(admin.ModelAdmin):
    list_display = ('session_id', 'customer_id', 'agent_id', 'start_time', 'end_time', 'status', 'created_at', 'updated_at')
    search_fields = ('customer_id', 'agent_id', 'status')

class ChatHistoryAdmin(admin.ModelAdmin):
    list_display = ('message_id', 'session_id', 'sender_id', 'message_content', 'sent_at', 'created_at', 'updated_at')
    search_fields = ('session_id', 'sender_id')

class AgentAvailabilityAdmin(admin.ModelAdmin):
    list_display = ('agent_id', 'available', 'available_from', 'available_to', 'created_at', 'updated_at')
    search_fields = ('agent_id',)

class SupportTicketAdmin(admin.ModelAdmin):
    list_display = ('ticket_id', 'customer_id', 'subject', 'status', 'priority', 'created_at', 'updated_at')
    search_fields = ('customer_id', 'subject', 'status', 'priority')

class FAQAdmin(admin.ModelAdmin):
    list_display = ('faq_id', 'question', 'answer', 'created_at', 'updated_at')
    search_fields = ('question',)

class KnowledgeBaseArticleAdmin(admin.ModelAdmin):
    list_display = ('article_id', 'title', 'content', 'created_at', 'updated_at')
    search_fields = ('title',)

class CustomerFeedbackAdmin(admin.ModelAdmin):
    list_display = ('feedback_id', 'customer_id', 'ticket_id', 'feedback_text', 'response', 'submitted_at', 'responded_at', 'created_at', 'updated_at')
    search_fields = ('customer_id', 'ticket_id', 'feedback_text')

class EscalationAdmin(admin.ModelAdmin):
    list_display = ('escalation_id', 'ticket_id', 'escalated_to', 'reason', 'created_at', 'updated_at')
    search_fields = ('ticket_id', 'escalated_to')

class SupportAnalyticsAdmin(admin.ModelAdmin):
    list_display = ('analytics_id', 'type', 'data', 'created_at', 'updated_at')
    search_fields = ('type',)

class SupportAvailabilityAdmin(admin.ModelAdmin):
    list_display = ('date', 'availability', 'created_at', 'updated_at')
    search_fields = ('date',)

class SupportLanguageAdmin(admin.ModelAdmin):
    list_display = ('language_id', 'language_code', 'language_name', 'created_at', 'updated_at')
    search_fields = ('language_code', 'language_name')

class SupportResourceAdmin(admin.ModelAdmin):
    list_display = ('resource_id', 'type', 'title', 'content', 'created_at', 'updated_at')
    search_fields = ('type', 'title')

class AgentPerformanceAdmin(admin.ModelAdmin):
    list_display = ('agent_id', 'performance_data', 'created_at', 'updated_at')
    search_fields = ('agent_id',)

class SupportIntegrationAdmin(admin.ModelAdmin):
    list_display = ('integration_id', 'type', 'details', 'created_at', 'updated_at')
    search_fields = ('type',)

admin.site.register(LiveChatSession, LiveChatSessionAdmin)
admin.site.register(ChatHistory, ChatHistoryAdmin)
admin.site.register(AgentAvailability, AgentAvailabilityAdmin)
admin.site.register(SupportTicket, SupportTicketAdmin)
admin.site.register(FAQ, FAQAdmin)
admin.site.register(KnowledgeBaseArticle, KnowledgeBaseArticleAdmin)
admin.site.register(CustomerFeedback, CustomerFeedbackAdmin)
admin.site.register(Escalation, EscalationAdmin)
admin.site.register(SupportAnalytics, SupportAnalyticsAdmin)
admin.site.register(SupportAvailability, SupportAvailabilityAdmin)
admin.site.register(SupportLanguage, SupportLanguageAdmin)
admin.site.register(SupportResource, SupportResourceAdmin)
admin.site.register(AgentPerformance, AgentPerformanceAdmin)
admin.site.register(SupportIntegration, SupportIntegrationAdmin)
EOF

# Create Django migrations
python manage.py makemigrations CustomerSupport

# Display success message
echo "CustomerSupport app created with models and registered in Django admin."



# Create Django app
python manage.py startapp SocialShare
sed -i "/INSTALLED_APPS = \[/a \ \ \ \ 'SocialShare'," $SETTINGS_FILE



# Add the models to models.py
cat <<EOF > SocialShare/models.py
from django.db import models

class SocialShare(models.Model):
    share_id = models.AutoField(primary_key=True)
    user_id = models.IntegerField()
    platform = models.CharField(max_length=50)
    content_id = models.IntegerField()
    share_url = models.CharField(max_length=255)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class SocialAnalytics(models.Model):
    analytics_id = models.AutoField(primary_key=True)
    share_id = models.ForeignKey(SocialShare, on_delete=models.CASCADE)
    views = models.IntegerField()
    engagement = models.IntegerField()
    conversions = models.IntegerField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class SocialLike(models.Model):
    like_id = models.AutoField(primary_key=True)
    user_id = models.IntegerField()
    post_id = models.IntegerField()
    action = models.CharField(max_length=50)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class SocialComment(models.Model):
    comment_id = models.AutoField(primary_key=True)
    user_id = models.IntegerField()
    post_id = models.IntegerField()
    comment_text = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class SocialPrivacy(models.Model):
    post_id = models.IntegerField(primary_key=True)
    user_id = models.IntegerField()
    privacy_level = models.CharField(max_length=50)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class UserSocialProfile(models.Model):
    profile_id = models.AutoField(primary_key=True)
    user_id = models.IntegerField()
    platform = models.CharField(max_length=50)
    share_count = models.IntegerField()
    like_count = models.IntegerField()
    comment_count = models.IntegerField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class SocialBadge(models.Model):
    badge_id = models.AutoField(primary_key=True)
    user_id = models.IntegerField()
    badge_name = models.CharField(max_length=255)
    earned_at = models.DateTimeField()

class SocialReward(models.Model):
    reward_id = models.AutoField(primary_key=True)
    user_id = models.IntegerField()
    reward_name = models.CharField(max_length=255)
    points = models.IntegerField()
    earned_at = models.DateTimeField()

class SocialRecommendation(models.Model):
    recommendation_id = models.AutoField(primary_key=True)
    user_id = models.IntegerField()
    content_id = models.IntegerField()
    recommendation_type = models.CharField(max_length=50)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class SocialTrendingTopic(models.Model):
    trend_id = models.AutoField(primary_key=True)
    category_id = models.IntegerField()
    trend_name = models.CharField(max_length=255)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class InfluencerCampaign(models.Model):
    campaign_id = models.AutoField(primary_key=True)
    influencer_id = models.IntegerField()
    campaign_details = models.TextField()
    stats = models.JSONField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class SocialCollaboration(models.Model):
    collaboration_id = models.AutoField(primary_key=True)
    partner_id = models.IntegerField()
    user_id = models.IntegerField()
    status = models.CharField(max_length=50)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class CMSIntegration(models.Model):
    integration_id = models.AutoField(primary_key=True)
    cms_id = models.IntegerField()
    configuration = models.JSONField()
    status = models.CharField(max_length=50)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
EOF


# Add the admin registration to admin.py
cat <<EOF > SocialShare/admin.py
from django.contrib import admin
from .models import SocialShare, SocialAnalytics, SocialLike, SocialComment, SocialPrivacy, UserSocialProfile, SocialBadge, SocialReward, SocialRecommendation, SocialTrendingTopic, InfluencerCampaign, SocialCollaboration, CMSIntegration

class SocialShareAdmin(admin.ModelAdmin):
    list_display = ('share_id', 'user_id', 'platform', 'content_id', 'share_url', 'created_at', 'updated_at')
    search_fields = ('user_id', 'platform', 'content_id')

class SocialAnalyticsAdmin(admin.ModelAdmin):
    list_display = ('analytics_id', 'share_id', 'views', 'engagement', 'conversions', 'created_at', 'updated_at')
    search_fields = ('share_id',)

class SocialLikeAdmin(admin.ModelAdmin):
    list_display = ('like_id', 'user_id', 'post_id', 'action', 'created_at', 'updated_at')
    search_fields = ('user_id', 'post_id', 'action')

class SocialCommentAdmin(admin.ModelAdmin):
    list_display = ('comment_id', 'user_id', 'post_id', 'comment_text', 'created_at', 'updated_at')
    search_fields = ('user_id', 'post_id')

class SocialPrivacyAdmin(admin.ModelAdmin):
    list_display = ('post_id', 'user_id', 'privacy_level', 'created_at', 'updated_at')
    search_fields = ('post_id', 'user_id', 'privacy_level')

class UserSocialProfileAdmin(admin.ModelAdmin):
    list_display = ('profile_id', 'user_id', 'platform', 'share_count', 'like_count', 'comment_count', 'created_at', 'updated_at')
    search_fields = ('user_id', 'platform')

class SocialBadgeAdmin(admin.ModelAdmin):
    list_display = ('badge_id', 'user_id', 'badge_name', 'earned_at')
    search_fields = ('user_id', 'badge_name')

class SocialRewardAdmin(admin.ModelAdmin):
    list_display = ('reward_id', 'user_id', 'reward_name', 'points', 'earned_at')
    search_fields = ('user_id', 'reward_name')

class SocialRecommendationAdmin(admin.ModelAdmin):
    list_display = ('recommendation_id', 'user_id', 'content_id', 'recommendation_type', 'created_at', 'updated_at')
    search_fields = ('user_id', 'content_id', 'recommendation_type')

class SocialTrendingTopicAdmin(admin.ModelAdmin):
    list_display = ('trend_id', 'category_id', 'trend_name', 'created_at', 'updated_at')
    search_fields = ('category_id', 'trend_name')

class InfluencerCampaignAdmin(admin.ModelAdmin):
    list_display = ('campaign_id', 'influencer_id', 'campaign_details', 'created_at', 'updated_at')
    search_fields = ('influencer_id',)

class SocialCollaborationAdmin(admin.ModelAdmin):
    list_display = ('collaboration_id', 'partner_id', 'user_id', 'status', 'created_at', 'updated_at')
    search_fields = ('partner_id', 'user_id', 'status')

class CMSIntegrationAdmin(admin.ModelAdmin):
    list_display = ('integration_id', 'cms_id', 'configuration', 'status', 'created_at', 'updated_at')
    search_fields = ('cms_id', 'status')

admin.site.register(SocialShare, SocialShareAdmin)
admin.site.register(SocialAnalytics, SocialAnalyticsAdmin)
admin.site.register(SocialLike, SocialLikeAdmin)
admin.site.register(SocialComment, SocialCommentAdmin)
admin.site.register(SocialPrivacy, SocialPrivacyAdmin)
admin.site.register(UserSocialProfile, UserSocialProfileAdmin)
admin.site.register(SocialBadge, SocialBadgeAdmin)
admin.site.register(SocialReward, SocialRewardAdmin)
admin.site.register(SocialRecommendation, SocialRecommendationAdmin)
admin.site.register(SocialTrendingTopic, SocialTrendingTopicAdmin)
admin.site.register(InfluencerCampaign, InfluencerCampaignAdmin)
admin.site.register(SocialCollaboration, SocialCollaborationAdmin)
admin.site.register(CMSIntegration, CMSIntegrationAdmin)
EOF

# Create Django migrations
python manage.py makemigrations SocialShare

# Display success message
echo "SocialShare app created with models and registered in Django admin."


# Create Django app
python manage.py startapp LoyaltyProgram
sed -i "/INSTALLED_APPS = \[/a \ \ \ \ 'LoyaltyProgram'," $SETTINGS_FILE


# Add the models to models.py
cat <<EOF > LoyaltyProgram/models.py
from django.db import models

class LoyaltyEnrollment(models.Model):
    enrollment_id = models.AutoField(primary_key=True)
    customer_id = models.IntegerField()
    enrollment_date = models.DateTimeField()
    status = models.CharField(max_length=50)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class LoyaltyPointsHistory(models.Model):
    history_id = models.AutoField(primary_key=True)
    customer_id = models.IntegerField()
    points = models.IntegerField()
    activity_type = models.CharField(max_length=50)
    description = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class LoyaltyRedemptionHistory(models.Model):
    redemption_id = models.AutoField(primary_key=True)
    customer_id = models.IntegerField()
    points_redeemed = models.IntegerField()
    redemption_date = models.DateTimeField()
    item_redeemed = models.CharField(max_length=255)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class LoyaltyTier(models.Model):
    tier_id = models.AutoField(primary_key=True)
    tier_name = models.CharField(max_length=255)
    tier_details = models.TextField()
    tier_benefits = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class LoyaltyMembershipStatus(models.Model):
    status_id = models.AutoField(primary_key=True)
    customer_id = models.IntegerField()
    current_tier = models.ForeignKey(LoyaltyTier, on_delete=models.CASCADE)
    status = models.CharField(max_length=50)
    points_balance = models.IntegerField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class LoyaltyEarningOpportunity(models.Model):
    opportunity_id = models.AutoField(primary_key=True)
    customer_id = models.IntegerField()
    activity_id = models.IntegerField()
    activity_details = models.TextField()
    points = models.IntegerField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class LoyaltyCustomization(models.Model):
    customization_id = models.AutoField(primary_key=True)
    rules = models.JSONField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class LoyaltyPromotion(models.Model):
    promotion_id = models.AutoField(primary_key=True)
    promotion_details = models.TextField()
    start_date = models.DateTimeField()
    end_date = models.DateTimeField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class LoyaltyPointsTransfer(models.Model):
    transfer_id = models.AutoField(primary_key=True)
    from_customer_id = models.IntegerField()
    to_customer_id = models.IntegerField()
    points = models.IntegerField()
    transfer_date = models.DateTimeField()
    status = models.CharField(max_length=50)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class LoyaltyAnalytics(models.Model):
    analytics_id = models.AutoField(primary_key=True)
    metric = models.CharField(max_length=50)
    value = models.IntegerField()
    period = models.CharField(max_length=50)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class LoyaltyReferral(models.Model):
    referral_id = models.AutoField(primary_key=True)
    referrer_id = models.IntegerField()
    referred_id = models.IntegerField()
    referral_date = models.DateTimeField()
    points_awarded = models.IntegerField()
    status = models.CharField(max_length=50)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class LoyaltyNotification(models.Model):
    notification_id = models.AutoField(primary_key=True)
    customer_id = models.IntegerField()
    notification_type = models.CharField(max_length=50)
    status = models.CharField(max_length=50)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
EOF


# Add the admin registration to admin.py
cat <<EOF > LoyaltyProgram/admin.py
from django.contrib import admin
from .models import LoyaltyEnrollment, LoyaltyPointsHistory, LoyaltyRedemptionHistory, LoyaltyTier, LoyaltyMembershipStatus, LoyaltyEarningOpportunity, LoyaltyCustomization, LoyaltyPromotion, LoyaltyPointsTransfer, LoyaltyAnalytics, LoyaltyReferral, LoyaltyNotification

class LoyaltyEnrollmentAdmin(admin.ModelAdmin):
    list_display = ('enrollment_id', 'customer_id', 'enrollment_date', 'status', 'created_at', 'updated_at')
    search_fields = ('customer_id', 'status')

class LoyaltyPointsHistoryAdmin(admin.ModelAdmin):
    list_display = ('history_id', 'customer_id', 'points', 'activity_type', 'created_at', 'updated_at')
    search_fields = ('customer_id', 'activity_type')

class LoyaltyRedemptionHistoryAdmin(admin.ModelAdmin):
    list_display = ('redemption_id', 'customer_id', 'points_redeemed', 'redemption_date', 'item_redeemed', 'created_at', 'updated_at')
    search_fields = ('customer_id', 'item_redeemed')

class LoyaltyTierAdmin(admin.ModelAdmin):
    list_display = ('tier_id', 'tier_name', 'created_at', 'updated_at')
    search_fields = ('tier_name',)

class LoyaltyMembershipStatusAdmin(admin.ModelAdmin):
    list_display = ('status_id', 'customer_id', 'current_tier', 'status', 'points_balance', 'created_at', 'updated_at')
    search_fields = ('customer_id', 'status')

class LoyaltyEarningOpportunityAdmin(admin.ModelAdmin):
    list_display = ('opportunity_id', 'customer_id', 'activity_id', 'points', 'created_at', 'updated_at')
    search_fields = ('customer_id', 'activity_id')

class LoyaltyCustomizationAdmin(admin.ModelAdmin):
    list_display = ('customization_id', 'created_at', 'updated_at')
    search_fields = ('customization_id',)

class LoyaltyPromotionAdmin(admin.ModelAdmin):
    list_display = ('promotion_id', 'start_date', 'end_date', 'created_at', 'updated_at')
    search_fields = ('promotion_id',)

class LoyaltyPointsTransferAdmin(admin.ModelAdmin):
    list_display = ('transfer_id', 'from_customer_id', 'to_customer_id', 'points', 'transfer_date', 'status', 'created_at', 'updated_at')
    search_fields = ('from_customer_id', 'to_customer_id', 'status')

class LoyaltyAnalyticsAdmin(admin.ModelAdmin):
    list_display = ('analytics_id', 'metric', 'value', 'period', 'created_at', 'updated_at')
    search_fields = ('metric', 'period')

class LoyaltyReferralAdmin(admin.ModelAdmin):
    list_display = ('referral_id', 'referrer_id', 'referred_id', 'referral_date', 'points_awarded', 'status', 'created_at', 'updated_at')
    search_fields = ('referrer_id', 'referred_id', 'status')

class LoyaltyNotificationAdmin(admin.ModelAdmin):
    list_display = ('notification_id', 'customer_id', 'notification_type', 'status', 'created_at', 'updated_at')
    search_fields = ('customer_id', 'notification_type', 'status')

admin.site.register(LoyaltyEnrollment, LoyaltyEnrollmentAdmin)
admin.site.register(LoyaltyPointsHistory, LoyaltyPointsHistoryAdmin)
admin.site.register(LoyaltyRedemptionHistory, LoyaltyRedemptionHistoryAdmin)
admin.site.register(LoyaltyTier, LoyaltyTierAdmin)
admin.site.register(LoyaltyMembershipStatus, LoyaltyMembershipStatusAdmin)
admin.site.register(LoyaltyEarningOpportunity, LoyaltyEarningOpportunityAdmin)
admin.site.register(LoyaltyCustomization, LoyaltyCustomizationAdmin)
admin.site.register(LoyaltyPromotion, LoyaltyPromotionAdmin)
admin.site.register(LoyaltyPointsTransfer, LoyaltyPointsTransferAdmin)
admin.site.register(LoyaltyAnalytics, LoyaltyAnalyticsAdmin)
admin.site.register(LoyaltyReferral, LoyaltyReferralAdmin)
admin.site.register(LoyaltyNotification, LoyaltyNotificationAdmin)
EOF

# Create Django migrations
python manage.py makemigrations LoyaltyProgram

# Display success message
echo "LoyaltyProgram app created with models and registered in Django admin."


# Step 4: Apply migrations
python manage.py migrate



# Deactivate the virtual environment
deactivate



cd ..

# Test script for the Django setup script
print_header "Test Python virtual environment creation"

# Step 1: Test Python virtual environment creation
if [ -d ".env" ]; then
    echo -e "${GREEN}${CHECK_MARK} Virtual environment creation: PASS${NC}"
else
    echo -e "${RED}${CROSS_MARK} Virtual environment creation: FAIL${NC}"
    exit 1
fi

# Step 2: Test virtual environment activation
# This can be tricky to test because the script changes the shell environment.
# You can check if the virtual environment is activated by checking if pip points to the virtual environment.
source .env/bin/activate
if [[ $(pip --version) == *".env"* ]]; then
    echo -e "${GREEN}${CHECK_MARK} Virtual environment activation: PASS${NC}"
else
    echo -e "${RED}${CROSS_MARK} Virtual environment activation: FAIL${NC}"
    exit 1
fi

# Step 3: Test package installation
REQUIRED_PACKAGES=("django" "djangorestframework" "djangorestframework-simplejwt" "django-cors-headers")
for package in "${REQUIRED_PACKAGES[@]}"; do
    if pip show $package &> /dev/null; then
        echo -e "${GREEN}${CHECK_MARK} Package $package installation: PASS${NC}"
    else
        echo -e "${RED}${CROSS_MARK} Package $package installation: FAIL${NC}"
        exit 1
    fi
done

# Step 4: Test Django project creation
if [ -d "Khukumoni" ]; then
    echo -e "${GREEN}${CHECK_MARK} Django project creation: PASS${NC}"
else
    echo -e "${RED}${CROSS_MARK} Django project creation: FAIL${NC}"
    exit 1
fi

# Navigate to the project directory
cd Khukumoni

# Step 5: Test Django settings update
SETTINGS_FILE="Khukumoni/settings.py"

# Check if the necessary apps are added
if grep -q "'rest_framework'" "$SETTINGS_FILE" &&
   grep -q "'corsheaders'" "$SETTINGS_FILE" &&
   grep -q "'rest_framework_simplejwt'" "$SETTINGS_FILE"; then
    echo -e "${GREEN}${CHECK_MARK} Django settings apps update: PASS${NC}"
else
    echo -e "${RED}${CROSS_MARK} Django settings apps update: FAIL${NC}"
    exit 1
fi

# Check if static and media settings are added
if grep -q "STATIC_URL = '/static/'" "$SETTINGS_FILE" &&
   grep -q "MEDIA_URL = '/media/'" "$SETTINGS_FILE"; then
    echo -e "${GREEN}${CHECK_MARK} Django static and media settings update: PASS${NC}"
else
    echo -e "${RED}${CROSS_MARK} Django static and media settings update: FAIL${NC}"
    exit 1
fi

# Check if CORS settings are added
if grep -q "CORS_ALLOW_ALL_ORIGINS = True" "$SETTINGS_FILE"; then
    echo -e "${GREEN}${CHECK_MARK} CORS settings update: PASS${NC}"
else
    echo -e "${RED}${CROSS_MARK} CORS settings update: FAIL${NC}"
    exit 1
fi

# Check if static and media URL patterns are added
if grep -q "urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)" "$URLS_FILE" &&
   grep -q "urlpatterns += static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)" "$URLS_FILE"; then
    echo -e "${GREEN}${CHECK_MARK} Static and media URL patterns update: PASS${NC}"
else
    echo -e "${RED}${CROSS_MARK} Static and media URL patterns update: FAIL${NC}"
    exit 1
fi

# Check if JWT and REST framework URL patterns are added
if grep -q "path('api/token/', TokenObtainPairView.as_view(), name='token_obtain_pair')" "$URLS_FILE" &&
   grep -q "path('api/token/refresh/', TokenRefreshView.as_view(), name='token_refresh')" "$URLS_FILE"; then
    echo -e "${GREEN}${CHECK_MARK} JWT and REST framework URL patterns update: PASS${NC}"
else
    echo -e "${RED}${CROSS_MARK} JWT and REST framework URL patterns update: FAIL${NC}"
    exit 1
fi

# Step 7: Test migration
if python manage.py showmigrations | grep -q '[X]'; then
    echo -e "${GREEN}${CHECK_MARK} Django migrations: PASS${NC}"
else
    echo -e "${RED}${CROSS_MARK} Django migrations: FAIL${NC}"
    exit 1
fi

# Step 8: Test superuser creation
if python manage.py shell -c "from django.contrib.auth import get_user_model; User = get_user_model(); print(User.objects.filter(username='admin').exists())" | grep -q 'True'; then
    echo -e "${GREEN}${CHECK_MARK} Superuser creation: PASS${NC}"
else
    echo -e "${RED}${CROSS_MARK} Superuser creation: FAIL${NC}"
    exit 1
fi







print_header "Checking app creation - Product Management"
# Test script for the Product Management App setup

# Step 1: Test Django app creation
if [ -d "ProductManagement" ]; then
    echo -e "${GREEN}${CHECK_MARK} Django app creation: PASS${NC}"
else
    echo -e "${RED}${CROSS_MARK} Django app creation: FAIL${NC}"
    exit 1
fi

# Step 2: Test Django models creation
MODELS=("Brand" "Category" "Product" "Variant" "Image" "Video" "Pricing" "Discount")
for model in "${MODELS[@]}"; do
    if grep -q "class $model(models.Model):" "ProductManagement/models.py"; then
        echo -e "${GREEN}${CHECK_MARK} Django model $model creation: PASS${NC}"
    else
        echo -e "${RED}${CROSS_MARK} Django model $model creation: FAIL${NC}"
        exit 1
    fi
done

# Step 3: Test Django admin registration
if grep -q "admin.site.register(Brand, BrandAdmin)" "ProductManagement/admin.py"; then
    echo -e "${GREEN}${CHECK_MARK} Django admin registration: PASS${NC}"
else
    echo -e "${RED}${CROSS_MARK} Django admin registration: FAIL${NC}"
    exit 1
fi

# Step 4: Test Django migrations
if python manage.py makemigrations --dry-run ProductManagement &> /dev/null; then
    echo -e "${GREEN}${CHECK_MARK} Django migrations creation: PASS${NC}"
else
    echo -e "${RED}${CROSS_MARK} Django migrations creation: FAIL${NC}"
    exit 1
fi






# Test script for the Inventory Management App setup

print_header "Checking app creation - Inventory Management"

# Step 1: Test Django app creation
if [ -d "InventoryManagement" ]; then
    echo -e "${GREEN}${CHECK_MARK} Django app creation: PASS${NC}"
else
    echo -e "${RED}${CROSS_MARK} Django app creation: FAIL${NC}"
    exit 1
fi

# Step 2: Test Django models creation
MODELS=("InventoryLocation" "Inventory" "InventoryHistory" "StockAlert" "StockTransfer" "Batch" "ExpiryManagement" "InventoryReport" "InventoryAdjustmentReason")
for model in "${MODELS[@]}"; do
    if grep -q "class $model(models.Model):" "InventoryManagement/models.py"; then
        echo -e "${GREEN}${CHECK_MARK} Django model $model creation: PASS${NC}"
    else
        echo -e "${RED}${CROSS_MARK} Django model $model creation: FAIL${NC}"
        exit 1
    fi
done

# Step 3: Test Django admin registration
if grep -q "admin.site.register(InventoryLocation)" "InventoryManagement/admin.py"; then
    echo -e "${GREEN}${CHECK_MARK} Django admin registration: PASS${NC}"
else
    echo -e "${RED}${CROSS_MARK} Django admin registration: FAIL${NC}"
    exit 1
fi

# Step 4: Test Django migrations
if python manage.py makemigrations --dry-run InventoryManagement &> /dev/null; then
    echo -e "${GREEN}${CHECK_MARK} Django migrations creation: PASS${NC}"
else
    echo -e "${RED}${CROSS_MARK} Django migrations creation: FAIL${NC}"
    exit 1
fi




# Test script for the Customer Management App setup

print_header "Checking app creation - Customer Management"

# Step 1: Test Django app creation
if [ -d "CustomerManagement" ]; then
    echo -e "${GREEN}${CHECK_MARK} Django app creation: PASS${NC}"
else
    echo -e "${RED}${CROSS_MARK} Django app creation: FAIL${NC}"
    exit 1
fi

# Step 2: Test Django models creation
MODELS=("Customer" "CustomerPreference" "CustomerTag" "CustomerNote" "Lead" "Opportunity" "Interaction" "Task" "Segment" "Survey" "Integration" "NPSResponse" "LifecycleStage" "CalendarEvent" "Document")
for model in "${MODELS[@]}"; do
    if grep -q "class $model(models.Model):" "CustomerManagement/models.py"; then
        echo -e "${GREEN}${CHECK_MARK} Django model $model creation: PASS${NC}"
    else
        echo -e "${RED}${CROSS_MARK} Django model $model creation: FAIL${NC}"
        exit 1
    fi
done

# Step 3: Test Django admin registration
if grep -q "admin.site.register(Customer, CustomerAdmin)" "CustomerManagement/admin.py"; then
    echo -e "${GREEN}${CHECK_MARK} Django admin registration: PASS${NC}"
else
    echo -e "${RED}${CROSS_MARK} Django admin registration: FAIL${NC}"
    exit 1
fi

# Step 4: Test Django migrations
if python manage.py makemigrations --dry-run CustomerManagement &> /dev/null; then
    echo -e "${GREEN}${CHECK_MARK} Django migrations creation: PASS${NC}"
else
    echo -e "${RED}${CROSS_MARK} Django migrations creation: FAIL${NC}"
    exit 1
fi





# Test script for the Order Management App setup

print_header "Checking app creation - Order Management"

# Step 1: Test Django app creation
if [ -d "OrderManagement" ]; then
    echo -e "${GREEN}${CHECK_MARK} Django app creation: PASS${NC}"
else
    echo -e "${RED}${CROSS_MARK} Django app creation: FAIL${NC}"
    exit 1
fi

# Step 2: Test Django models creation
MODELS=("Order" "OrderItem" "Shipment" "Return" "Refund" "OrderCommunication" "RecurringOrder" "OrderBatch")
for model in "${MODELS[@]}"; do
    if grep -q "class $model(models.Model):" "OrderManagement/models.py"; then
        echo -e "${GREEN}${CHECK_MARK} Django model $model creation: PASS${NC}"
    else
        echo -e "${RED}${CROSS_MARK} Django model $model creation: FAIL${NC}"
        exit 1
    fi
done

# Step 3: Test Django admin registration
if grep -q "admin.site.register(Order, OrderAdmin)" "OrderManagement/admin.py"; then
    echo -e "${GREEN}${CHECK_MARK} Django admin registration: PASS${NC}"
else
    echo -e "${RED}${CROSS_MARK} Django admin registration: FAIL${NC}"
    exit 1
fi

# Step 4: Test Django migrations
if python manage.py makemigrations --dry-run OrderManagement &> /dev/null; then
    echo -e "${GREEN}${CHECK_MARK} Django migrations creation: PASS${NC}"
else
    echo -e "${RED}${CROSS_MARK} Django migrations creation: FAIL${NC}"
    exit 1
fi



# Test script for the Payment Processing App setup

print_header "Checking app creation - Payment Processing"

# Step 1: Test Django app creation
if [ -d "PaymentProcessing" ]; then
    echo -e "${GREEN}${CHECK_MARK} Django app creation: PASS${NC}"
else
    echo -e "${RED}${CROSS_MARK} Django app creation: FAIL${NC}"
    exit 1
fi

# Step 2: Test Django models creation
MODELS=("Payments" "PaymentMethods" "PaymentHistory" "PaymentTokens" "PaymentNotifications" "PaymentGateways" "RecurringPayments" "Settlements" "FraudDetection" "SecureAuthentication")
for model in "${MODELS[@]}"; do
    if grep -q "class $model(models.Model):" "PaymentProcessing/models.py"; then
        echo -e "${GREEN}${CHECK_MARK} Django model $model creation: PASS${NC}"
    else
        echo -e "${RED}${CROSS_MARK} Django model $model creation: FAIL${NC}"
        exit 1
    fi
done

# Step 3: Test Django admin registration
if grep -q "admin.site.register(Payments, PaymentAdmin)" "PaymentProcessing/admin.py"; then
    echo -e "${GREEN}${CHECK_MARK} Django admin registration: PASS${NC}"
else
    echo -e "${RED}${CROSS_MARK} Django admin registration: FAIL${NC}"
    exit 1
fi

# Step 4: Test Django migrations
if python manage.py makemigrations --dry-run PaymentProcessing &> /dev/null; then
    echo -e "${GREEN}${CHECK_MARK} Django migrations creation: PASS${NC}"
else
    echo -e "${RED}${CROSS_MARK} Django migrations creation: FAIL${NC}"
    exit 1
fi





# Test script for the Shipping and Fulfillment App setup

print_header "Checking app creation - hipping and Fulfillment"

# Step 1: Test Django app creation
if [ -d "ShippingAndFulfillment" ]; then
    echo -e "${GREEN}${CHECK_MARK} Django app creation: PASS${NC}"
else
    echo -e "${RED}${CROSS_MARK} Django app creation: FAIL${NC}"
    exit 1
fi

# Step 2: Test Django models creation
MODELS=("ShippingAddress" "ShippingLabel" "PackageTracking" "ShippingCarrier" "ShippingInsurance" "ShippingZone" "ShippingPreference" "ShippingNotification" "DeliverySchedule" "Location" "ShippingCost" "ShippingRestriction" "OrderRestriction")
for model in "${MODELS[@]}"; do
    if grep -q "class $model(models.Model):" "ShippingAndFulfillment/models.py"; then
        echo -e "${GREEN}${CHECK_MARK} Django model $model creation: PASS${NC}"
    else
        echo -e "${RED}${CROSS_MARK} Django model $model creation: FAIL${NC}"
        exit 1
    fi
done

# Step 3: Test Django admin registration
if grep -q "@admin.register(ShippingAddress)" "ShippingAndFulfillment/admin.py"; then
    echo -e "${GREEN}${CHECK_MARK} Django admin registration: PASS${NC}"
else
    echo -e "${RED}${CROSS_MARK} Django admin registration: FAIL${NC}"
    exit 1
fi

# Step 4: Test Django migrations
if python manage.py makemigrations --dry-run ShippingAndFulfillment &> /dev/null; then
    echo -e "${GREEN}${CHECK_MARK} Django migrations creation: PASS${NC}"
else
    echo -e "${RED}${CROSS_MARK} Django migrations creation: FAIL${NC}"
    exit 1
fi



# Test script for the Search and Filtering App setup

print_header "Checking app creation - Search and Filtering"

# Step 1: Test Django app creation
if [ -d "SearchAndFiltering" ]; then
    echo -e "${GREEN}${CHECK_MARK} Django app creation: PASS${NC}"
else
    echo -e "${RED}${CROSS_MARK} Django app creation: FAIL${NC}"
    exit 1
fi

# Step 2: Test Django models creation
MODELS=("AdvancedSearchHistory" "AttributeValues" "SavedSearches" "SearchHistory" "SearchIndex" "SearchFiltersPersistence" "SearchResultsExportHistory" "SearchRelevanceRanking")
for model in "${MODELS[@]}"; do
    if grep -q "class $model(models.Model):" "SearchAndFiltering/models.py"; then
        echo -e "${GREEN}${CHECK_MARK} Django model $model creation: PASS${NC}"
    else
        echo -e "${RED}${CROSS_MARK} Django model $model creation: FAIL${NC}"
        exit 1
    fi
done

# Step 3: Test Django admin registration
if grep -q "@admin.register(AdvancedSearchHistory)" "SearchAndFiltering/admin.py"; then
    echo -e "${GREEN}${CHECK_MARK} Django admin registration: PASS${NC}"
else
    echo -e "${RED}${CROSS_MARK} Django admin registration: FAIL${NC}"
    exit 1
fi

# Step 4: Test Django migrations
if python manage.py makemigrations --dry-run SearchAndFiltering &> /dev/null; then
    echo -e "${GREEN}${CHECK_MARK} Django migrations creation: PASS${NC}"
else
    echo -e "${RED}${CROSS_MARK} Django migrations creation: FAIL${NC}"
    exit 1
fi




# Test script for the Marketing and Promotions App setup

print_header "Checking app creation - Marketing and Promotions"

# Test script for the Marketing and Promotions App setup

# Step 1: Test Django app creation
if [ -d "MarketingAndPromotions" ]; then
    echo -e "${GREEN}${CHECK_MARK} Django app creation: PASS${NC}"
else
    echo -e "${RED}${CROSS_MARK} Django app creation: FAIL${NC}"
    exit 1
fi

# Step 2: Test Django models creation
MODELS=("PromotionRules" "PromotionCoupons" "PromotionSegments" "PromotionAnalytics" "PromotionTargeting" "PromotionABTesting" "PromotionContent" "PromotionPersonalization" "PromotionCollaborationHistory" "PromotionAutomation" "PromotionIntegrations")
for model in "${MODELS[@]}"; do
    if grep -q "class $model(models.Model):" "MarketingAndPromotions/models.py"; then
        echo -e "${GREEN}${CHECK_MARK} Django model $model creation: PASS${NC}"
    else
        echo -e "${RED}${CROSS_MARK} Django model $model creation: FAIL${NC}"
        exit 1
    fi
done

# Step 3: Test Django admin registration
if grep -q "@admin.register(PromotionRules)" "MarketingAndPromotions/admin.py"; then
    echo -e "${GREEN}${CHECK_MARK} Django admin registration: PASS${NC}"
else
    echo -e "${RED}${CROSS_MARK} Django admin registration: FAIL${NC}"
    exit 1
fi

# Step 4: Test Django migrations
if python manage.py makemigrations --dry-run MarketingAndPromotions &> /dev/null; then
    echo -e "${GREEN}${CHECK_MARK} Django migrations creation: PASS${NC}"
else
    echo -e "${RED}${CROSS_MARK} Django migrations creation: FAIL${NC}"
    exit 1
fi




# Test script for the Analytics and Reporting App setup

print_header "Checking app creation - Analytics and Reporting"

# Step 1: Test Django app creation
if [ -d "AnalyticsAndReporting" ]; then
    echo -e "${GREEN}${CHECK_MARK} Django app creation: PASS${NC}"
else
    echo -e "${RED}${CROSS_MARK} Django app creation: FAIL${NC}"
    exit 1
fi

# Step 2: Test Django models creation
MODELS=("RevenueAnalytics" "CustomerBehaviorAnalytics" "ProductPerformanceAnalytics" "OrderFulfillmentAnalytics" "InventoryManagementAnalytics" "MarketingCampaignAnalytics" "CustomerServiceAnalytics" "UserEngagementAnalytics" "ConversionRateOptimizationAnalytics" "FinancialReporting" "DataVisualizationDashboards" "CustomReporting")
for model in "${MODELS[@]}"; do
    if grep -q "class $model(models.Model):" "AnalyticsAndReporting/models.py"; then
        echo -e "${GREEN}${CHECK_MARK} Django model $model creation: PASS${NC}"
    else
        echo -e "${RED}${CROSS_MARK} Django model $model creation: FAIL${NC}"
        exit 1
    fi
done

# Step 3: Test Django admin registration
if grep -q "@admin.register(RevenueAnalytics)" "AnalyticsAndReporting/admin.py"; then
    echo -e "${GREEN}${CHECK_MARK} Django admin registration: PASS${NC}"
else
    echo -e "${RED}${CROSS_MARK} Django admin registration: FAIL${NC}"
    exit 1
fi

# Step 4: Test Django migrations
if python manage.py makemigrations --dry-run AnalyticsAndReporting &> /dev/null; then
    echo -e "${GREEN}${CHECK_MARK} Django migrations creation: PASS${NC}"
else
    echo -e "${RED}${CROSS_MARK} Django migrations creation: FAIL${NC}"
    exit 1
fi




# Test script for the Wishlist Management App setup

print_header "Checking app creation - Wishlist Management"

# Step 1: Test Django app creation
if [ -d "WishlistManagement" ]; then
    echo -e "${GREEN}${CHECK_MARK} Django app creation: PASS${NC}"
else
    echo -e "${RED}${CROSS_MARK} Django app creation: FAIL${NC}"
    exit 1
fi

# Step 2: Test Django models creation
MODELS=("Wishlist" "WishlistItem" "WishlistSharing" "WishlistPrivacy" "WishlistNotification" "WishlistCollaborator" "WishlistNote" "WishlistRating" "WishlistReview" "WishlistImportExport" "WishlistRecommendation" "WishlistAnalytics" "WishlistSetting" "WishlistSync" "WishlistBackupRestore")
for model in "${MODELS[@]}"; do
    if grep -q "class $model(models.Model):" "WishlistManagement/models.py"; then
        echo -e "${GREEN}${CHECK_MARK} Django model $model creation: PASS${NC}"
    else
        echo -e "${RED}${CROSS_MARK} Django model $model creation: FAIL${NC}"
        exit 1
    fi
done

# Step 3: Test Django admin registration
if grep -q "admin.site.register(Wishlist, WishlistAdmin)" "WishlistManagement/admin.py"; then
    echo -e "${GREEN}${CHECK_MARK} Django admin registration: PASS${NC}"
else
    echo -e "${RED}${CROSS_MARK} Django admin registration: FAIL${NC}"
    exit 1
fi

# Step 4: Test Django migrations
if python manage.py makemigrations --dry-run WishlistManagement &> /dev/null; then
    echo -e "${GREEN}${CHECK_MARK} Django migrations creation: PASS${NC}"
else
    echo -e "${RED}${CROSS_MARK} Django migrations creation: FAIL${NC}"
    exit 1
fi






# Test script for the Reviews and Ratings App setup

print_header "Checking app creation - Reviews and Ratings"

# Step 1: Test Django app creation
if [ -d "ReviewsAndRatings" ]; then
    echo -e "${GREEN}${CHECK_MARK} Django app creation: PASS${NC}"
else
    echo -e "${RED}${CROSS_MARK} Django app creation: FAIL${NC}"
    exit 1
fi

# Step 2: Test Django models creation
MODELS=("Review" "ReviewReply" "ReviewFilter" "ReviewReport" "ReviewNotification" "ReviewAnalytics" "ReviewImportExport" "ReviewResponseTemplate" "ReviewAggregation" "ReviewIntegration" "ReviewGamification" "ReviewAuthentication")
for model in "${MODELS[@]}"; do
    if grep -q "class $model(models.Model):" "ReviewsAndRatings/models.py"; then
        echo -e "${GREEN}${CHECK_MARK} Django model $model creation: PASS${NC}"
    else
        echo -e "${RED}${CROSS_MARK} Django model $model creation: FAIL${NC}"
        exit 1
    fi
done

# Step 3: Test Django admin registration
if grep -q "admin.site.register(Review, ReviewAdmin)" "ReviewsAndRatings/admin.py"; then
    echo -e "${GREEN}${CHECK_MARK} Django admin registration: PASS${NC}"
else
    echo -e "${RED}${CROSS_MARK} Django admin registration: FAIL${NC}"
    exit 1
fi

# Step 4: Test Django migrations
if python manage.py makemigrations --dry-run ReviewsAndRatings &> /dev/null; then
    echo -e "${GREEN}${CHECK_MARK} Django migrations creation: PASS${NC}"
else
    echo -e "${RED}${CROSS_MARK} Django migrations creation: FAIL${NC}"
    exit 1
fi




# Test script for the Recommendation App setup

print_header "Checking app creation - Recommendations"

# Step 1: Test Django app creation
if [ -d "Recommendations" ]; then
    echo -e "${GREEN}${CHECK_MARK} Django app creation: PASS${NC}"
else
    echo -e "${RED}${CROSS_MARK} Django app creation: FAIL${NC}"
    exit 1
fi

# Step 2: Test Django models creation
MODELS=("PersonalizedRecommendation" "SimilarProduct" "TrendingProduct" "NewArrival" "Bestseller" "CrossSellProduct" "UpSellProduct" "FrequentlyBoughtTogether" "CustomerBasedRecommendation" "DynamicPricingRecommendation" "RecommendationRule" "RealTimeRecommendationUpdate" "SegmentBasedRecommendation" "FeedbackRecommendation" "RecommendationPerformanceAnalytics" "CustomerSpecificRecommendation")
for model in "${MODELS[@]}"; do
    if grep -q "class $model(models.Model):" "Recommendations/models.py"; then
        echo -e "${GREEN}${CHECK_MARK} Django model $model creation: PASS${NC}"
    else
        echo -e "${RED}${CROSS_MARK} Django model $model creation: FAIL${NC}"
        exit 1
    fi
done

# Step 3: Test Django admin registration
if grep -q "admin.site.register(PersonalizedRecommendation, PersonalizedRecommendationAdmin)" "Recommendations/admin.py"; then
    echo -e "${GREEN}${CHECK_MARK} Django admin registration: PASS${NC}"
else
    echo -e "${RED}${CROSS_MARK} Django admin registration: FAIL${NC}"
    exit 1
fi

# Step 4: Test Django migrations
if python manage.py makemigrations --dry-run Recommendations &> /dev/null; then
    echo -e "${GREEN}${CHECK_MARK} Django migrations creation: PASS${NC}"
else
    echo -e "${RED}${CROSS_MARK} Django migrations creation: FAIL${NC}"
    exit 1
fi




# Test script for the Cart Management App setup

print_header "Checking app creation - Cart Management"

# Step 1: Test Django app creation
if [ -d "CartManagement" ]; then
    echo -e "${GREEN}${CHECK_MARK} Django app creation: PASS${NC}"
else
    echo -e "${RED}${CROSS_MARK} Django app creation: FAIL${NC}"
    exit 1
fi

# Step 2: Test Django models creation
MODELS=("Cart" "CartItems" "CartItemDetails" "CartDiscounts" "CartPromotions" "CartItemNotes" "CartSharing" "CartSaveForLater" "CartExpiration" "CartPersistence" "CartRecommendations" "CartRecovery" "CartItemCustomization" "CartItemSubscription")
for model in "${MODELS[@]}"; do
    if grep -q "class $model(models.Model):" "CartManagement/models.py"; then
        echo -e "${GREEN}${CHECK_MARK} Django model $model creation: PASS${NC}"
    else
        echo -e "${RED}${CROSS_MARK} Django model $model creation: FAIL${NC}"
        exit 1
    fi
done

# Step 3: Test Django admin registration
if grep -q "@admin.register(Cart)" "CartManagement/admin.py"; then
    echo -e "${GREEN}${CHECK_MARK} Django admin registration: PASS${NC}"
else
    echo -e "${RED}${CROSS_MARK} Django admin registration: FAIL${NC}"
    exit 1
fi

# Step 4: Test Django migrations
if python manage.py makemigrations --dry-run CartManagement &> /dev/null; then
    echo -e "${GREEN}${CHECK_MARK} Django migrations creation: PASS${NC}"
else
    echo -e "${RED}${CROSS_MARK} Django migrations creation: FAIL${NC}"
    exit 1
fi





# Test script for the Subscription Management App setup

print_header "Checking app creation - Subscription Management"

# Step 1: Test Django app creation
if [ -d "SubscriptionManagement" ]; then
    echo -e "${GREEN}${CHECK_MARK} Django app creation: PASS${NC}"
else
    echo -e "${RED}${CROSS_MARK} Django app creation: FAIL${NC}"
    exit 1
fi

# Step 2: Test Django models creation
MODELS=("Subscriptions" "SubscriptionPlans" "SubscriptionCancellationReasons" "SubscriptionRenewalReminders" "SubscriptionPaymentMethods" "SubscriptionUsageTracking" "SubscriptionAnalytics" "SubscriptionDiscounts" "SubscriptionCustomizationOptions")
for model in "${MODELS[@]}"; do
    if grep -q "class $model(models.Model):" "SubscriptionManagement/models.py"; then
        echo -e "${GREEN}${CHECK_MARK} Django model $model creation: PASS${NC}"
    else
        echo -e "${RED}${CROSS_MARK} Django model $model creation: FAIL${NC}"
        exit 1
    fi
done

# Step 3: Test Django admin registration
if grep -q "@admin.register(Subscriptions)" "SubscriptionManagement/admin.py"; then
    echo -e "${GREEN}${CHECK_MARK} Django admin registration: PASS${NC}"
else
    echo -e "${RED}${CROSS_MARK} Django admin registration: FAIL${NC}"
    exit 1
fi

# Step 4: Test Django migrations
if python manage.py makemigrations --dry-run SubscriptionManagement &> /dev/null; then
    echo -e "${GREEN}${CHECK_MARK} Django migrations creation: PASS${NC}"
else
    echo -e "${RED}${CROSS_MARK} Django migrations creation: FAIL${NC}"
    exit 1
fi





# Test script for the Order Tracking App setup

print_header "Checking app creation - Order Tracking"

# Step 1: Test Django app creation
if [ -d "OrderTracking" ]; then
    echo -e "${GREEN}${CHECK_MARK} Django app creation: PASS${NC}"
else
    echo -e "${RED}${CROSS_MARK} Django app creation: FAIL${NC}"
    exit 1
fi

# Step 2: Test Django models creation
MODELS=("OrderTracking" "TrackingUpdates" "DeliveryRoutes" "ProofOfDelivery" "DeliveryNotifications" "DeliveryIssues" "CarrierIntegration" "DeliveryHistory" "DeliverySignatures")
for model in "${MODELS[@]}"; do
    if grep -q "class $model(models.Model):" "OrderTracking/models.py"; then
        echo -e "${GREEN}${CHECK_MARK} Django model $model creation: PASS${NC}"
    else
        echo -e "${RED}${CROSS_MARK} Django model $model creation: FAIL${NC}"
        exit 1
    fi
done

# Step 3: Test Django admin registration
if grep -q "admin.site.register(OrderTracking, OrderTrackingAdmin)" "OrderTracking/admin.py"; then
    echo -e "${GREEN}${CHECK_MARK} Django admin registration: PASS${NC}"
else
    echo -e "${RED}${CROSS_MARK} Django admin registration: FAIL${NC}"
    exit 1
fi

# Step 4: Test Django migrations
if python manage.py makemigrations --dry-run OrderTracking &> /dev/null; then
    echo -e "${GREEN}${CHECK_MARK} Django migrations creation: PASS${NC}"
else
    echo -e "${RED}${CROSS_MARK} Django migrations creation: FAIL${NC}"
    exit 1
fi





# Test script for the Customer Support App setup

print_header "Checking app creation - Customer Support"

# Step 1: Test Django app creation
if [ -d "CustomerSupport" ]; then
    echo -e "${GREEN}${CHECK_MARK} Django app creation: PASS${NC}"
else
    echo -e "${RED}${CROSS_MARK} Django app creation: FAIL${NC}"
    exit 1
fi

# Step 2: Test Django models creation
MODELS=("LiveChatSession" "ChatHistory" "AgentAvailability" "SupportTicket" "FAQ" "KnowledgeBaseArticle" "CustomerFeedback" "Escalation" "SupportAnalytics" "SupportAvailability" "SupportLanguage" "SupportResource" "AgentPerformance" "SupportIntegration")
for model in "${MODELS[@]}"; do
    if grep -q "class $model(models.Model):" "CustomerSupport/models.py"; then
        echo -e "${GREEN}${CHECK_MARK} Django model $model creation: PASS${NC}"
    else
        echo -e "${RED}${CROSS_MARK} Django model $model creation: FAIL${NC}"
        exit 1
    fi
done

# Step 3: Test Django admin registration
if grep -q "admin.site.register(LiveChatSession, LiveChatSessionAdmin)" "CustomerSupport/admin.py"; then
    echo -e "${GREEN}${CHECK_MARK} Django admin registration: PASS${NC}"
else
    echo -e "${RED}${CROSS_MARK} Django admin registration: FAIL${NC}"
    exit 1
fi

# Step 4: Test Django migrations
if python manage.py makemigrations --dry-run CustomerSupport &> /dev/null; then
    echo -e "${GREEN}${CHECK_MARK} Django migrations creation: PASS${NC}"
else
    echo -e "${RED}${CROSS_MARK} Django migrations creation: FAIL${NC}"
    exit 1
fi



# Test script for the Social Share App setup

print_header "Checking app creation - Social Share"

# Step 1: Test Django app creation
if [ -d "SocialShare" ]; then
    echo -e "${GREEN}${CHECK_MARK} Django app creation: PASS${NC}"
else
    echo -e "${RED}${CROSS_MARK} Django app creation: FAIL${NC}"
    exit 1
fi

# Step 2: Test Django models creation
MODELS=("SocialShare" "SocialAnalytics" "SocialLike" "SocialComment" "SocialPrivacy" "UserSocialProfile" "SocialBadge" "SocialReward" "SocialRecommendation" "SocialTrendingTopic" "InfluencerCampaign" "SocialCollaboration" "CMSIntegration")
for model in "${MODELS[@]}"; do
    if grep -q "class $model(models.Model):" "SocialShare/models.py"; then
        echo -e "${GREEN}${CHECK_MARK} Django model $model creation: PASS${NC}"
    else
        echo -e "${RED}${CROSS_MARK} Django model $model creation: FAIL${NC}"
        exit 1
    fi
done

# Step 3: Test Django admin registration
if grep -q "admin.site.register(SocialShare, SocialShareAdmin)" "SocialShare/admin.py"; then
    echo -e "${GREEN}${CHECK_MARK} Django admin registration: PASS${NC}"
else
    echo -e "${RED}${CROSS_MARK} Django admin registration: FAIL${NC}"
    exit 1
fi

# Step 4: Test Django migrations
if python manage.py makemigrations --dry-run SocialShare &> /dev/null; then
    echo -e "${GREEN}${CHECK_MARK} Django migrations creation: PASS${NC}"
else
    echo -e "${RED}${CROSS_MARK} Django migrations creation: FAIL${NC}"
    exit 1
fi


# Test script for the Loyalty Program App setup

print_header "Checking app creation - Loyalty Program"

# Step 1: Test Django app creation
if [ -d "LoyaltyProgram" ]; then
    echo -e "${GREEN}${CHECK_MARK} Django app creation: PASS${NC}"
else
    echo -e "${RED}${CROSS_MARK} Django app creation: FAIL${NC}"
    exit 1
fi

# Step 2: Test Django models creation
MODELS=("LoyaltyEnrollment" "LoyaltyPointsHistory" "LoyaltyRedemptionHistory" "LoyaltyTier" "LoyaltyMembershipStatus" "LoyaltyEarningOpportunity" "LoyaltyCustomization" "LoyaltyPromotion" "LoyaltyPointsTransfer" "LoyaltyAnalytics" "LoyaltyReferral" "LoyaltyNotification")
for model in "${MODELS[@]}"; do
    if grep -q "class $model(models.Model):" "LoyaltyProgram/models.py"; then
        echo -e "${GREEN}${CHECK_MARK} Django model $model creation: PASS${NC}"
    else
        echo -e "${RED}${CROSS_MARK} Django model $model creation: FAIL${NC}"
        exit 1
    fi
done

# Step 3: Test Django admin registration
if grep -q "admin.site.register(LoyaltyEnrollment, LoyaltyEnrollmentAdmin)" "LoyaltyProgram/admin.py"; then
    echo -e "${GREEN}${CHECK_MARK} Django admin registration: PASS${NC}"
else
    echo -e "${RED}${CROSS_MARK} Django admin registration: FAIL${NC}"
    exit 1
fi

# Step 4: Test Django migrations
if python manage.py makemigrations --dry-run LoyaltyProgram &> /dev/null; then
    echo -e "${GREEN}${CHECK_MARK} Django migrations creation: PASS${NC}"
else
    echo -e "${RED}${CROSS_MARK} Django migrations creation: FAIL${NC}"
    exit 1
fi


# Apply migrations
if python manage.py migrate --noinput &> /dev/null; then
    echo -e "${GREEN}${CHECK_MARK} Applying migrations: PASS${NC}"
else
    echo -e "${RED}${CROSS_MARK} Applying migrations: FAIL${NC}"
    exit 1
fi


print_header "All migrations applied successfully!"
print_header "All tests passed successfully!"
print_header "Setup is complete. Activate your virtual environment with 'source .env/bin/activate' and run the server with 'python manage.py runserver'."





# Ensure curl is available
if ! command -v curl &> /dev/null; then
  echo "curl command not found. Installing curl..."
  # Update package list and install curl based on the OS
  if [[ "$(uname -s)" == "Linux" ]]; then
    if [[ -f /etc/debian_version ]]; then
      sudo apt update && sudo apt install -y curl
    elif [[ -f /etc/redhat-release ]]; then
      sudo yum install -y curl
    else
      echo "Unsupported Linux distribution. Please install curl manually."
      exit 1
    fi
  elif [[ "$(uname -s)" == "Darwin" ]]; then
    if ! command -v brew &> /dev/null; then
      echo "Homebrew not found. Please install Homebrew first: https://brew.sh/"
      exit 1
    else
      brew install curl
    fi
  else
    echo "Unsupported OS. Please install curl manually."
    exit 1
  fi
fi




# GitHub repository URL
repo_url="https://api.github.com/repos/tovfikur/E-Com/contents/apis"
raw_base_url="https://raw.githubusercontent.com/tovfikur/E-Com/main/apis"

# Fetch the list of files from the GitHub repository using the API
json_content=$(curl -s "$repo_url")
if [[ -z "$json_content" ]]; then
  echo "Failed to fetch JSON content from $repo_url."
  exit 1
fi

# Extract the script file names from the JSON content
script_files=$(echo "$json_content" | jq -r '.[] | select(.name | endswith(".sh")) | .name')

# Check if any scripts were found
if [[ -z "$script_files" ]]; then
  echo "No .sh scripts found in $repo_url."
  exit 1
fi

# Loop through each script file and execute it directly from GitHub
for script_file in $script_files; do
  # Construct the full URL for the script
  file_url="$raw_base_url/$script_file"

  # Execute the script directly from GitHub
  echo "Executing $script_file from $file_url..."
  curl -s "$file_url" | bash
done