from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import (
    WishlistViewSet, WishlistItemViewSet, WishlistSharingViewSet, WishlistPrivacyViewSet, WishlistNotificationViewSet, 
    WishlistCollaboratorViewSet, WishlistNoteViewSet, WishlistRatingViewSet, WishlistReviewViewSet, 
    WishlistImportExportViewSet, WishlistRecommendationViewSet, WishlistAnalyticsViewSet, WishlistSettingViewSet, 
    WishlistSyncViewSet, WishlistBackupRestoreViewSet
)

router = DefaultRouter()
router.register(r'wishlist', WishlistViewSet)
router.register(r'wishlist-item', WishlistItemViewSet)
router.register(r'wishlist-sharing', WishlistSharingViewSet)
router.register(r'wishlist-privacy', WishlistPrivacyViewSet)
router.register(r'wishlist-notification', WishlistNotificationViewSet)
router.register(r'wishlist-collaborator', WishlistCollaboratorViewSet)
router.register(r'wishlist-note', WishlistNoteViewSet)
router.register(r'wishlist-rating', WishlistRatingViewSet)
router.register(r'wishlist-review', WishlistReviewViewSet)
router.register(r'wishlist-import-export', WishlistImportExportViewSet)
router.register(r'wishlist-recommendation', WishlistRecommendationViewSet)
router.register(r'wishlist-analytics', WishlistAnalyticsViewSet)
router.register(r'wishlist-setting', WishlistSettingViewSet)
router.register(r'wishlist-sync', WishlistSyncViewSet)
router.register(r'wishlist-backup-restore', WishlistBackupRestoreViewSet)

urlpatterns = [
    path('', include(router.urls)),
]
