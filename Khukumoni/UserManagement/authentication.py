import logging
from django.contrib.auth.backends import ModelBackend
from django.contrib.auth import get_user_model

logger = logging.getLogger(__name__)

class DomainRestrictionBackend(ModelBackend):
    def authenticate(self, request, username=None, password=None, **kwargs):
        User = get_user_model()
        
        try:
            user = User.objects.get(email=username)
        except User.DoesNotExist:
            logger.warning(f"User with email {username} does not exist.")
            return None
        
        # Perform domain check
        if user.domain == request.META.get('HTTP_HOST'):
            logger.info(f"User {username} authenticated successfully with domain check.")
            return user
        else:
            logger.warning(f"Authentication failed for user {username}. Domain mismatch.")
        
        return None
