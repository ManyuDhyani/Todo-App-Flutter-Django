from django.urls import path
from .views import TotoCreate, TotoUpdateDelete

urlpatterns = [
    path('', TotoCreate.as_view()),
    path('<int:pk>', TotoUpdateDelete.as_view()),
]