# The idea here is that if we graphed the curve of ticket sales leading
# up to BarCamp events, we could better predict in advance the scaling
# of catering we need for early talks with vendors (food, t-shirts, etc.).
# If we can gather our historical data somehow, we could turn this into a real
# program that actually does useful things.

# ---
# Currently we're using OpenCollective to sell tickets. They have a nice and easy way
# to extract ticket sales history per event:

# 2022-08-20 Omaha
curl -s https://opencollective.com/barcamp-omaha-2022-location-tbd-6df56ef2/members/all.json | jq -c '.[] | select(.role == "ATTENDEE") | [ .createdAt, .totalAmountDonated, .name ]'
# 50 rows

# 2020-03-28 Lincoln
curl -s https://opencollective.com/barcamp-lincoln-2020-ffe4c560/members/all.json | jq -c '.[] | select(.role == "ATTENDEE") | [ .createdAt, .totalAmountDonated, .name ]'
# 13 rows. Oof, presumably a lot more people than this attended? Where's the data actually?

# 2019-11-09 Omaha
curl -s https://opencollective.com/barcamp-omaha-2019-at-kaneko-on-november-9th-52953ev/members/all.json | jq -c '.[] | select(.role == "ATTENDEE") | [ .createdAt, .totalAmountDonated, .name ]'
# 2 rows, 0 ATTENDEEs. Oops. Data is in Eventbrite?

# ---
# Before 2022 we were using Eventbrite for ticket sales.
# Anyone an admin in Eventbrite and can export what date people bought how many tickets?
# e.g. https://www.eventbrite.com/e/barcamp-omaha-2019-tickets-66366823957 

