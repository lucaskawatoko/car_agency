from django.urls import path
from . import views

app_name = 'cars'  # Certifique-se de definir o app_name para usar no redirecionamento

urlpatterns = [
    path('home/', views.home, name='home'),
]
