from django.db import models
from django.utils import timezone
from django.contrib.auth.models import AbstractBaseUser, PermissionsMixin
from django.utils.translation import gettext_lazy as _
from .UserManager import MyUserManager


class MyUser(AbstractBaseUser, PermissionsMixin):
    email = models.EmailField(_('email address'), unique=True)
    domain = models.CharField(max_length=255)
    description = models.TextField()
    user_type = models.CharField(max_length=100)
    date_joined = models.DateTimeField(_('date joined'), default=timezone.now)


    is_active = models.BooleanField(default=True)
    is_staff = models.BooleanField(default=False)

    USERNAME_FIELD = 'email'
    REQUIRED_FIELDS = ['domain', 'description', 'user_type']  # Add other required fields

    objects = MyUserManager()

    def __str__(self):
        return self.email
    
    def save(self, *args, **kwargs):
        if not self.id:
            self.date_joined = timezone.now()
        return super().save(*args, **kwargs)
