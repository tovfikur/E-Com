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

