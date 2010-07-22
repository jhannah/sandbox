from django.forms import ModelForm
from blog.models import Content

class TwitForm(ModelForm):
    class Meta:
        model = Content
        fields = ('headline', 'text')
