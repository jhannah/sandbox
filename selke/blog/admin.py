from codecocktail.blog.models import Content, Category, Rating, UserProfile
from django.contrib import admin
from django.contrib.auth.admin import UserAdmin
from django.contrib.auth.models import User

# Modifications of the Content Admin interface for wysiwyg
class WysiwygContentOptions(admin.ModelAdmin):
    # Definition of the Fieldsets in the Admin-Change-Form
    fieldsets = [
        ('Article Content',    {'fields': ['headline','text']}),
    ('Article Type',    {'fields': ['type']}),
    ('Date information',    {'fields': ['pubDate'], 'classes': ['collapse']}),
    ('Glossary',        {'fields': ['categories','tags','authors']}),
    ('External Sources',    {'fields': ['source']}),
    ]

    # Defining the view of the Content change list
    list_display = ('headline','pubDate','type')
    list_filter = ['pubDate','type']
    search_fields = ['headline','text']
    date_hierarchy = 'pubDate'

    class Media:
        js = ('js/tinymce/tiny_mce.js',
              'js/tinymce/textareas.js',)
    

admin.site.register(Content, WysiwygContentOptions)

class CategoryAdmin(admin.ModelAdmin):
    fieldsets = [
        ('Category Name',    {'fields': ['name']}),
    ]

    # Defining the view of the Category change list
    list_display = ('name',)
    search_fields = ['name']

admin.site.register(Category, CategoryAdmin)

admin.site.register(Rating)

class UserProfileInline(admin.StackedInline):
    model = UserProfile
    fk_name = 'user'
    max_num = 1

class MyUserAdmin(UserAdmin):
    inlines = [UserProfileInline, ]

admin.site.unregister(User)
admin.site.register(User, MyUserAdmin)
