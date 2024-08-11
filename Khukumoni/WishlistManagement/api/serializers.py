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

