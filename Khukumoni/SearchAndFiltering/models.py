from django.db import models
from django.conf import settings

class AdvancedSearchHistory(models.Model):
    search_id = models.IntegerField(primary_key=True)
    search_type = models.CharField(max_length=255)
    search_query = models.CharField(max_length=255)
    user = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE)
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
    user = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE)
    saved_at = models.DateTimeField()

class SearchHistory(models.Model):
    history_id = models.IntegerField(primary_key=True)
    search_type = models.CharField(max_length=255)
    search_query = models.CharField(max_length=255)
    user = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE)
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
    user = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE)
    filter_settings = models.JSONField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class SearchResultsExportHistory(models.Model):
    export_id = models.IntegerField(primary_key=True)
    search_type = models.CharField(max_length=255)
    export_query = models.CharField(max_length=255)
    user = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE)
    exported_at = models.DateTimeField()

class SearchRelevanceRanking(models.Model):
    ranking_id = models.IntegerField(primary_key=True)
    search_type = models.CharField(max_length=255)
    ranking_settings = models.JSONField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
