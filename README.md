# Notepad

Version 2.0

Notepad in Ruby working from the console. The application was created in Ruby 3.1.2

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

Then use numbers to indicate the type of note you are creating.

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
