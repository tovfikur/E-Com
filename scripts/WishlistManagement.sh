#!/bin/bash

APP_NAME="WishlistManagement"
PROJECT_NAME="Khukumoni"
API_DIR="../$PROJECT_NAME/$APP_NAME/api"
VIEWS_FILE="$API_DIR/views.py"
URLS_FILE="$API_DIR/urls.py"
SERIALIZERS_FILE="$API_DIR/serializers.py"
PROJECT_URLS_FILE="../$PROJECT_NAME/$PROJECT_NAME/urls.py"
APP_URLS_FILE="../$PROJECT_NAME/$APP_NAME/urls.py"

# Create the api folder and files
mkdir -p $API_DIR
touch $API_DIR/__init__.py

# Create serializers.py
cat <<EOF > $SERIALIZERS_FILE
from rest_framework import serializers
from ..models import (
    Wishlist, WishlistItem, WishlistSharing, WishlistPrivacy, WishlistNotification, 
    WishlistCollaborator, WishlistNote, WishlistRating, WishlistReview, 
    WishlistImportExport, WishlistRecommendation, WishlistAnalytics, WishlistSetting, 
    WishlistSync, WishlistBackupRestore
)

class WishlistSerializer(serializers.ModelSerializer):
    class Meta:
        model = Wishlist
        fields = '__all__'

class WishlistItemSerializer(serializers.ModelSerializer):
    class Meta:
        model = WishlistItem
        fields = '__all__'

class WishlistSharingSerializer(serializers.ModelSerializer):
    class Meta:
        model = WishlistSharing
        fields = '__all__'

class WishlistPrivacySerializer(serializers.ModelSerializer):
    class Meta:
        model = WishlistPrivacy
        fields = '__all__'

class WishlistNotificationSerializer(serializers.ModelSerializer):
    class Meta:
        model = WishlistNotification
        fields = '__all__'

class WishlistCollaboratorSerializer(serializers.ModelSerializer):
    class Meta:
        model = WishlistCollaborator
        fields = '__all__'

class WishlistNoteSerializer(serializers.ModelSerializer):
    class Meta:
        model = WishlistNote
        fields = '__all__'

class WishlistRatingSerializer(serializers.ModelSerializer):
    class Meta:
        model = WishlistRating
        fields = '__all__'

class WishlistReviewSerializer(serializers.ModelSerializer):
    class Meta:
        model = WishlistReview
        fields = '__all__'

class WishlistImportExportSerializer(serializers.ModelSerializer):
    class Meta:
        model = WishlistImportExport
        fields = '__all__'

class WishlistRecommendationSerializer(serializers.ModelSerializer):
    class Meta:
        model = WishlistRecommendation
        fields = '__all__'

class WishlistAnalyticsSerializer(serializers.ModelSerializer):
    class Meta:
        model = WishlistAnalytics
        fields = '__all__'

class WishlistSettingSerializer(serializers.ModelSerializer):
    class Meta:
        model = WishlistSetting
        fields = '__all__'

class WishlistSyncSerializer(serializers.ModelSerializer):
    class Meta:
        model = WishlistSync
        fields = '__all__'

class WishlistBackupRestoreSerializer(serializers.ModelSerializer):
    class Meta:
        model = WishlistBackupRestore
        fields = '__all__'

EOF

# Create views.py
cat <<EOF > $VIEWS_FILE
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

EOF

# Create urls.py
cat <<EOF > $URLS_FILE
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


echo "API setup for $APP_NAME completed."
