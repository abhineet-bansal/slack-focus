# Slack Focus

## The Problem
I keep my Slack notifications permanently turned off. Because of distractions in meetings, notification fatigue etc etc, you know the drill.

But I developed another bad habit as a result - FOMO. "Are there any messages waiting for my response that I can quickly take care of?", "Has that person I pinged responded back to me yet?", and the worst of all - "I am bored in this meeting, let me quickly catch-up on Slack!"

I ended up procrastinating on Slack. When I get some free time, instead of picking a task from my queue, I would open Slack, close Slack, open/close other bunch of apps, come back to Slack, and on and on...

## The Intended Approach
My intention is to "batch" slack responses so that I am doing the Slack-related work only a few times a day, and then not checking Slack for the rest of the time. That was the initial purpose of turning off notifications, right?

## The Solution
I first tried the Focus app. But I found myself retrofitting my use-case to their features, and I quickly realised we were not a great fit. I couldn't find anything else on the marketplace, so decided to write something from scratch.

I had these requirements:
1. Ability to spend 30 mins doing focused Slack work
2. Ability to open Slack for a short task, like 5 mins, to look at saved items, peek at Slack during a meeting if the participant sends me a link etc.
3. Anything other than the above two scenarios, the app would not let me use Slack.

## Slack Focus
This app has the following features:
* Ad hoc mode - whenever Slack is opened by clicking on the dock, it gets minimised after 2 seconds.
* Short Task mode - enabled manually by the user in the app. Allows Slack usage for 5 mins, after which Slack is auto-minimised.
* Focus mode - same thing as Short Task mode, except for 30 mins.
* When Slack is being used, the app shows a countdown timer in the menu bar.
* The app tracks the number of times each mode was accessed during the day.

My goal is to reduce the ad-hoc numbers to as low as possible. The other two modes are "intentional" and "mindful" usage of Slack.

Now waiting until I develop another, more complicated, bad habit. But until then, this seems to be working!