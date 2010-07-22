from django.db import models
import datetime
from django.contrib.auth.models import User
from thirdparty.tagging.fields import TagField
from thirdparty.tagging.models import Tag
from codecocktail import settings

# Type of content choices
TYPE_OF_CONTENT = (
    ('article', 'Article'),
    ('twit', 'Twit'),
    ('link', 'Link'),
)

# Ratings
RATINGS = (
    ('1', '1'),
    ('2', '2'),
    ('3', '3'),
    ('4', '4'),
    ('5', '5'),
)

class Category(models.Model):
    name = models.CharField(max_length=255)

    def __unicode__(self):
        return self.name

class Content(models.Model):
    headline = models.CharField(max_length=255)
    text = models.TextField()
    pubDate = models.DateTimeField('Date published', editable=True, blank=True)
    source = models.URLField(blank=True)
    type = models.CharField(max_length=10, choices=TYPE_OF_CONTENT)
    # Links
    categories = models.ManyToManyField(Category, blank=True)
    tags = TagField()
    authors = models.ManyToManyField(User)

    def save(self, **kwargs):
        if not self.id:
            self.pubDate = datetime.datetime.now()
        super(Content,self).save()

    # Tagging methods
    def set_tags(self):
        Tag.objects.update_tags(self)

    def get_tags(self):
        return Tag.objects.get_for_object(self)

    def  __unicode__(self):
        return self.headline

    def wasPublishedToday(self):
        return self.pubDate.date() == datetime.date.today()

    def get_absolute_url(self):
        return settings.DOMAIN + 'blog/artikel/detail/' + str(self.id)


class Rating(models.Model):
    content = models.ForeignKey(Content)
    rating = models.IntegerField(choices=RATINGS)

    def __unicode__(self):
        return str(self.content)

class UserProfile(models.Model):
    # Extends the User model
    about = models.TextField()
    avatar = models.ImageField(upload_to='avatars')
    mainpage = models.TextField()
    user = models.ForeignKey(User, unique=True)
