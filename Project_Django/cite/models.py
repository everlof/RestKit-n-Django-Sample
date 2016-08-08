from cite.storage import RandomFilenameFileSystemStorage
from django.contrib.auth.models import AbstractUser
from django.db import models
from django.conf import settings

class GSFileSystemStorage(RandomFilenameFileSystemStorage):
    def __init__(self, **kwargs):
        super(GSFileSystemStorage, self).__init__(**kwargs)
        self.location = '/tmp/djangoz'
        self.base_url = '/xyz/'
        self.file_permissions_mode = None
        self.directory_permissions_mode = None

class CUser(AbstractUser):
    #user   = models.OneToOneField('auth.User', parent_link=True, on_delete=models.CASCADE)
    avatar = models.ImageField(blank=True, storage=GSFileSystemStorage())

    REQUIRED_FIELDS = ['email']

class CHashTag(models.Model):
    tag = models.CharField(max_length=500)

class CQuote(models.Model):
    quote = models.CharField(max_length=500)
    author = models.CharField(max_length=500)
    owner = models.ForeignKey(settings.AUTH_USER_MODEL, null=True, blank=True, related_name='owned_quotes')
    likers = models.ManyToManyField(settings.AUTH_USER_MODEL, related_name='liked_quotes')
    hashtags = models.ManyToManyField(CHashTag)
