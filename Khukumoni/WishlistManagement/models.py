from django.db import models

class Wishlist(models.Model):
    wishlist_id = models.AutoField(primary_key=True)
    user_id = models.IntegerField()
    name = models.CharField(max_length=255)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    privacy_setting = models.CharField(max_length=20)

class WishlistItem(models.Model):
    item_id = models.AutoField(primary_key=True)
    wishlist_id = models.ForeignKey(Wishlist, on_delete=models.CASCADE)
    product_id = models.IntegerField()
    added_at = models.DateTimeField(auto_now_add=True)

class WishlistSharing(models.Model):
    share_id = models.AutoField(primary_key=True)
    wishlist_id = models.ForeignKey(Wishlist, on_delete=models.CASCADE)
    shared_with = models.CharField(max_length=255)
    shared_at = models.DateTimeField(auto_now_add=True)

class WishlistPrivacy(models.Model):
    privacy_id = models.AutoField(primary_key=True)
    wishlist_id = models.ForeignKey(Wishlist, on_delete=models.CASCADE)
    setting = models.CharField(max_length=20)
    updated_at = models.DateTimeField(auto_now=True)

class WishlistNotification(models.Model):
    notification_id = models.AutoField(primary_key=True)
    wishlist_id = models.ForeignKey(Wishlist, on_delete=models.CASCADE)
    user_id = models.IntegerField()
    subscribed = models.BooleanField(default=False)
    subscribed_at = models.DateTimeField(auto_now_add=True)

class WishlistCollaborator(models.Model):
    collaboration_id = models.AutoField(primary_key=True)
    wishlist_id = models.ForeignKey(Wishlist, on_delete=models.CASCADE)
    collaborator_id = models.IntegerField()
    role = models.CharField(max_length=20)
    status = models.CharField(max_length=20)
    invited_at = models.DateTimeField(auto_now_add=True)
    accepted_at = models.DateTimeField(null=True, blank=True)

class WishlistNote(models.Model):
    note_id = models.AutoField(primary_key=True)
    wishlist_id = models.ForeignKey(Wishlist, on_delete=models.CASCADE)
    item_id = models.ForeignKey(WishlistItem, on_delete=models.CASCADE)
    note = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

class WishlistRating(models.Model):
    rating_id = models.AutoField(primary_key=True)
    wishlist_id = models.ForeignKey(Wishlist, on_delete=models.CASCADE)
    item_id = models.ForeignKey(WishlistItem, on_delete=models.CASCADE)
    rating = models.IntegerField()
    rated_at = models.DateTimeField(auto_now_add=True)

class WishlistReview(models.Model):
    review_id = models.AutoField(primary_key=True)
    wishlist_id = models.ForeignKey(Wishlist, on_delete=models.CASCADE)
    item_id = models.ForeignKey(WishlistItem, on_delete=models.CASCADE)
    review = models.TextField()
    reviewed_at = models.DateTimeField(auto_now_add=True)

class WishlistImportExport(models.Model):
    operation_id = models.AutoField(primary_key=True)
    wishlist_id = models.ForeignKey(Wishlist, on_delete=models.CASCADE)
    operation_type = models.CharField(max_length=20)
    status = models.CharField(max_length=20)
    created_at = models.DateTimeField(auto_now_add=True)
    completed_at = models.DateTimeField(null=True, blank=True)

class WishlistRecommendation(models.Model):
    recommendation_id = models.AutoField(primary_key=True)
    wishlist_id = models.ForeignKey(Wishlist, on_delete=models.CASCADE)
    recommendations = models.JSONField()
    generated_at = models.DateTimeField(auto_now_add=True)

class WishlistAnalytics(models.Model):
    analytics_id = models.AutoField(primary_key=True)
    wishlist_id = models.ForeignKey(Wishlist, on_delete=models.CASCADE)
    views = models.IntegerField()
    engagement = models.IntegerField()
    conversion_rate = models.DecimalField(max_digits=10, decimal_places=2)
    updated_at = models.DateTimeField(auto_now=True)

class WishlistSetting(models.Model):
    setting_id = models.AutoField(primary_key=True)
    wishlist_id = models.ForeignKey(Wishlist, on_delete=models.CASCADE)
    settings = models.JSONField()
    updated_at = models.DateTimeField(auto_now=True)

class WishlistSync(models.Model):
    sync_id = models.AutoField(primary_key=True)
    user_id = models.IntegerField()
    devices = models.JSONField()
    last_synced_at = models.DateTimeField(auto_now=True)

class WishlistBackupRestore(models.Model):
    backup_restore_id = models.AutoField(primary_key=True)
    wishlist_id = models.ForeignKey(Wishlist, on_delete=models.CASCADE)
    operation_type = models.CharField(max_length=20)
    status = models.CharField(max_length=20)
    created_at = models.DateTimeField(auto_now_add=True)
    completed_at = models.DateTimeField(null=True, blank=True)
