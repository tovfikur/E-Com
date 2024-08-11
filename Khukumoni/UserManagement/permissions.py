# permissions.py
from rest_framework.permissions import BasePermission
from .utils import get_domain_from_request, is_user_permitted

class IsDomainAndUserPermitted(BasePermission):
    def has_permission(self, request, view):
        # Allow safe methods (GET, HEAD, OPTIONS)
        if request.method in ['GET', 'HEAD', 'OPTIONS']:
            return True
        
        user = request.user
        domain = get_domain_from_request(request)

        # Check if the user is authenticated and permitted
        if not user.is_authenticated or not is_user_permitted(user, domain):
            return False

        return True

    def has_object_permission(self, request, view, obj):
        # Further object-level permissions can be implemented here if needed
        return True
