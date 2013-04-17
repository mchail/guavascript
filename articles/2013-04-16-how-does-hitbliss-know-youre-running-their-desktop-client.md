--- 
title: How Does Hitbliss Know You're Running Their Desktop Client?
date: 16/04/2013

[Hitbliss](http://www.hitbliss.com) is a new video streaming service. They have a fresh take on the ad-supported-movie-rental model; you watch the ads up front, earn money, and use your earnings to rent from their library. Their catalog is solid, so I've been giving their service a shot this month.

Hitbliss ships a native desktop app (a flash container) to stream the video content. Their website merely serves as a marketing page and catalog. When you browse the selections on [hitbliss.com](hitbliss.com), clicking on a "View in Hitbliss" link will either show the desktop app, if you have it running, or direct you to a download page. I was curious how the website knew whether I had the app open. Here's what I found.

Every movie detail page has a "View in Hitbliss" button. It looks like this:

![View in Hitbliss example](http://mchail.github.com/guavascript/images/view-in-hitbliss/view_in_hitbliss.png)

Here's the HTML behind that button:

<script src="https://gist.github.com/mchail/5400899.js?file=view_in_hitbliss.html"></script>

And the relevant javascript:

<script src="https://gist.github.com/mchail/5400899.js?file=is_hitbliss_running.js"></script>

So where does `window.is_client_running` come from? After a bit of frustration, I noticed something strange in the javascript console.

![Failed to load resource](http://mchail.github.com/guavascript/images/view-in-hitbliss/failed_to_load_resource.png)

Well, that's interesting. Why the heck is it making a request to `localhost`? Does this work when I'm running their desktop client?

*Boot up desktop client...*

Here's the source of `http://localhost:26843/client_is_running.js` when I have the desktop client running:

<script src="https://gist.github.com/mchail/5400899.js?file=client_is_running.js"></script>

Well, that's pretty interesting. Their desktop client runs a local server on port 26843 whose only job is to return a single line of javascript. Every page on hitbliss.com requests this script from localhost. If it's returned, the script adds a global variable to the browser. This variable is used as a conditional to decide whether the browser redirects to Hitbliss's own protocol (i.e. `hitbliss:i=6734`) or redirects the user to a download page.

Clever girl.