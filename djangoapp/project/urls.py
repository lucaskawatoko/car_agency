from django.conf import settings
from django.conf.urls.static import static
from django.contrib import admin
from django.urls import path, include
from django.shortcuts import redirect  # Importar a função redirect

urlpatterns = [
    path('', lambda request: redirect('cars:home')),  # Adicionando o redirecionamento
    path('admin/', admin.site.urls),
    path('cars/', include('apps.cars.urls')),
]

if settings.DEBUG:
    urlpatterns += static(
        settings.MEDIA_URL,
        document_root=settings.MEDIA_ROOT
    )
