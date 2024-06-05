# # install npm
# # install required packages

# APP_NAME="frontend"
# PROJECT_NAME="Khukumoni"
# VIEWS_FILE="../$PROJECT_NAME/$APP_NAME/views.py"
# URLS_FILE="../$PROJECT_NAME/$APP_NAME/urls.py"
# SETTINGS_FILE="../$PROJECT_NAME/$PROJECT_NAME/settings.py"
# PROJECT_URLS_FILE="../$PROJECT_NAME/$PROJECT_NAME/urls.py"



# # Step 3: Create views.py
# cat <<EOF > $VIEWS_FILE



# EOF




# # Step 4: Create urls.py
# cat <<EOF > $URLS_FILE



# EOF


# # Step 6: Add the app path to the main project urls.py if not already included
# if ! grep -q "path('', include('$APP_NAME.urls'))" "$PROJECT_URLS_FILE"; then
#     sed -i "/urlpatterns = \[/a \ \ \ \ path('', include('$APP_NAME.urls'))," $PROJECT_URLS_FILE
# fi

# # Display success message
# echo "API setup for $APP_NAME completed."