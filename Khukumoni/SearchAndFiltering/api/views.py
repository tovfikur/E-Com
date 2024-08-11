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
