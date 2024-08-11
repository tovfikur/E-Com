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
