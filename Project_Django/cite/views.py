from django.shortcuts import render

from rest_framework import generics
from rest_framework import viewsets
from rest_framework import permissions
from rest_framework import status
from rest_framework import filters
from rest_framework.response import Response

from cite.serializers import *
from cite.models import *
from rest_framework.decorators import api_view, permission_classes

@api_view(['POST'])
@permission_classes((permissions.AllowAny,))
def create_user(request):

    if not 'password' in request.data:
        return Response({ "error": "password required" }, status=status.HTTP_400_BAD_REQUEST)

    serialized = CUserSerializer(data=request.data)
    if serialized.is_valid():
        gsuser = CUser(**request.data)
        gsuser.set_password(request.data['password'])
        gsuser.save()

        return Response(serialized.data, status=status.HTTP_201_CREATED)
    else:
        return Response(serialized._errors, status=status.HTTP_400_BAD_REQUEST)

class CUserViewSet(viewsets.ModelViewSet):
    queryset = CUser.objects.all()
    permission_classes = (permissions.IsAuthenticatedOrReadOnly,)

#    def get_serializer_class(self):
#        return CUserSerializer
#
#    def perform_create(self, serializer):
#        serializer.save()
#
#    def create(self, request, *args, **kwargs):
#        serializer = self.get_serializer(data=request.data)
#        if serializer.is_valid(raise_exception=True):
#            gsuser = CUser(**request.data)
#            gsuser.set_password(request.data['password'])
#            gsuser.save()
#
#            headers = self.get_success_headers(serializer.data)
#            return Response(serializer.data, status=status.HTTP_201_CREATED, headers=headers)
#        else:
#            return Response(serialized._errors, status=status.HTTP_400_BAD_REQUEST)


class CQuoteViewSet(viewsets.ModelViewSet):
    permission_classes = (permissions.IsAuthenticatedOrReadOnly,)

    def get_queryset(self):
        """
        This view should return a list of all the purchases
        for the currently authenticated user.
        """
        user = self.request.user
        return CQuote.objects.filter(owner__pk=user.pk)

    def get_serializer_class(self):
        return CQuoteSerializer

class CHashTagViewSet(viewsets.ModelViewSet):
    queryset = CHashTag.objects.all()
    permission_classes = (permissions.IsAuthenticatedOrReadOnly,)

    def get_serializer_class(self):
        return CHashTagSerializer
