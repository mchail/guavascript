--- 
title: Zapier-to-Hipchat Webhooks in Rails with Resque
date: 20/02/2013

At [Perfect Audience](https://www.perfectaudience.com), we think the combination of [Zapier](http://www.zapier.com) + [Hipchat](http://www.hipchat.com) is the best thing since sliced arrays. Our team keeps several Hipchat channels open to provide us with realtime notification feeds - we see user signups, activations, deactivations, etc right as they happen. This gives us a real-world feel for what's happening day-to-day and allows us to act quickly if we see something has gone wrong.

We're also fans of [resque](https://github.com/defunkt/resque) for queueing up background work. It's dead-simple to get started with, and has a great admin interface to let you track performance and see job history (which is easily mountable right inside of your existing Rails app).

Let's create a resqued-Zapier-webhook that tells us when a user selects his/her favorite beer preference (this is not yet a real feature in Perfect Audience, but why not?). Here's how we do it:

## Prerequisites

- Sign up for [Zapier](http://www.zapier.com).
- Sign up for [Hipchat](http://www.hipchat.com).
- Configure Zapier to use your Hipchat account.

## Create the Zap

Zapier allows you to define custom, "webhook" zaps. These can work two ways: you can have Zapier post data to a webhook under your control, or you can post your own data to a randomly-assigned Zapier endpoint and configure Zapier to take the next step. In this post, we're setting up the latter configuration.

Getting started:

Copy off your webhook URL:

Defining a Hipchat channel:

Setting up your message:

Zapier will allow you to post any arbitrary data to their webhook and retrieve it in the message that is posted to Hipchat. This message says that Zapier should expect to see "name" and "favorite_beer" keys in the posted JSON. Our JSON will look something like this:

    {
        name: "Steve McHail",
        favorite_beer: "Dogfish Head 90 Minute"
    }

## Build a Zapier wrapper in Rails to background API calls

Make these modifications in your **Gemfile** to include resque and resque-history.

Put this file in **$RAILS_ROOT/config/** and call it **zap_ids.yml**. This file will hold your unique Zapier webhook IDs (the number at the end of the URL that looked like https://zapier.com/hooks/WebHookAPI/?sid=12345).

<script src="http://gist.github.com/4125771.js?file=zap_ids.yml"></script>

Put this file in **$RAILS_ROOT/config/initializers/** and call it **zapier_initializer.rb**. It loads up your Zapier webhook IDs into an object we will access later.

<script src="http://gist.github.com/4125771.js?file=zapier_initializer.rb"></script>

Put this file in **$RAILS_ROOT/app/workers/** and call it **zapier.rb**. This class handles the meat of our little project. It allows us to, in one line, queue up a zap to be processed by Resque, sent to Zapier, and ultimately displayed via Hipchat. That call might look as simple as **Zapier.zap(:channel, {key: :value})**.

<script src="http://gist.github.com/4125771.js?file=zapier.rb"></script>

Here is a slightly longer version continuing our example. This file goes in **$RAILS_ROOT/app/models/user.rb**.

<script src="http://gist.github.com/4125771.js?file=user.rb"></script>

You probably noticed that I'm triggering the **see_if_favorite_beer_changed** method using a Rails callback. The method uses ActiveRecord's "dirty" module to let us check if a certain attribute was changed before we commit the changes to the database.

Et, voila! Our message is processed by Resque and fed to Zapier, and we know right away as soon as one of our users is interested in a new beer.

This is a powerful pattern for us. Besides user actions, we use it to show us summary data after a long-running cron job completes. Our team processes a fair amount of data each day to populate our analytics dashboards. When the numbers have been crunched, Hipchat gives us a friendly message.

