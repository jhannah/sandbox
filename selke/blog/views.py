# Create your views here.
from django.shortcuts import render_to_response, get_object_or_404
from django.http import HttpResponseRedirect
from blog.models import Content, Rating
from django.conf import settings
from django.core.paginator import Paginator, InvalidPage, EmptyPage
from django.core.urlresolvers import reverse
from django.template.context import RequestContext
from django.contrib.auth.models import User
from blog.forms import TwitForm


def index(request):
    # Startseite erstellen mit den letzten 5 Artikeln
    entryList = Content.objects.filter(type='article').order_by('-pubDate')[:5]
    tplDict = {'entryList': entryList}
    return render_to_response('index.tpl', tplDict, RequestContext(request))

def articleDetail(request, content_id):
    # Zeigt einen Artikel im Detail an
    # Auch Ratings werden beruecksichtigt
    content = get_object_or_404(Content, pk=content_id)
    ratings = content.rating_set.all()
    ratingCount = content.rating_set.count()
    
    # Durchschnitt der Bewertungen ermitteln
    ratingAverage = 0
    for rating in ratings:
        rating = str(rating.rating)
        ratingAverage += float(rating)

    # Summer der Ratings durch die Gesamtanzahl der Ratings dieses Objekts dividieren
    if ratingCount != 0:
        ratingAverage /= ratingCount

        # Ergebnis auf Zehntel runden
        ratingAverage = round(ratingAverage, 1)
    tplDict = {'entry': content, 'ratings': ratings, 'ratingAverage': ratingAverage}
    return render_to_response('article_detail.tpl', tplDict, RequestContext(request))

def articleList(request, page_id):
    # Gibt eine Artikelliste zurueck, arbeitet mit Pagination
    # Get Inhalte, ignoriere die, die schon auf der Startseite sind
    content = Content.objects.filter(type='article').order_by('-pubDate')[5:]
    # 5 Article per page
    paginator = Paginator(content, 5)

    # Ist page_id zu gross, zeige letzte Seite
    try:
        entryList = paginator.page(page_id)
    except (EmptyPage, InvalidPage):
        entryList = paginator.page(paginator.num_pages)

    # Beachten dass entryList diesmal ein Paginator Object ist,
    # die Eintrage befinden sich in entryList.object_list
    tplDict = {'entryList': entryList}
    return render_to_response('article_list.tpl', tplDict, RequestContext(request))

# Function to add a rating of an article to the database

def rate(request, content_id):
    article = get_object_or_404(Content, pk=content_id)
    selectedRate = request.POST['rate']
    article.rating_set.create(rating=selectedRate)
    article.save()

    return HttpResponseRedirect(reverse('codecocktail.blog.views.articleDetail', args=(article.id,)))

def userPage(request, user_name):
    user = get_object_or_404(User, username__iexact=user_name) 
    twits = user.content_set.filter(type='twit').order_by('-pubDate')
    articleCount = user.content_set.filter(type='article').count()
    tplDict = {'user':user, 'twits':twits, 'articleCount':articleCount}
    # Twit Form processing
    if request.user.is_authenticated() and request.user == user:
        if request.method == 'POST':
            form = TwitForm(request.POST)
            if form.is_valid():
                newTwit = form.save(commit=False)
                newTwit.type = 'twit'
                newTwit.save()
                newTwit.authors = [user]
                newTwit.save()
        form = TwitForm()
        tplDict['form'] = form
        
    return render_to_response('user_page.tpl', tplDict, RequestContext(request))
