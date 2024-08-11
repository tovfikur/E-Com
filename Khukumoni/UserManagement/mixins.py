class UserFilteredAdminMixin:
    def get_queryset(self, request):
        qs = super().get_queryset(request)
        try:
            if not request.user.is_superuser:
                qs = qs.filter(user=request.user)
        except:
            pass
        return qs

    def save_model(self, request, obj, form, change):
        try:
            if not obj.user:
                obj.user = request.user
            super().save_model(request, obj, form, change)
        except:
            super().save_model(request, obj, form, change)
