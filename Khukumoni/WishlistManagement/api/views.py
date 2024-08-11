from rest_framework import viewsets
from ..models import (
    Wishlist, WishlistItem, WishlistSharing, WishlistPrivacy, WishlistNotification, 
    WishlistCollaborator, WishlistNote, WishlistRating, WishlistReview, 
    WishlistImportExport, WishlistRecommendation, WishlistAnalytics, WishlistSetting, 
    WishlistSync, WishlistBackupRestore
)
from .serializers import (
    WishlistSerializer, WishlistItemSerializer, WishlistSharingSerializer, WishlistPrivacySerializer, WishlistNotificationSerializer, 
    WishlistCollaboratorSerializer, WishlistNoteSerializer, WishlistRatingSerializer, WishlistReviewSerializer, 
    WishlistImportExportSerializer, WishlistRecommendationSerializer, WishlistAnalyticsSerializer, WishlistSettingSerializer, 
    WishlistSyncSerializer, WishlistBackupRestoreSerializer
)

class WishlistViewSet(viewsets.ModelViewSet):
    queryset = Wishlist.objects.all()
    serializer_class = WishlistSerializer

class WishlistItemViewSet(viewsets.ModelViewSet):
    queryset = WishlistItem.objects.all()
    serializer_class = WishlistItemSerializer

class WishlistSharingViewSet(viewsets.ModelViewSet):
    queryset = WishlistSharing.objects.all()
    serializer_class = WishlistSharingSerializer

class WishlistPrivacyViewSet(viewsets.ModelViewSet):
    queryset = WishlistPrivacy.objects.all()
    serializer_class = WishlistPrivacySerializer

class WishlistNotificationViewSet(viewsets.ModelViewSet):
    queryset = WishlistNotification.objects.all()
    serializer_class = WishlistNotificationSerializer

class WishlistCollaboratorViewSet(viewsets.ModelViewSet):
    queryset = WishlistCollaborator.objects.all()
    serializer_class = WishlistCollaboratorSerializer

class WishlistNoteViewSet(viewsets.ModelViewSet):
    queryset = WishlistNote.objects.all()
    serializer_class = WishlistNoteSerializer

class WishlistRatingViewSet(viewsets.ModelViewSet):
    queryset = WishlistRating.objects.all()
    serializer_class = WishlistRatingSerializer

class WishlistReviewViewSet(viewsets.ModelViewSet):
    queryset = WishlistReview.objects.all()
    serializer_class = WishlistReviewSerializer

class WishlistImportExportViewSet(viewsets.ModelViewSet):
    queryset = WishlistImportExport.objects.all()
    serializer_class = WishlistImportExportSerializer

class WishlistRecommendationViewSet(viewsets.ModelViewSet):
    queryset = WishlistRecommendation.objects.all()
    serializer_class = WishlistRecommendationSerializer

class WishlistAnalyticsViewSet(viewsets.ModelViewSet):
    queryset = WishlistAnalytics.objects.all()
    serializer_class = WishlistAnalyticsSerializer

class WishlistSettingViewSet(viewsets.ModelViewSet):
    queryset = WishlistSetting.objects.all()
    serializer_class = WishlistSettingSerializer

class WishlistSyncViewSet(viewsets.ModelViewSet):
    queryset = WishlistSync.objects.all()
    serializer_class = WishlistSyncSerializer

class WishlistBackupRestoreViewSet(viewsets.ModelViewSet):
    queryset = WishlistBackupRestore.objects.all()
    serializer_class = WishlistBackupRestoreSerializer

