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
