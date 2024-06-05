# # install npm
# # install required packages

# APP_NAME="frontend"
# PROJECT_NAME="Khukumoni"
# VIEWS_FILE="../$PROJECT_NAME/$APP_NAME/views.py"
# URLS_FILE="../$PROJECT_NAME/$APP_NAME/urls.py"
# SETTINGS_FILE="../$PROJECT_NAME/$PROJECT_NAME/settings.py"
# PROJECT_URLS_FILE="../$PROJECT_NAME/$PROJECT_NAME/urls.py"
# APP_URL = "../$PROJECT_NAME/$APP_NAME/"



# # Step 3: Create views.py
# cat <<EOF > $VIEWS_FILE



# EOF




# # Step 4: Create urls.py
# cat <<EOF > $URLS_FILE



# EOF


# mkdir -p $APP_URL/templates/
# mkdir -p $APP_URL/static/
# mkdir -p $APP_URL/static/css/
# mkdir -p $APP_URL/static/frontend/
# mkdir -p $APP_URL/static/images/
# mkdir -p $APP_URL/src
# mkdir -p $APP_URL/src/components


# cd ../$PROJECT_NAME/$APP_NAME/
# npm init -y

# # Step 6: Add the app path to the main project urls.py if not already included
# if ! grep -q "path('', include('$APP_NAME.urls'))" "$PROJECT_URLS_FILE"; then
#     sed -i "/urlpatterns = \[/a \ \ \ \ path('', include('$APP_NAME.urls'))," $PROJECT_URLS_FILE
# fi

# # Display success message
# echo "API setup for $APP_NAME completed."