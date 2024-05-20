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


# Test script for the Django setup script


print_header "Test Python virtual environment creation"
# Step 1: Test Python virtual environment creation
if [ -d "khukumoni_env" ]; then
    echo -e "${GREEN}${CHECK_MARK} Virtual environment creation: PASS${NC}"
else
    echo -e "${RED}${CROSS_MARK} Virtual environment creation: FAIL${NC}"
    exit 1
fi

# Step 2: Test virtual environment activation
# This can be tricky to test because the script changes the shell environment.
# You can check if the virtual environment is activated by checking if pip points to the virtual environment.
source khukumoni_env/bin/activate
if [[ $(pip --version) == *"khukumoni_env"* ]]; then
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

# Step 6: Test URL patterns update
URLS_FILE="Khukumoni/urls.py"

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
MODELS=("Brand" "Category" "Product" "Inventory" "Variant" "Image" "Video" "Pricing" "Discount")
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




