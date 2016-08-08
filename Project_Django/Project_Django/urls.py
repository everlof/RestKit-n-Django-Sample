"""Project_Django URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/1.10/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  url(r'^$', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  url(r'^$', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.conf.urls import url, include
    2. Add a URL to urlpatterns:  url(r'^blog/', include('blog.urls'))
"""
from django.conf.urls import url
from django.contrib import admin
from django.conf.urls import url, include
from django.conf.urls.static import static
from rest_framework.routers import DefaultRouter
from rest_framework.authtoken import views as authviews
from cite import views

router = DefaultRouter()
router.register(r'users', views.CUserViewSet, 'CUser')
router.register(r'quotes', views.CQuoteViewSet, 'CQuote')
router.register(r'hashtags', views.CHashTagViewSet, 'CHashTag')

urlpatterns = [
    url(r'^', include(router.urls)),
    url(r'^users/register', views.create_user),
    url(r'^me', views.me),
    url(r'^api-token-auth/', authviews.obtain_auth_token),
    url(r'^admin/', admin.site.urls),
    url(r'^api-auth/', include('rest_framework.urls', namespace='rest_framework'))
]
