from django.shortcuts import render

from rest_framework import generics
from rest_framework import viewsets
from rest_framework import permissions
from rest_framework import status
from rest_framework import filters

from cite.serializers import *
from cite.models import *
from rest_framework.decorators import api_view

class CUserViewSet(viewsets.ModelViewSet):
    queryset = CUser.objects.all()
    permission_classes = (permissions.IsAuthenticatedOrReadOnly,)

    def get_serializer_class(self):
        if self.action == 'create':
            return CUserCreateSerializer
        else:
            return CUserSerializer

    def perform_create(self, serializer):
        serializer.save()

    def create(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)

        gsuser = CUser(**request.data)
        gsuser.set_password(request.data['password'])
        gsuser.save()

        headers = self.get_success_headers(serializer.data)
        return Response(serializer.data, status=status.HTTP_201_CREATED, headers=headers)

class CQuoteViewSet(viewsets.ModelViewSet):
    queryset = CQuote.objects.all()
    permission_classes = (permissions.IsAuthenticatedOrReadOnly,)

    def get_serializer_class(self):
        return CQuoteSerializer

class CHashTagViewSet(viewsets.ModelViewSet):
    queryset = CHashTag.objects.all()
    permission_classes = (permissions.IsAuthenticatedOrReadOnly,)

    def get_serializer_class(self):
        return CHashTagSerializer
