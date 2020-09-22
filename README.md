# Currency converter

Simple currency converter app, with a cron job to update the exchange rates daily.

Exchange rates are fetched from [OpenRates](https://openrates.io/) and stores in the database.

## About

This project was originally built with rails 3, in 2010. I recently upgraded it
to rails 6 just to get dependabot to shut up. I inlined all the javascript
instead of dealing with webpacker / sprockets. I didn't bother with rewriting
the code.
