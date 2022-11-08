# Notepad

Version 2.0

Notepad in Ruby working from the console.

You will need SQLite3 installed to work.

You can create:

* memo
* link
* task

Recordings are saved to `notepad.sqlite` file

To create a new entry, run:

```
ruby new_post.rb
```

To read, run:

```
ruby read.rb
```

Reading options:

```
# type of posts to read (by default, any)
--type POST_TYPE

# show post with specific id
--id POST_ID

# limit entries to read
--limit NUMBER

# help
--h
```
