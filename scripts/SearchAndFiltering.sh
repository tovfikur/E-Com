#!/bin/bash

APP_NAME="SearchAndFiltering"
PROJECT_NAME="Khukumoni"
API_DIR="../$PROJECT_NAME/$APP_NAME/api"
VIEWS_FILE="$API_DIR/views.py"
URLS_FILE="$API_DIR/urls.py"
SERIALIZERS_FILE="$API_DIR/serializers.py"
SETTINGS_FILE="../$PROJECT_NAME/$PROJECT_NAME/settings.py"
PROJECT_URLS_FILE="../$PROJECT_NAME/$PROJECT_NAME/urls.py"
APP_URLS_FILE="../$PROJECT_NAME/$APP_NAME/urls.py"

# Create the api folder and files
mkdir -p $API_DIR
touch $API_DIR/__init__.py

# Create serializers.py
cat <<EOF > $SERIALIZERS_FILE
from rest_framework import serializers
from django.contrib.auth.models import User
from ..models import (
    AdvancedSearchHistory, AttributeValues, SavedSearches, SearchHistory,
    SearchIndex, SearchFiltersPersistence, SearchResultsExportHistory,
    SearchRelevanceRanking
)

class AdvancedSearchHistorySerializer(serializers.ModelSerializer):
    class Meta:
        model = AdvancedSearchHistory
        fields = '__all__'

class AttributeValuesSerializer(serializers.ModelSerializer):
    class Meta:
        model = AttributeValues
        fields = '__all__'

class SavedSearchesSerializer(serializers.ModelSerializer):
    class Meta:
        model = SavedSearches
        fields = '__all__'

class SearchHistorySerializer(serializers.ModelSerializer):
    class Meta:
        model = SearchHistory
        fields = '__all__'

class SearchIndexSerializer(serializers.ModelSerializer):
    class Meta:
        model = SearchIndex
        fields = '__all__'

class SearchFiltersPersistenceSerializer(serializers.ModelSerializer):
    class Meta:
        model = SearchFiltersPersistence
        fields = '__all__'

class SearchResultsExportHistorySerializer(serializers.ModelSerializer):
    class Meta:
        model = SearchResultsExportHistory
        fields = '__all__'

class SearchRelevanceRankingSerializer(serializers.ModelSerializer):
    class Meta:
        model = SearchRelevanceRanking
        fields = '__all__'
EOF

# Create views.py
cat <<EOF > $VIEWS_FILE
from rest_framework import viewsets
from ..models import (
    AdvancedSearchHistory, AttributeValues, SavedSearches, SearchHistory,
    SearchIndex, SearchFiltersPersistence, SearchResultsExportHistory,
    SearchRelevanceRanking
)
from .serializers import (
    AdvancedSearchHistorySerializer, AttributeValuesSerializer, SavedSearchesSerializer,
    SearchHistorySerializer, SearchIndexSerializer, SearchFiltersPersistenceSerializer,
    SearchResultsExportHistorySerializer, SearchRelevanceRankingSerializer
)

class AdvancedSearchHistoryViewSet(viewsets.ModelViewSet):
    queryset = AdvancedSearchHistory.objects.all()
    serializer_class = AdvancedSearchHistorySerializer

class AttributeValuesViewSet(viewsets.ModelViewSet):
    queryset = AttributeValues.objects.all()
    serializer_class = AttributeValuesSerializer

class SavedSearchesViewSet(viewsets.ModelViewSet):
    queryset = SavedSearches.objects.all()
    serializer_class = SavedSearchesSerializer

class SearchHistoryViewSet(viewsets.ModelViewSet):
    queryset = SearchHistory.objects.all()
    serializer_class = SearchHistorySerializer

class SearchIndexViewSet(viewsets.ModelViewSet):
    queryset = SearchIndex.objects.all()
    serializer_class = SearchIndexSerializer

class SearchFiltersPersistenceViewSet(viewsets.ModelViewSet):
    queryset = SearchFiltersPersistence.objects.all()
    serializer_class = SearchFiltersPersistenceSerializer

class SearchResultsExportHistoryViewSet(viewsets.ModelViewSet):
    queryset = SearchResultsExportHistory.objects.all()
    serializer_class = SearchResultsExportHistorySerializer

class SearchRelevanceRankingViewSet(viewsets.ModelViewSet):
    queryset = SearchRelevanceRanking.objects.all()
    serializer_class = SearchRelevanceRankingSerializer
EOF

# Create urls.py
cat <<EOF > $URLS_FILE
from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import (
    AdvancedSearchHistoryViewSet, AttributeValuesViewSet, SavedSearchesViewSet,
    SearchHistoryViewSet, SearchIndexViewSet, SearchFiltersPersistenceViewSet,
    SearchResultsExportHistoryViewSet, SearchRelevanceRankingViewSet
)

router = DefaultRouter()
router.register(r'advanced_search_history', AdvancedSearchHistoryViewSet)
router.register(r'attribute_values', AttributeValuesViewSet)
router.register(r'saved_searches', SavedSearchesViewSet)
router.register(r'search_history', SearchHistoryViewSet)
router.register(r'search_index', SearchIndexViewSet)
router.register(r'search_filters_persistence', SearchFiltersPersistenceViewSet)
router.register(r'search_results_export_history', SearchResultsExportHistoryViewSet)
router.register(r'search_relevance_ranking', SearchRelevanceRankingViewSet)

urlpatterns = [
    path('', include(router.urls)),
]
EOF

# Ensure the main project urls.py file exists and include the api urls
if [ ! -f "$APP_URLS_FILE" ]; then
    # Create the main urls.py if it does not exist
    cat <<EOF > $APP_URLS_FILE
from django.urls import path, include

urlpatterns = [
    path('api/', include('$APP_NAME.api.urls')),
]
EOF
else
    # Add the api path if it's not already included
    if ! grep -q "path('api/', include('$APP_NAME.api.urls'))" "$APP_URLS_FILE"; then
        sed -i "/urlpatterns = \[/a \ \ \ \ path('api/', include('$APP_NAME.api.urls'))," $APP_URLS_FILE
    fi
fi

# Add the app path to the main project urls.py if not already included
if ! grep -q "path('$APP_NAME/', include('$APP_NAME.urls'))" "$PROJECT_URLS_FILE"; then
    sed -i "/urlpatterns = \[/a \ \ \ \ path('$APP_NAME/', include('$APP_NAME.urls'))," $PROJECT_URLS_FILE
fi

# Ensure the app is added to INSTALLED_APPS in settings.py
if ! grep -q "'$APP_NAME'," "$SETTINGS_FILE"; then
    sed -i "/INSTALLED_APPS = \[/a \ \ \ \ '$APP_NAME'," $SETTINGS_FILE
fi

echo "API setup for SearchAndFiltering completed successfully."