from django.contrib.auth import get_user_model

def get_domain_from_request(request):
    return request.get_host()


def is_user_permitted(user, domain):
    # Check for any related models with a user field
    User = get_user_model()
    return User.objects.filter(id=user.id, domain=domain).exists()