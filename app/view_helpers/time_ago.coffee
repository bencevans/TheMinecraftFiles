hbs.registerHelper "time_ago", (date, size) ->
  
  # Inspired by https://github.com/elving/swag/blob/00b3213de4811c0f27cb46c89b8ddae6b2e15702/src/swag.dates.coffee#L94
  date = new Date(date)
  seconds = Math.floor((new Date() - date) / 1000)
  interval = Math.floor(seconds / 31536000)
  return interval + " years ago"  if interval > 1
  interval = Math.floor(seconds / 2592000)
  return interval + " months ago"  if interval > 1
  interval = Math.floor(seconds / 86400)
  return interval + " days ago"  if interval > 1
  interval = Math.floor(seconds / 3600)
  return interval + " hours ago"  if interval > 1
  interval = Math.floor(seconds / 60)
  return interval + " minutes ago"  if interval > 1
  if Math.floor(seconds) is 0
    "Just now"
  else
    Math.floor(seconds) + " seconds ago"

