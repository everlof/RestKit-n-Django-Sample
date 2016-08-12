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
    avatar = models.ImageField(blank=True, storage=GSFileSystemStorage())
    friends = models.ManyToManyField(settings.AUTH_USER_MODEL, blank=True)

class CHashTag(models.Model):
    tag = models.CharField(max_length=500)

class CQuote(models.Model):
    quote = models.CharField(max_length=500)
    author = models.CharField(max_length=500)
    created = models.DateTimeField(editable=False)
    modified = models.DateTimeField()
    owner = models.ForeignKey(settings.AUTH_USER_MODEL, related_name='owned_quotes')
    likers = models.ManyToManyField(settings.AUTH_USER_MODEL, blank=True, related_name='liked_quotes')
    hashtags = models.ManyToManyField(CHashTag, blank=True)

    def save(self, *args, **kwargs):
        ''' On save, update timestamps '''
        if not self.id:
            self.created = timezone.now()
        self.modified = timezone.now()
        return super(models.Model, self).save(*args, **kwargs)
