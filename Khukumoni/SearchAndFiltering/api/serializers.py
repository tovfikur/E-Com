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
