--- 
title: Zapier-to-Hipchat Webhooks in Rails with Resque
date: 20/02/2013

At [Perfect Audience](https://www.perfectaudience.com), we think the combination of [Zapier](http://www.zapier.com) + [Hipchat](http://www.hipchat.com) is the best thing since sliced arrays. Our team keeps several Hipchat channels open to provide us with realtime notification feeds - we see user signups, activations, deactivations, etc right as they happen. This gives us a real-world feel for what's happening day-to-day and allows us to act quickly if we see something has gone wrong.

We're also fans of [resque](https://github.com/defunkt/resque) for queueing up background work. It's dead-simple to get started with, and has a great admin interface to let you track performance and see job history (which is easily mountable right inside of your existing Rails app).

Let's create a resqued-Zapier-webhook that tells us when a user selects his/her favorite beer preference (this is not yet a real feature in Perfect Audience, but why not?). Let's make a Zapchat. Here's how we do it:

## Prerequisites

- Sign up for [Zapier](http://www.zapier.com).
- Sign up for [Hipchat](http://www.hipchat.com).
- Configure Zapier to use your Hipchat account.

## Create the Zap

Zapier allows you to define custom, "webhook" zaps. These can work two ways: you can have Zapier post data to a webhook under your control, or you can post your own data to a randomly-assigned Zapier endpoint and configure Zapier to take the next step. In this post, we're setting up the latter configuration.

### Getting started:

We first need to define a new zap routing from a Zapier webhook to a Hipchat message. Your setup should look like this:

![define webhook endpoints](http://mchail.github.com/guavascript/images/zapier-hipchat/zap_endpoints.png)

### Copy off your webhook URL:

After creating your zap, you will be prompted to configure it. Copy your randomly-assigned webhook URL. We'll need this!

![get your webhook URL](http://mchail.github.com/guavascript/images/zapier-hipchat/webhook_url.png)

### Setting up your message:

The rest of your configuration should look something like this:

![define your message](http://mchail.github.com/guavascript/images/zapier-hipchat/zap_message_definition.png)

Zapier will allow you to post any arbitrary data to their webhook and retrieve it in the message that is posted to Hipchat. This message says that Zapier should expect to see "name" and "favorite_beer" keys in the posted JSON. Read more about using custom data in a Zapier webhook [here](https://zapier.com/blog/2012/11/24/how-use-zapier-webhooks/).

Our JSON payload for this example will look something like this:

<script src="http://gist.github.com/4125771.js?file=sample_json.json"></script>

## Build a Zapier wrapper in Rails to background API calls

Make these modifications in your **Gemfile** to include resque and resque-history. The resque-history gem will allow you to see a time-ordered list of recently-run tasks in the resque web interface. This is very handy for debugging.

<script src="http://gist.github.com/4125771.js?file=Gemfile"></script>

Put this file in **$RAILS_ROOT/config/** and call it **zap_ids.yml**. This file will hold your unique Zapier webhook IDs (the 'UjvN' at the end of the URL that looked like https://zapier.com/hooks/catch/n/UjvN).

<script src="http://gist.github.com/4125771.js?file=zap_ids.yml"></script>

Put this file in **$RAILS_ROOT/config/initializers/** and call it **zapier_initializer.rb**. It loads up your Zapier webhook IDs into a hash we will access later.

<script src="http://gist.github.com/4125771.js?file=zapier_initializer.rb"></script>

Put this file in **$RAILS_ROOT/app/workers/** and call it **zapier.rb**. This class handles the meat of our little project. It allows us to, in one line, queue up a zap to be processed by Resque, sent to Zapier, and ultimately displayed via Hipchat. That call might look as simple as **Zapier.zap(:channel, {key: :value})**.

<script src="http://gist.github.com/4125771.js?file=zapier.rb"></script>

All the structure is now in place to make firing a message off dead simple. Let's configure our User model to notify us when a user changes his/her favorite beer. This code will be added to **$RAILS_ROOT/app/models/user.rb**. Your User model will need **name** and **favorite_beer** attributes.

<script src="http://gist.github.com/4125771.js?file=user.rb"></script>

Et, voila! Our message is processed by Resque and fed to Zapier, and we know right away as soon as one of our users is interested in a new beer.

![final product](http://mchail.github.com/guavascript/images/zapier-hipchat/final_product.png)

This is a powerful pattern for us. We use it for more than just user action notifications; when a cron job completes, or new analytics are available from our data providers, we use zapchat to notify the team (often with included summary metrics). The chat log is cleaner and less obtrusive than email, and the notification chatrooms give us a great way to discuss new data right as it comes in.

Let me know how you use Zapier and Hipchat with your team!
