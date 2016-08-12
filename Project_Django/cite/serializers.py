from django.conf import settings

from rest_framework import serializers
from django.contrib.auth.models import User
from .models import *

class CFriendSerializer(serializers.ModelSerializer):
    class Meta:
        model = CUser
        fields = ('pk', 'username', 'first_name', 'last_name', 'avatar')

class CUserSerializer(serializers.ModelSerializer):
    friends = CFriendSerializer(many=True, read_only=True)
    class Meta:
        model = CUser
        fields = ('pk', 'username', 'email', 'first_name', 'last_name', 'avatar', 'friends', 'is_superuser')

class CHashTagSerializer(serializers.ModelSerializer):
    class Meta:
        model = CHashTag
        fields = ('pk', 'tag')

class CQuoteSerializer(serializers.ModelSerializer):
    hashtags = CHashTagSerializer(many=True, read_only=True)
    likers = CUserSerializer(many=True, read_only=True)

    class Meta:
        model = CQuote
        fields = ('pk', 'quote', 'author', 'owner', 'likers', 'hashtags', 'created', 'modified')
