from cite.storage import RandomFilenameFileSystemStorage
from django.contrib.auth.models import User
from django.db import models

class GSFileSystemStorage(RandomFilenameFileSystemStorage):
    def __init__(self, **kwargs):
        super(GSFileSystemStorage, self).__init__(**kwargs)
        self.location = '/tmp/djangoz'
        self.base_url = '/xyz/'
        self.file_permissions_mode = None
        self.directory_permissions_mode = None

class CUser(User):
    user   = models.OneToOneField('auth.User', parent_link=True, on_delete=models.CASCADE)
    avatar = models.ImageField(blank=True, storage=GSFileSystemStorage())

class CHashTag(models.Model):
    tag = models.CharField(max_length=500)

class CQuote(models.Model):
    quote = models.CharField(max_length=500)
    author = models.CharField(max_length=500)
    owner = models.ForeignKey(CUser, null=True, blank=True, related_name='owned_quotes')
    likers = models.ManyToManyField(CUser, related_name='liked_quotes')
    hashtags = models.ManyToManyField(CHashTag)
